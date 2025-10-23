import 'package:equatable/equatable.dart';
import '../../../core/models/ble_device.dart';

/// States for BLE scanning
abstract class BleScanState extends Equatable {
  const BleScanState();

  @override
  List<Object?> get props => [];
}

/// Initial state
class BleScanInitial extends BleScanState {
  const BleScanInitial();
}

/// State when checking Bluetooth permissions and status
class BleScanCheckingPermissions extends BleScanState {
  const BleScanCheckingPermissions();
}

/// State when Bluetooth permissions are denied
class BleScanPermissionsDenied extends BleScanState {
  final String message;
  
  const BleScanPermissionsDenied(this.message);
  
  @override
  List<Object> get props => [message];
}

/// State when Bluetooth is not available
class BleScanBluetoothUnavailable extends BleScanState {
  final String message;
  
  const BleScanBluetoothUnavailable(this.message);
  
  @override
  List<Object> get props => [message];
}

/// State when ready to scan (Bluetooth on, permissions granted)
class BleScanReady extends BleScanState {
  final List<BleDevice> devices;
  final List<BleDevice> filteredDevices;
  final String nameFilter;
  final BleDeviceType? typeFilter;
  
  const BleScanReady({
    this.devices = const [],
    this.filteredDevices = const [],
    this.nameFilter = '',
    this.typeFilter,
  });
  
  @override
  List<Object?> get props => [devices, filteredDevices, nameFilter, typeFilter];
  
  BleScanReady copyWith({
    List<BleDevice>? devices,
    List<BleDevice>? filteredDevices,
    String? nameFilter,
    BleDeviceType? typeFilter,
    bool clearTypeFilter = false,
  }) {
    return BleScanReady(
      devices: devices ?? this.devices,
      filteredDevices: filteredDevices ?? this.filteredDevices,
      nameFilter: nameFilter ?? this.nameFilter,
      typeFilter: clearTypeFilter ? null : (typeFilter ?? this.typeFilter),
    );
  }
}

/// State when actively scanning for devices
class BleScanScanning extends BleScanReady {
  const BleScanScanning({
    super.devices,
    super.filteredDevices,
    super.nameFilter,
    super.typeFilter,
  });
  
  @override
  BleScanScanning copyWith({
    List<BleDevice>? devices,
    List<BleDevice>? filteredDevices,
    String? nameFilter,
    BleDeviceType? typeFilter,
    bool clearTypeFilter = false,
  }) {
    return BleScanScanning(
      devices: devices ?? this.devices,
      filteredDevices: filteredDevices ?? this.filteredDevices,
      nameFilter: nameFilter ?? this.nameFilter,
      typeFilter: clearTypeFilter ? null : (typeFilter ?? this.typeFilter),
    );
  }
}

/// State when an error occurs
class BleScanError extends BleScanState {
  final String message;
  final List<BleDevice> devices;
  final List<BleDevice> filteredDevices;
  final String nameFilter;
  final BleDeviceType? typeFilter;
  
  const BleScanError(
    this.message, {
    this.devices = const [],
    this.filteredDevices = const [],
    this.nameFilter = '',
    this.typeFilter,
  });
  
  @override
  List<Object?> get props => [message, devices, filteredDevices, nameFilter, typeFilter];
}