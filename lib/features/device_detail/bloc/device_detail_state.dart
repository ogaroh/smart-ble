import 'package:equatable/equatable.dart';
import '../../../core/models/ble_device.dart';
import '../../../core/models/ble_models.dart';

/// Enum for manufacturer information status
enum ManufacturerInfoStatus {
  unavailable, // Not connected or service not found
  loading, // Currently reading manufacturer info
  available, // Successfully read manufacturer info
  error, // Error occurred while reading
}

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
  final ManufacturerInfoStatus manufacturerStatus;
  final String? manufacturerName;
  
  const DeviceDetailLoaded({
    required this.device,
    this.connectionState = BleConnectionState.disconnected,
    this.services = const [],
    this.errorMessage,
    this.manufacturerStatus = ManufacturerInfoStatus.unavailable,
    this.manufacturerName,
  });
  
  @override
  List<Object?> get props => [
        device,
        connectionState,
        services,
        errorMessage,
        manufacturerStatus,
        manufacturerName
      ];
  
  DeviceDetailLoaded copyWith({
    BleDevice? device,
    BleConnectionState? connectionState,
    List<BleServiceModel>? services,
    String? errorMessage,
    ManufacturerInfoStatus? manufacturerStatus,
    String? manufacturerName,
    bool clearError = false,
    bool clearManufacturer = false,
  }) {
    return DeviceDetailLoaded(
      device: device ?? this.device,
      connectionState: connectionState ?? this.connectionState,
      services: services ?? this.services,
      errorMessage: clearError ? null : (errorMessage ?? this.errorMessage),
      manufacturerStatus: manufacturerStatus ?? this.manufacturerStatus,
      manufacturerName: clearManufacturer
          ? null
          : (manufacturerName ?? this.manufacturerName),
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
    super.manufacturerStatus,
    super.manufacturerName,
  });
  
  @override
  DeviceDetailConnecting copyWith({
    BleDevice? device,
    BleConnectionState? connectionState,
    List<BleServiceModel>? services,
    String? errorMessage,
    ManufacturerInfoStatus? manufacturerStatus,
    String? manufacturerName,
    bool clearError = false,
    bool clearManufacturer = false,
  }) {
    return DeviceDetailConnecting(
      device: device ?? this.device,
      connectionState: connectionState ?? this.connectionState,
      services: services ?? this.services,
      errorMessage: clearError ? null : (errorMessage ?? this.errorMessage),
      manufacturerStatus: manufacturerStatus ?? this.manufacturerStatus,
      manufacturerName: clearManufacturer
          ? null
          : (manufacturerName ?? this.manufacturerName),
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
    super.manufacturerStatus,
    super.manufacturerName,
  });
  
  @override
  DeviceDetailConnected copyWith({
    BleDevice? device,
    BleConnectionState? connectionState,
    List<BleServiceModel>? services,
    String? errorMessage,
    ManufacturerInfoStatus? manufacturerStatus,
    String? manufacturerName,
    bool clearError = false,
    bool clearManufacturer = false,
  }) {
    return DeviceDetailConnected(
      device: device ?? this.device,
      connectionState: connectionState ?? this.connectionState,
      services: services ?? this.services,
      errorMessage: clearError ? null : (errorMessage ?? this.errorMessage),
      manufacturerStatus: manufacturerStatus ?? this.manufacturerStatus,
      manufacturerName: clearManufacturer
          ? null
          : (manufacturerName ?? this.manufacturerName),
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
    super.manufacturerStatus,
    super.manufacturerName,
  });
  
  @override
  DeviceDetailDisconnecting copyWith({
    BleDevice? device,
    BleConnectionState? connectionState,
    List<BleServiceModel>? services,
    String? errorMessage,
    ManufacturerInfoStatus? manufacturerStatus,
    String? manufacturerName,
    bool clearError = false,
    bool clearManufacturer = false,
  }) {
    return DeviceDetailDisconnecting(
      device: device ?? this.device,
      connectionState: connectionState ?? this.connectionState,
      services: services ?? this.services,
      errorMessage: clearError ? null : (errorMessage ?? this.errorMessage),
      manufacturerStatus: manufacturerStatus ?? this.manufacturerStatus,
      manufacturerName: clearManufacturer
          ? null
          : (manufacturerName ?? this.manufacturerName),
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
    super.manufacturerStatus,
    super.manufacturerName,
  });
  
  @override
  DeviceDetailDiscoveringServices copyWith({
    BleDevice? device,
    BleConnectionState? connectionState,
    List<BleServiceModel>? services,
    String? errorMessage,
    ManufacturerInfoStatus? manufacturerStatus,
    String? manufacturerName,
    bool clearError = false,
    bool clearManufacturer = false,
  }) {
    return DeviceDetailDiscoveringServices(
      device: device ?? this.device,
      connectionState: connectionState ?? this.connectionState,
      services: services ?? this.services,
      errorMessage: clearError ? null : (errorMessage ?? this.errorMessage),
      manufacturerStatus: manufacturerStatus ?? this.manufacturerStatus,
      manufacturerName: clearManufacturer
          ? null
          : (manufacturerName ?? this.manufacturerName),
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