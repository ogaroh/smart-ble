import 'dart:async';
import 'dart:io';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:permission_handler/permission_handler.dart';
import '../models/ble_device.dart';
import '../models/ble_models.dart';

/// Repository for handling BLE operations using flutter_blue_plus
class BleRepository {
  static final BleRepository _instance = BleRepository._internal();
  factory BleRepository() => _instance;
  BleRepository._internal();

  StreamSubscription<List<ScanResult>>? _scanSubscription;
  StreamSubscription<BluetoothConnectionState>? _connectionSubscription;
  final StreamController<List<BleDevice>> _scanResultsController = StreamController<List<BleDevice>>.broadcast();
  final StreamController<BleConnectionState> _connectionStateController = StreamController<BleConnectionState>.broadcast();
  
  final List<BleDevice> _discoveredDevices = [];
  BluetoothDevice? _connectedDevice;

  /// Stream of discovered devices during scanning
  Stream<List<BleDevice>> get scanResults => _scanResultsController.stream;
  
  /// Stream of connection state changes
  Stream<BleConnectionState> get connectionState => _connectionStateController.stream;
  
  /// Get the currently connected device
  BluetoothDevice? get connectedDevice => _connectedDevice;

  /// Check if Bluetooth is available and enabled
  Future<bool> isBluetoothAvailable() async {
    try {
      return await FlutterBluePlus.isAvailable;
    } catch (e) {
      return false;
    }
  }

  /// Check if Bluetooth is turned on
  Future<bool> isBluetoothOn() async {
    try {
      return await FlutterBluePlus.isOn;
    } catch (e) {
      return false;
    }
  }

  /// Turn on Bluetooth (Android only)
  Future<void> turnOnBluetooth() async {
    if (Platform.isAndroid) {
      try {
        await FlutterBluePlus.turnOn();
      } catch (e) {
        throw Exception('Failed to turn on Bluetooth: $e');
      }
    }
  }

  /// Request necessary permissions for BLE operations
  Future<bool> requestPermissions() async {
    Map<Permission, PermissionStatus> permissions = {};

    if (Platform.isAndroid) {
      // For Android 12+ (API 31+)
      permissions = await [
        Permission.bluetoothScan,
        Permission.bluetoothConnect,
        Permission.bluetoothAdvertise,
        Permission.locationWhenInUse,
      ].request();
    } else if (Platform.isIOS) {
      // For iOS
      permissions = await [
        Permission.bluetooth,
        Permission.locationWhenInUse,
      ].request();
    }

    // Check if all permissions are granted
    return permissions.values.every((status) => 
        status == PermissionStatus.granted || 
        status == PermissionStatus.limited);
  }

  /// Start scanning for BLE devices
  Future<void> startScan({Duration? timeout}) async {
    try {
      // Check permissions first
      final hasPermissions = await requestPermissions();
      if (!hasPermissions) {
        throw Exception('Bluetooth permissions not granted');
      }

      // Check if Bluetooth is on
      final isOn = await isBluetoothOn();
      if (!isOn) {
        throw Exception('Bluetooth is not enabled');
      }

      // Clear previous results
      _discoveredDevices.clear();
      _scanResultsController.add(_discoveredDevices);

      // Start scanning
      await FlutterBluePlus.startScan(
        timeout: timeout ?? const Duration(seconds: 15),
        androidUsesFineLocation: true,
      );

      // Listen to scan results
      _scanSubscription = FlutterBluePlus.scanResults.listen(
        (results) {
          _updateDiscoveredDevices(results);
        },
        onError: (error) {
          _scanResultsController.addError('Scan error: $error');
        },
      );

    } catch (e) {
      throw Exception('Failed to start scan: $e');
    }
  }

  /// Stop scanning for BLE devices
  Future<void> stopScan() async {
    try {
      await FlutterBluePlus.stopScan();
      await _scanSubscription?.cancel();
      _scanSubscription = null;
    } catch (e) {
      throw Exception('Failed to stop scan: $e');
    }
  }

  /// Check if currently scanning
  bool get isScanning => FlutterBluePlus.isScanningNow;

  /// Update discovered devices list
  void _updateDiscoveredDevices(List<ScanResult> results) {
    for (final result in results) {
      final bleDevice = BleDevice.fromScanResult(result);
      
      // Check if device already exists
      final existingIndex = _discoveredDevices.indexWhere(
        (device) => device.id == bleDevice.id,
      );
      
      if (existingIndex != -1) {
        // Update existing device (mainly RSSI)
        _discoveredDevices[existingIndex] = bleDevice;
      } else {
        // Add new device
        _discoveredDevices.add(bleDevice);
      }
    }
    
    // Sort devices by RSSI (stronger signal first)
    _discoveredDevices.sort((a, b) => b.rssi.compareTo(a.rssi));
    
    // Emit updated list
    _scanResultsController.add(List.from(_discoveredDevices));
  }

  /// Connect to a BLE device
  Future<void> connectToDevice(BleDevice device) async {
    try {
      if (device.platformDevice == null) {
        throw Exception('Invalid device - no platform device available');
      }

      _connectionStateController.add(BleConnectionState.connecting);

      // Listen to connection state changes
      _connectionSubscription = device.platformDevice!.connectionState.listen(
        (state) {
          final bleState = _mapConnectionState(state);
          _connectionStateController.add(bleState);
          
          if (bleState == BleConnectionState.connected) {
            _connectedDevice = device.platformDevice;
          } else if (bleState == BleConnectionState.disconnected) {
            _connectedDevice = null;
          }
        },
        onError: (error) {
          _connectionStateController.addError('Connection error: $error');
        },
      );

      // Connect to device
      await device.platformDevice!.connect(
        timeout: const Duration(seconds: 15),
        autoConnect: false,
      );

    } catch (e) {
      _connectionStateController.add(BleConnectionState.disconnected);
      throw Exception('Failed to connect to device: $e');
    }
  }

  /// Disconnect from the current device
  Future<void> disconnectFromDevice() async {
    try {
      if (_connectedDevice != null) {
        _connectionStateController.add(BleConnectionState.disconnecting);
        await _connectedDevice!.disconnect();
      }
    } catch (e) {
      throw Exception('Failed to disconnect from device: $e');
    }
  }

  /// Discover services for the connected device
  Future<List<BleServiceModel>> discoverServices() async {
    try {
      if (_connectedDevice == null) {
        throw Exception('No device connected');
      }

      final services = await _connectedDevice!.discoverServices();
      return services.map((service) => BleServiceModel.fromBluetoothService(service)).toList();

    } catch (e) {
      throw Exception('Failed to discover services: $e');
    }
  }

  /// Read a characteristic value
  Future<List<int>> readCharacteristic(String serviceUuid, String characteristicUuid) async {
    try {
      if (_connectedDevice == null) {
        throw Exception('No device connected');
      }

      final services = await _connectedDevice!.discoverServices();
      
      for (final service in services) {
        if (service.uuid.toString().toLowerCase() == serviceUuid.toLowerCase()) {
          for (final characteristic in service.characteristics) {
            if (characteristic.uuid.toString().toLowerCase() == characteristicUuid.toLowerCase()) {
              if (characteristic.properties.read) {
                return await characteristic.read();
              } else {
                throw Exception('Characteristic is not readable');
              }
            }
          }
        }
      }
      
      throw Exception('Characteristic not found');
    } catch (e) {
      throw Exception('Failed to read characteristic: $e');
    }
  }

  /// Map flutter_blue_plus connection state to our BLE connection state
  BleConnectionState _mapConnectionState(BluetoothConnectionState state) {
    switch (state) {
      case BluetoothConnectionState.disconnected:
        return BleConnectionState.disconnected;
      case BluetoothConnectionState.connected:
        return BleConnectionState.connected;
      case BluetoothConnectionState.connecting:
        return BleConnectionState.connecting;
      case BluetoothConnectionState.disconnecting:
        return BleConnectionState.disconnecting;
    }
  }

  /// Get list of currently discovered devices
  List<BleDevice> get discoveredDevices => List.from(_discoveredDevices);

  /// Clear discovered devices
  void clearDiscoveredDevices() {
    _discoveredDevices.clear();
    _scanResultsController.add(_discoveredDevices);
  }

  /// Dispose of resources
  void dispose() {
    _scanSubscription?.cancel();
    _connectionSubscription?.cancel();
    _scanResultsController.close();
    _connectionStateController.close();
  }
}