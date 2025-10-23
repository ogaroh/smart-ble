import 'package:equatable/equatable.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';

/// Enum representing different types of BLE devices for filtering
enum BleDeviceType {
  unknown,
  audioDevice,
  smartwatch,
  other,
}

/// Model representing a discovered BLE device
class BleDevice extends Equatable {
  final String id;
  final String name;
  final String address;
  final int rssi;
  final BleDeviceType deviceType;
  final List<String> serviceUuids;
  final BluetoothDevice? platformDevice;

  const BleDevice({
    required this.id,
    required this.name,
    required this.address,
    required this.rssi,
    this.deviceType = BleDeviceType.unknown,
    this.serviceUuids = const [],
    this.platformDevice,
  });

  /// Create BleDevice from flutter_blue_plus ScanResult
  factory BleDevice.fromScanResult(ScanResult scanResult) {
    final device = scanResult.device;
    final advertisementData = scanResult.advertisementData;
    
    // Extract service UUIDs
    final serviceUuids = advertisementData.serviceUuids.map((uuid) => uuid.toString()).toList();
    
    // Determine device name
    String deviceName = advertisementData.advName.isNotEmpty 
        ? advertisementData.advName 
        : (device.platformName.isNotEmpty ? device.platformName : 'Unknown Device');
    
    // Determine device type based on advertised services or name
    BleDeviceType deviceType = _determineDeviceType(deviceName, serviceUuids);
    
    return BleDevice(
      id: device.remoteId.str,
      name: deviceName,
      address: device.remoteId.str,
      rssi: scanResult.rssi,
      deviceType: deviceType,
      serviceUuids: serviceUuids,
      platformDevice: device,
    );
  }

  /// Determine device type based on name and services
  static BleDeviceType _determineDeviceType(String name, List<String> serviceUuids) {
    // Check for audio device service UUID (Audio Sink: 0x110B)
    if (serviceUuids.any((uuid) => uuid.toLowerCase().contains('110b'))) {
      return BleDeviceType.audioDevice;
    }
    
    // Check for audio devices by name patterns
    final lowerName = name.toLowerCase();
    if (lowerName.contains('headphone') || 
        lowerName.contains('speaker') || 
        lowerName.contains('earbuds') ||
        lowerName.contains('airpods') ||
        lowerName.contains('audio')) {
      return BleDeviceType.audioDevice;
    }
    
    // Check for smartwatch by name patterns
    if (lowerName.contains('watch') || 
        lowerName.contains('band') || 
        lowerName.contains('fitness') ||
        lowerName.contains('garmin') ||
        lowerName.contains('fitbit') ||
        lowerName.contains('samsung') ||
        lowerName.contains('apple watch')) {
      return BleDeviceType.smartwatch;
    }
    
    return BleDeviceType.unknown;
  }

  /// Create a copy with updated RSSI (for real-time updates)
  BleDevice copyWith({
    String? id,
    String? name,
    String? address,
    int? rssi,
    BleDeviceType? deviceType,
    List<String>? serviceUuids,
    BluetoothDevice? platformDevice,
  }) {
    return BleDevice(
      id: id ?? this.id,
      name: name ?? this.name,
      address: address ?? this.address,
      rssi: rssi ?? this.rssi,
      deviceType: deviceType ?? this.deviceType,
      serviceUuids: serviceUuids ?? this.serviceUuids,
      platformDevice: platformDevice ?? this.platformDevice,
    );
  }

  @override
  List<Object?> get props => [id, name, address, rssi, deviceType, serviceUuids];
}

/// Extension to get device type display name
extension BleDeviceTypeExtension on BleDeviceType {
  String get displayName {
    switch (this) {
      case BleDeviceType.audioDevice:
        return 'Audio Device';
      case BleDeviceType.smartwatch:
        return 'Smartwatch';
      case BleDeviceType.other:
        return 'Other';
      case BleDeviceType.unknown:
        return 'Unknown';
    }
  }
}