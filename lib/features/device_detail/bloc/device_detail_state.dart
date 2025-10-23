import 'package:equatable/equatable.dart';
import '../../../core/models/ble_device.dart';
import '../../../core/models/ble_models.dart';

/// States for device connection and service discovery
abstract class DeviceDetailState extends Equatable {
  const DeviceDetailState();

  @override
  List<Object?> get props => [];
}

/// Initial state
class DeviceDetailInitial extends DeviceDetailState {
  const DeviceDetailInitial();
}

/// State when device is loaded but not connected
class DeviceDetailLoaded extends DeviceDetailState {
  final BleDevice device;
  final BleConnectionState connectionState;
  final List<BleServiceModel> services;
  final String? errorMessage;
  
  const DeviceDetailLoaded({
    required this.device,
    this.connectionState = BleConnectionState.disconnected,
    this.services = const [],
    this.errorMessage,
  });
  
  @override
  List<Object?> get props => [device, connectionState, services, errorMessage];
  
  DeviceDetailLoaded copyWith({
    BleDevice? device,
    BleConnectionState? connectionState,
    List<BleServiceModel>? services,
    String? errorMessage,
    bool clearError = false,
  }) {
    return DeviceDetailLoaded(
      device: device ?? this.device,
      connectionState: connectionState ?? this.connectionState,
      services: services ?? this.services,
      errorMessage: clearError ? null : (errorMessage ?? this.errorMessage),
    );
  }
}

/// State when connecting to device
class DeviceDetailConnecting extends DeviceDetailLoaded {
  const DeviceDetailConnecting({
    required super.device,
    super.connectionState = BleConnectionState.connecting,
    super.services,
    super.errorMessage,
  });
  
  @override
  DeviceDetailConnecting copyWith({
    BleDevice? device,
    BleConnectionState? connectionState,
    List<BleServiceModel>? services,
    String? errorMessage,
    bool clearError = false,
  }) {
    return DeviceDetailConnecting(
      device: device ?? this.device,
      connectionState: connectionState ?? this.connectionState,
      services: services ?? this.services,
      errorMessage: clearError ? null : (errorMessage ?? this.errorMessage),
    );
  }
}

/// State when connected to device
class DeviceDetailConnected extends DeviceDetailLoaded {
  const DeviceDetailConnected({
    required super.device,
    super.connectionState = BleConnectionState.connected,
    super.services,
    super.errorMessage,
  });
  
  @override
  DeviceDetailConnected copyWith({
    BleDevice? device,
    BleConnectionState? connectionState,
    List<BleServiceModel>? services,
    String? errorMessage,
    bool clearError = false,
  }) {
    return DeviceDetailConnected(
      device: device ?? this.device,
      connectionState: connectionState ?? this.connectionState,
      services: services ?? this.services,
      errorMessage: clearError ? null : (errorMessage ?? this.errorMessage),
    );
  }
}

/// State when disconnecting from device
class DeviceDetailDisconnecting extends DeviceDetailLoaded {
  const DeviceDetailDisconnecting({
    required super.device,
    super.connectionState = BleConnectionState.disconnecting,
    super.services,
    super.errorMessage,
  });
  
  @override
  DeviceDetailDisconnecting copyWith({
    BleDevice? device,
    BleConnectionState? connectionState,
    List<BleServiceModel>? services,
    String? errorMessage,
    bool clearError = false,
  }) {
    return DeviceDetailDisconnecting(
      device: device ?? this.device,
      connectionState: connectionState ?? this.connectionState,
      services: services ?? this.services,
      errorMessage: clearError ? null : (errorMessage ?? this.errorMessage),
    );
  }
}

/// State when discovering services
class DeviceDetailDiscoveringServices extends DeviceDetailConnected {
  const DeviceDetailDiscoveringServices({
    required super.device,
    super.connectionState,
    super.services,
    super.errorMessage,
  });
  
  @override
  DeviceDetailDiscoveringServices copyWith({
    BleDevice? device,
    BleConnectionState? connectionState,
    List<BleServiceModel>? services,
    String? errorMessage,
    bool clearError = false,
  }) {
    return DeviceDetailDiscoveringServices(
      device: device ?? this.device,
      connectionState: connectionState ?? this.connectionState,
      services: services ?? this.services,
      errorMessage: clearError ? null : (errorMessage ?? this.errorMessage),
    );
  }
}

/// State when an error occurs
class DeviceDetailError extends DeviceDetailState {
  final String message;
  final BleDevice? device;
  final BleConnectionState connectionState;
  final List<BleServiceModel> services;
  
  const DeviceDetailError(
    this.message, {
    this.device,
    this.connectionState = BleConnectionState.disconnected,
    this.services = const [],
  });
  
  @override
  List<Object?> get props => [message, device, connectionState, services];
}