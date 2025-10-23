import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/models/ble_models.dart';
import '../../../core/repositories/ble_repository.dart';
import 'device_detail_event.dart';
import 'device_detail_state.dart';

/// BLoC for managing device connection and service discovery
class DeviceDetailBloc extends Bloc<DeviceDetailEvent, DeviceDetailState> {
  final BleRepository _bleRepository;
  StreamSubscription<BleConnectionState>? _connectionSubscription;

  DeviceDetailBloc({BleRepository? bleRepository})
      : _bleRepository = bleRepository ?? BleRepository(),
        super(const DeviceDetailInitial()) {
    // Register event handlers
    on<InitializeDeviceEvent>(_onInitializeDevice);
    on<ConnectToDeviceEvent>(_onConnectToDevice);
    on<DisconnectFromDeviceEvent>(_onDisconnectFromDevice);
    on<DiscoverServicesEvent>(_onDiscoverServices);
    on<ReadCharacteristicEvent>(_onReadCharacteristic);
    on<ConnectionStateChangedEvent>(_onConnectionStateChanged);
    on<RefreshDeviceInfoEvent>(_onRefreshDeviceInfo);
  }

  /// Handle device initialization
  void _onInitializeDevice(
      InitializeDeviceEvent event, Emitter<DeviceDetailState> emit) {
    emit(DeviceDetailLoaded(device: event.device));

    // Listen to connection state changes
    _connectionSubscription = _bleRepository.connectionState.listen(
      (connectionState) {
        add(ConnectionStateChangedEvent(connectionState.displayName));
      },
      onError: (error) {
        if (state is DeviceDetailLoaded) {
          final currentState = state as DeviceDetailLoaded;
          emit(currentState.copyWith(errorMessage: 'Connection error: $error'));
        }
      },
    );
  }

  /// Handle connect to device event
  Future<void> _onConnectToDevice(
      ConnectToDeviceEvent event, Emitter<DeviceDetailState> emit) async {
    if (state is! DeviceDetailLoaded) return;

    final currentState = state as DeviceDetailLoaded;

    try {
      // Connect to device - the connection state stream will handle state updates
      await _bleRepository.connectToDevice(currentState.device);
    } catch (e) {
      emit(DeviceDetailError(
        'Failed to connect: $e',
        device: currentState.device,
        services: currentState.services,
      ));
    }
  }

  /// Handle disconnect from device event
  Future<void> _onDisconnectFromDevice(
      DisconnectFromDeviceEvent event, Emitter<DeviceDetailState> emit) async {
    if (state is! DeviceDetailLoaded) return;
    final currentState = state as DeviceDetailLoaded;

    try {
      // Disconnect from device - the connection state stream will handle state updates
      await _bleRepository.disconnectFromDevice();
    } catch (e) {
      emit(DeviceDetailError(
        'Failed to disconnect: $e',
        device: currentState.device,
        connectionState: currentState.connectionState,
        services: currentState.services,
      ));
    }
  }

  /// Handle discover services event
  Future<void> _onDiscoverServices(
      DiscoverServicesEvent event, Emitter<DeviceDetailState> emit) async {
    if (state is! DeviceDetailConnected) return;

    final currentState = state as DeviceDetailConnected;

    try {
      // Emit discovering services state
      emit(DeviceDetailDiscoveringServices(
        device: currentState.device,
        connectionState: currentState.connectionState,
        services: currentState.services,
      ));

      // Discover services
      final services = await _bleRepository.discoverServices();

      // Emit connected state with discovered services
      emit(DeviceDetailConnected(
        device: currentState.device,
        connectionState: currentState.connectionState,
        services: services,
      ));

      // Try to read manufacturer name if available
      _tryReadManufacturerName(services);
    } catch (e) {
      emit(DeviceDetailError(
        'Failed to discover services: $e',
        device: currentState.device,
        connectionState: BleConnectionState.connected,
        services: currentState.services,
      ));
    }
  }

  /// Handle read characteristic event
  Future<void> _onReadCharacteristic(
      ReadCharacteristicEvent event, Emitter<DeviceDetailState> emit) async {
    if (state is! DeviceDetailLoaded) return;

    final currentState = state as DeviceDetailLoaded;

    try {
      final value = await _bleRepository.readCharacteristic(
        event.serviceUuid,
        event.characteristicUuid,
      );

      // Update the characteristic with the read value
      final updatedServices = currentState.services.map((service) {
        if (service.uuid.toLowerCase() == event.serviceUuid.toLowerCase()) {
          final updatedCharacteristics =
              service.characteristics.map((characteristic) {
            if (characteristic.uuid.toLowerCase() ==
                event.characteristicUuid.toLowerCase()) {
              return characteristic.copyWith(value: value);
            }
            return characteristic;
          }).toList();

          return BleServiceModel(
            uuid: service.uuid,
            displayName: service.displayName,
            characteristics: updatedCharacteristics,
            isPrimary: service.isPrimary,
          );
        }
        return service;
      }).toList();

      // Emit updated state
      if (currentState is DeviceDetailConnected) {
        emit(
            currentState.copyWith(services: updatedServices, clearError: true));
      } else {
        emit(
            currentState.copyWith(services: updatedServices, clearError: true));
      }
    } catch (e) {
      emit(currentState.copyWith(
        errorMessage: 'Failed to read characteristic: $e',
      ));
    }
  }

  /// Handle connection state changed event
  void _onConnectionStateChanged(
      ConnectionStateChangedEvent event, Emitter<DeviceDetailState> emit) {
    if (state is! DeviceDetailLoaded) return;

    final currentState = state as DeviceDetailLoaded;

    // Map string back to enum
    BleConnectionState connectionState;
    switch (event.connectionState) {
      case 'Connected':
        connectionState = BleConnectionState.connected;
        break;
      case 'Connecting...':
        connectionState = BleConnectionState.connecting;
        break;
      case 'Disconnecting...':
        connectionState = BleConnectionState.disconnecting;
        break;
      default:
        connectionState = BleConnectionState.disconnected;
    }

    // Emit appropriate state based on connection state
    switch (connectionState) {
      case BleConnectionState.connected:
        emit(DeviceDetailConnected(
          device: currentState.device,
          connectionState: connectionState,
          services: currentState.services,
        ));

        // Auto-discover services when connected
        if (currentState.services.isEmpty) {
          add(const DiscoverServicesEvent());
        }
        break;

      case BleConnectionState.connecting:
        emit(DeviceDetailConnecting(
          device: currentState.device,
          connectionState: connectionState,
          services: currentState.services,
        ));
        break;

      case BleConnectionState.disconnecting:
        emit(DeviceDetailDisconnecting(
          device: currentState.device,
          connectionState: connectionState,
          services: currentState.services,
        ));
        break;

      case BleConnectionState.disconnected:
        emit(DeviceDetailLoaded(
          device: currentState.device,
          connectionState: connectionState,
          services: [], // Clear services when disconnected
        ));
        break;
    }
  }

  /// Handle refresh device info event
  void _onRefreshDeviceInfo(
      RefreshDeviceInfoEvent event, Emitter<DeviceDetailState> emit) {
    if (state is! DeviceDetailLoaded) return;

    final currentState = state as DeviceDetailLoaded;

    // For now, just clear any error messages
    // In a real app, you might want to refresh RSSI or other device info
    if (currentState.errorMessage != null) {
      if (currentState is DeviceDetailConnected) {
        emit(currentState.copyWith(clearError: true));
      } else {
        emit(currentState.copyWith(clearError: true));
      }
    }
  }

  /// Try to automatically read manufacturer name from Device Information service
  void _tryReadManufacturerName(List<BleServiceModel> services) {
    try {
      // Look for Device Information Service (0x180A)
      final deviceInfoService = services.firstWhere(
        (service) => service.uuid.toLowerCase().contains('180a'),
      );

      // Look for Manufacturer Name String characteristic (0x2A29)
      final manufacturerCharacteristic =
          deviceInfoService.characteristics.firstWhere(
        (characteristic) => characteristic.uuid.toLowerCase().contains('2a29'),
      );

      // Read the characteristic
      add(ReadCharacteristicEvent(
          deviceInfoService.uuid, manufacturerCharacteristic.uuid));
    } catch (e) {
      // Service or characteristic not found - this is normal for many devices
      // Don't emit an error for this
    }
  }

  /// Check if device is connected
  bool get isConnected {
    if (state is DeviceDetailLoaded) {
      final currentState = state as DeviceDetailLoaded;
      return currentState.connectionState == BleConnectionState.connected;
    }
    return false;
  }

  /// Check if currently connecting
  bool get isConnecting {
    if (state is DeviceDetailLoaded) {
      final currentState = state as DeviceDetailLoaded;
      return currentState.connectionState == BleConnectionState.connecting;
    }
    return false;
  }

  /// Check if currently disconnecting
  bool get isDisconnecting {
    if (state is DeviceDetailLoaded) {
      final currentState = state as DeviceDetailLoaded;
      return currentState.connectionState == BleConnectionState.disconnecting;
    }
    return false;
  }

  @override
  Future<void> close() async {
    await _connectionSubscription?.cancel();
    return super.close();
  }
}
