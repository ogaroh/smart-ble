import 'package:equatable/equatable.dart';
import '../../../core/models/ble_device.dart';

/// Events for BLE scanning
abstract class BleScanEvent extends Equatable {
  const BleScanEvent();

  @override
  List<Object?> get props => [];
}

/// Event to start scanning for BLE devices
class StartScanEvent extends BleScanEvent {
  final Duration? timeout;
  
  const StartScanEvent({this.timeout});
  
  @override
  List<Object?> get props => [timeout];
}

/// Event to stop scanning for BLE devices
class StopScanEvent extends BleScanEvent {
  const StopScanEvent();
}

/// Event to update the device filter
class UpdateFilterEvent extends BleScanEvent {
  final String filter;
  
  const UpdateFilterEvent(this.filter);
  
  @override
  List<Object> get props => [filter];
}

/// Event to update the device type filter
class UpdateDeviceTypeFilterEvent extends BleScanEvent {
  final BleDeviceType? deviceType;
  
  const UpdateDeviceTypeFilterEvent(this.deviceType);
  
  @override
  List<Object?> get props => [deviceType];
}

/// Event when new devices are discovered during scanning
class DevicesDiscoveredEvent extends BleScanEvent {
  final List<BleDevice> devices;
  
  const DevicesDiscoveredEvent(this.devices);
  
  @override
  List<Object> get props => [devices];
}

/// Event to clear discovered devices
class ClearDevicesEvent extends BleScanEvent {
  const ClearDevicesEvent();
}

/// Event to refresh permissions and Bluetooth status
class RefreshBluetoothStatusEvent extends BleScanEvent {
  const RefreshBluetoothStatusEvent();
}