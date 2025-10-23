import 'package:equatable/equatable.dart';
import '../../../core/models/ble_device.dart';

/// Events for device connection and service discovery
abstract class DeviceDetailEvent extends Equatable {
  const DeviceDetailEvent();

  @override
  List<Object?> get props => [];
}

/// Event to initialize with a device
class InitializeDeviceEvent extends DeviceDetailEvent {
  final BleDevice device;
  
  const InitializeDeviceEvent(this.device);
  
  @override
  List<Object> get props => [device];
}

/// Event to connect to the device
class ConnectToDeviceEvent extends DeviceDetailEvent {
  const ConnectToDeviceEvent();
}

/// Event to disconnect from the device
class DisconnectFromDeviceEvent extends DeviceDetailEvent {
  const DisconnectFromDeviceEvent();
}

/// Event to discover services for the connected device
class DiscoverServicesEvent extends DeviceDetailEvent {
  const DiscoverServicesEvent();
}

/// Event to read a characteristic
class ReadCharacteristicEvent extends DeviceDetailEvent {
  final String serviceUuid;
  final String characteristicUuid;
  
  const ReadCharacteristicEvent(this.serviceUuid, this.characteristicUuid);
  
  @override
  List<Object> get props => [serviceUuid, characteristicUuid];
}

/// Event when connection state changes
class ConnectionStateChangedEvent extends DeviceDetailEvent {
  final String connectionState;
  
  const ConnectionStateChangedEvent(this.connectionState);
  
  @override
  List<Object> get props => [connectionState];
}

/// Event to refresh device information (RSSI, etc.)
class RefreshDeviceInfoEvent extends DeviceDetailEvent {
  const RefreshDeviceInfoEvent();
}