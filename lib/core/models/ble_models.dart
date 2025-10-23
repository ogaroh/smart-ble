import 'package:equatable/equatable.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';

/// Enum representing different connection states
enum BleConnectionState {
  disconnected,
  connecting,
  connected,
  disconnecting,
}

/// Model representing a BLE service
class BleServiceModel extends Equatable {
  final String uuid;
  final String displayName;
  final List<BleCharacteristicModel> characteristics;
  final bool isPrimary;

  const BleServiceModel({
    required this.uuid,
    required this.displayName,
    required this.characteristics,
    this.isPrimary = true,
  });

  /// Create BleServiceModel from flutter_blue_plus BluetoothService
  factory BleServiceModel.fromBluetoothService(BluetoothService service) {
    final characteristics = service.characteristics
        .map((char) => BleCharacteristicModel.fromBluetoothCharacteristic(char))
        .toList();

    return BleServiceModel(
      uuid: service.uuid.toString(),
      displayName: _getServiceDisplayName(service.uuid.toString()),
      characteristics: characteristics,
      isPrimary: service.isPrimary,
    );
  }

  /// Get display name for common service UUIDs
  static String _getServiceDisplayName(String uuid) {
    final uuidLower = uuid.toLowerCase();
    
    // Common service UUIDs
    if (uuidLower.contains('180a')) return 'Device Information';
    if (uuidLower.contains('180f')) return 'Battery Service';
    if (uuidLower.contains('1800')) return 'Generic Access';
    if (uuidLower.contains('1801')) return 'Generic Attribute';
    if (uuidLower.contains('181c')) return 'User Data';
    if (uuidLower.contains('110b')) return 'Audio Sink';
    if (uuidLower.contains('110a')) return 'Audio Source';
    
    return 'Service ${uuid.substring(0, 8)}...'; // Show first 8 characters
  }

  @override
  List<Object?> get props => [uuid, displayName, characteristics, isPrimary];
}

/// Model representing a BLE characteristic
class BleCharacteristicModel extends Equatable {
  final String uuid;
  final String displayName;
  final List<BleCharacteristicProperty> properties;
  final List<int>? value;

  const BleCharacteristicModel({
    required this.uuid,
    required this.displayName,
    required this.properties,
    this.value,
  });

  /// Create BleCharacteristicModel from flutter_blue_plus BluetoothCharacteristic
  factory BleCharacteristicModel.fromBluetoothCharacteristic(BluetoothCharacteristic characteristic) {
    final properties = <BleCharacteristicProperty>[];
    
    if (characteristic.properties.read) properties.add(BleCharacteristicProperty.read);
    if (characteristic.properties.write) properties.add(BleCharacteristicProperty.write);
    if (characteristic.properties.writeWithoutResponse) properties.add(BleCharacteristicProperty.writeWithoutResponse);
    if (characteristic.properties.notify) properties.add(BleCharacteristicProperty.notify);
    if (characteristic.properties.indicate) properties.add(BleCharacteristicProperty.indicate);

    return BleCharacteristicModel(
      uuid: characteristic.uuid.toString(),
      displayName: _getCharacteristicDisplayName(characteristic.uuid.toString()),
      properties: properties,
    );
  }

  /// Get display name for common characteristic UUIDs
  static String _getCharacteristicDisplayName(String uuid) {
    final uuidLower = uuid.toLowerCase();
    
    // Common characteristic UUIDs
    if (uuidLower.contains('2a29')) return 'Manufacturer Name';
    if (uuidLower.contains('2a24')) return 'Model Number';
    if (uuidLower.contains('2a25')) return 'Serial Number';
    if (uuidLower.contains('2a27')) return 'Hardware Revision';
    if (uuidLower.contains('2a26')) return 'Firmware Revision';
    if (uuidLower.contains('2a28')) return 'Software Revision';
    if (uuidLower.contains('2a19')) return 'Battery Level';
    if (uuidLower.contains('2a00')) return 'Device Name';
    if (uuidLower.contains('2a01')) return 'Appearance';
    
    return 'Characteristic ${uuid.substring(0, 8)}...'; // Show first 8 characters
  }

  /// Create a copy with updated value
  BleCharacteristicModel copyWith({
    String? uuid,
    String? displayName,
    List<BleCharacteristicProperty>? properties,
    List<int>? value,
  }) {
    return BleCharacteristicModel(
      uuid: uuid ?? this.uuid,
      displayName: displayName ?? this.displayName,
      properties: properties ?? this.properties,
      value: value ?? this.value,
    );
  }

  @override
  List<Object?> get props => [uuid, displayName, properties, value];
}

/// Enum representing characteristic properties
enum BleCharacteristicProperty {
  read,
  write,
  writeWithoutResponse,
  notify,
  indicate,
}

/// Extension to get property display names
extension BleCharacteristicPropertyExtension on BleCharacteristicProperty {
  String get displayName {
    switch (this) {
      case BleCharacteristicProperty.read:
        return 'Read';
      case BleCharacteristicProperty.write:
        return 'Write';
      case BleCharacteristicProperty.writeWithoutResponse:
        return 'Write (No Response)';
      case BleCharacteristicProperty.notify:
        return 'Notify';
      case BleCharacteristicProperty.indicate:
        return 'Indicate';
    }
  }
}

/// Extension to get connection state display names
extension BleConnectionStateExtension on BleConnectionState {
  String get displayName {
    switch (this) {
      case BleConnectionState.disconnected:
        return 'Disconnected';
      case BleConnectionState.connecting:
        return 'Connecting...';
      case BleConnectionState.connected:
        return 'Connected';
      case BleConnectionState.disconnecting:
        return 'Disconnecting...';
    }
  }
}