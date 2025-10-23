import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/models/ble_device.dart';
import '../../../core/repositories/ble_repository.dart';
import 'ble_scan_event.dart';
import 'ble_scan_state.dart';

/// BLoC for managing BLE scanning functionality
class BleScanBloc extends Bloc<BleScanEvent, BleScanState> {
  final BleRepository _bleRepository;
  StreamSubscription<List<BleDevice>>? _scanSubscription;

  BleScanBloc({BleRepository? bleRepository})
      : _bleRepository = bleRepository ?? BleRepository(),
        super(const BleScanInitial()) {
    // Register event handlers
    on<StartScanEvent>(_onStartScan);
    on<StopScanEvent>(_onStopScan);
    on<UpdateFilterEvent>(_onUpdateFilter);
    on<UpdateDeviceTypeFilterEvent>(_onUpdateDeviceTypeFilter);
    on<DevicesDiscoveredEvent>(_onDevicesDiscovered);
    on<ClearDevicesEvent>(_onClearDevices);
    on<RefreshBluetoothStatusEvent>(_onRefreshBluetoothStatus);

    // Initialize by checking Bluetooth status
    add(const RefreshBluetoothStatusEvent());
  }

  /// Handle start scan event
  Future<void> _onStartScan(
      StartScanEvent event, Emitter<BleScanState> emit) async {
    try {
      // Check if we're in a ready state
      if (state is! BleScanReady) {
        add(const RefreshBluetoothStatusEvent());
        return;
      }

      final currentState = state as BleScanReady;

      // Emit scanning state
      emit(BleScanScanning(
        devices: currentState.devices,
        filteredDevices: currentState.filteredDevices,
        nameFilter: currentState.nameFilter,
        typeFilter: currentState.typeFilter,
      ));

      // Listen to scan results
      _scanSubscription = _bleRepository.scanResults.listen(
        (devices) {
          add(DevicesDiscoveredEvent(devices));
        },
        onError: (error) {
          emit(BleScanError(
            'Scan error: $error',
            devices: currentState.devices,
            filteredDevices: currentState.filteredDevices,
            nameFilter: currentState.nameFilter,
            typeFilter: currentState.typeFilter,
          ));
        },
      );

      // Start scanning
      await _bleRepository.startScan(timeout: event.timeout);
    } catch (e) {
      final currentState = state;
      if (currentState is BleScanReady) {
        emit(BleScanError(
          'Failed to start scan: $e',
          devices: currentState.devices,
          filteredDevices: currentState.filteredDevices,
          nameFilter: currentState.nameFilter,
          typeFilter: currentState.typeFilter,
        ));
      } else {
        emit(BleScanError('Failed to start scan: $e'));
      }
    }
  }

  /// Handle stop scan event
  Future<void> _onStopScan(
      StopScanEvent event, Emitter<BleScanState> emit) async {
    try {
      await _scanSubscription?.cancel();
      _scanSubscription = null;

      await _bleRepository.stopScan();

      // Return to ready state if we were scanning
      if (state is BleScanScanning) {
        final currentState = state as BleScanScanning;
        emit(BleScanReady(
          devices: currentState.devices,
          filteredDevices: currentState.filteredDevices,
          nameFilter: currentState.nameFilter,
          typeFilter: currentState.typeFilter,
        ));
      }
    } catch (e) {
      final currentState = state;
      if (currentState is BleScanReady) {
        emit(BleScanError(
          'Failed to stop scan: $e',
          devices: currentState.devices,
          filteredDevices: currentState.filteredDevices,
          nameFilter: currentState.nameFilter,
          typeFilter: currentState.typeFilter,
        ));
      } else {
        emit(BleScanError('Failed to stop scan: $e'));
      }
    }
  }

  /// Handle filter update event
  void _onUpdateFilter(UpdateFilterEvent event, Emitter<BleScanState> emit) {
    if (state is BleScanReady) {
      final currentState = state as BleScanReady;
      final filteredDevices = _applyFilters(
        currentState.devices,
        event.filter,
        currentState.typeFilter,
      );

      if (currentState is BleScanScanning) {
        emit(currentState.copyWith(
          nameFilter: event.filter,
          filteredDevices: filteredDevices,
        ));
      } else {
        emit(currentState.copyWith(
          nameFilter: event.filter,
          filteredDevices: filteredDevices,
        ));
      }
    }
  }

  /// Handle device type filter update event
  void _onUpdateDeviceTypeFilter(
      UpdateDeviceTypeFilterEvent event, Emitter<BleScanState> emit) {
    if (state is BleScanReady) {
      final currentState = state as BleScanReady;
      final filteredDevices = _applyFilters(
        currentState.devices,
        currentState.nameFilter,
        event.deviceType,
      );

      if (currentState is BleScanScanning) {
        emit(currentState.copyWith(
          typeFilter: event.deviceType,
          filteredDevices: filteredDevices,
          clearTypeFilter: event.deviceType == null,
        ));
      } else {
        emit(currentState.copyWith(
          typeFilter: event.deviceType,
          filteredDevices: filteredDevices,
          clearTypeFilter: event.deviceType == null,
        ));
      }
    }
  }

  /// Handle devices discovered event
  void _onDevicesDiscovered(
      DevicesDiscoveredEvent event, Emitter<BleScanState> emit) {
    if (state is BleScanReady) {
      final currentState = state as BleScanReady;
      final filteredDevices = _applyFilters(
        event.devices,
        currentState.nameFilter,
        currentState.typeFilter,
      );

      if (currentState is BleScanScanning) {
        emit(currentState.copyWith(
          devices: event.devices,
          filteredDevices: filteredDevices,
        ));
      } else {
        emit(currentState.copyWith(
          devices: event.devices,
          filteredDevices: filteredDevices,
        ));
      }
    }
  }

  /// Handle clear devices event
  void _onClearDevices(ClearDevicesEvent event, Emitter<BleScanState> emit) {
    _bleRepository.clearDiscoveredDevices();

    if (state is BleScanReady) {
      final currentState = state as BleScanReady;

      if (currentState is BleScanScanning) {
        emit(currentState.copyWith(
          devices: [],
          filteredDevices: [],
        ));
      } else {
        emit(currentState.copyWith(
          devices: [],
          filteredDevices: [],
        ));
      }
    }
  }

  /// Handle refresh Bluetooth status event
  Future<void> _onRefreshBluetoothStatus(
      RefreshBluetoothStatusEvent event, Emitter<BleScanState> emit) async {
    emit(const BleScanCheckingPermissions());

    try {
      // Check if Bluetooth is available
      final isAvailable = await _bleRepository.isBluetoothAvailable();
      if (!isAvailable) {
        emit(const BleScanBluetoothUnavailable(
            'Bluetooth is not available on this device'));
        return;
      }

      // Check permissions
      final hasPermissions = await _bleRepository.requestPermissions();
      if (!hasPermissions) {
        emit(const BleScanPermissionsDenied(
            'Bluetooth permissions are required to scan for devices'));
        return;
      }

      // Check if Bluetooth is enabled
      final isOn = await _bleRepository.isBluetoothOn();
      if (!isOn) {
        await _bleRepository.turnOnBluetooth();
        _onRefreshBluetoothStatus(event, emit);
      }

      // All checks passed - ready to scan
      final devices = _bleRepository.discoveredDevices;
      emit(BleScanReady(
        devices: devices,
        filteredDevices: devices,
      ));
    } catch (e) {
      emit(BleScanError('Failed to check Bluetooth status: $e'));
    }
  }

  /// Apply name and type filters to device list
  List<BleDevice> _applyFilters(
    List<BleDevice> devices,
    String nameFilter,
    BleDeviceType? typeFilter,
  ) {
    var filtered = devices;

    // Apply name filter
    if (nameFilter.isNotEmpty) {
      filtered = filtered
          .where((device) =>
              device.name.toLowerCase().contains(nameFilter.toLowerCase()))
          .toList();
    }

    // Apply type filter
    if (typeFilter != null) {
      filtered =
          filtered.where((device) => device.deviceType == typeFilter).toList();
    }

    return filtered;
  }

  /// Get whether currently scanning
  bool get isScanning => _bleRepository.isScanning;

  @override
  Future<void> close() async {
    await _scanSubscription?.cancel();
    return super.close();
  }
}
