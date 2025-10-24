import 'package:equatable/equatable.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:smart_ble/l10n/arb/app_localizations.dart';

/// Enum representing different types of BLE devices for filtering
enum BleDeviceType {
  unknown,
  audio,
  watch,
  phone,
  computer,
  sportsWatch,
  clock,
  display,
  remoteControl,
  glasses,
  tag,
  keyring,
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

    // extract appearance if available
    final appearance = advertisementData.appearance;

    // Extract service UUIDs
    final serviceUuids =
        advertisementData.serviceUuids.map((uuid) => uuid.toString()).toList();

    // Determine device name
    String deviceName = advertisementData.advName.isNotEmpty
        ? advertisementData.advName
        : (device.platformName.isNotEmpty
            ? device.platformName
            : 'Unknown Device');

    // Determine device type based on advertised services or name
    BleDeviceType deviceType = _determineDeviceType(
      deviceName,
      serviceUuids,
      appearance,
    );

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

  /// device type based appearance code
  static BleDeviceType _deviceTypeFromAppearance(int appearance) {
    switch (appearance) {
      case 0x0040:
        return BleDeviceType.phone;
      case 0x0080:
        return BleDeviceType.computer;
      case 0x00C0:
        return BleDeviceType.watch;
      case 0x00C1:
        return BleDeviceType.sportsWatch;
      case 0x0100:
        return BleDeviceType.clock;
      case 0x0140:
        return BleDeviceType.display;
      case 0x0180:
        return BleDeviceType.remoteControl;
      case 0x01C0:
        return BleDeviceType.glasses;
      case 0x0200:
        return BleDeviceType.tag;
      case 0x0240:
        return BleDeviceType.keyring;
      case 0x0000:
      default:
        return BleDeviceType.unknown;
    }
  }

  /// Determine device type based on name and services
  static BleDeviceType _determineDeviceType(
    String name,
    List<String> serviceUuids,
    int? appearance,
  ) {
    // Check for device type based on appearance (if available)
    if (appearance != null) {
      return _deviceTypeFromAppearance(appearance);
    }

    final lowerName = name.toLowerCase();

    // Check for specific service UUIDs first
    for (final uuid in serviceUuids) {
      final lowerUuid = uuid.toLowerCase();

      // Audio devices - Audio Sink (0x110B), A2DP (0x110D), Headset (0x1108)
      if (lowerUuid.contains('110b') ||
          lowerUuid.contains('110d') ||
          lowerUuid.contains('1108')) {
        return BleDeviceType.audio;
      }

      // Human Interface Device (HID) - could be various devices
      if (lowerUuid.contains('1812')) {
        // Further classification based on name for HID devices
        if (lowerName.contains('keyboard') || lowerName.contains('mouse')) {
          return BleDeviceType.computer;
        }
        if (lowerName.contains('remote') || lowerName.contains('control')) {
          return BleDeviceType.remoteControl;
        }
        if (lowerName.contains('game') || lowerName.contains('controller')) {
          return BleDeviceType.remoteControl;
        }
      }

      // Battery Service - common in watches and fitness devices
      if (lowerUuid.contains('180f')) {
        if (lowerName.contains('watch') ||
            lowerName.contains('band') ||
            lowerName.contains('fitness') ||
            lowerName.contains('tracker')) {
          return BleDeviceType.watch;
        }
      }

      // Phone/Computer related services
      if (lowerUuid.contains('1105') || // OBEX Object Push
          lowerUuid.contains('1106') || // OBEX File Transfer
          lowerUuid.contains('1115') || // Personal Area Networking
          lowerUuid.contains('1116')) {
        // Network Access Point
        return lowerName.contains('phone')
            ? BleDeviceType.phone
            : BleDeviceType.computer;
      }
    }

    // Name-based detection patterns

    // Audio devices
    if (lowerName.contains('headphone') ||
        lowerName.contains('speaker') ||
        lowerName.contains('earphone') ||
        lowerName.contains('earbud') ||
        lowerName.contains('airpods') ||
        lowerName.contains('pods') ||
        lowerName.contains('beats') ||
        lowerName.contains('audio') ||
        lowerName.contains('sound') ||
        lowerName.contains('music')) {
      return BleDeviceType.audio;
    }

    // Watches and fitness devices
    if (lowerName.contains('watch') ||
        lowerName.contains('band') ||
        lowerName.contains('fitness') ||
        lowerName.contains('tracker') ||
        lowerName.contains('garmin') ||
        lowerName.contains('fitbit') ||
        lowerName.contains('polar') ||
        lowerName.contains('suunto') ||
        lowerName.contains('amazfit') ||
        lowerName.contains('mi band') ||
        lowerName.contains('galaxy watch') ||
        lowerName.contains('apple watch')) {
      // Distinguish between regular watch and sports watch
      if (lowerName.contains('sport') ||
          lowerName.contains('fitness') ||
          lowerName.contains('run') ||
          lowerName.contains('trainer') ||
          lowerName.contains('active')) {
        return BleDeviceType.sportsWatch;
      }
      return BleDeviceType.watch;
    }

    // Phones
    if (lowerName.contains('phone') ||
        lowerName.contains('iphone') ||
        lowerName.contains('galaxy') ||
        lowerName.contains('pixel') ||
        lowerName.contains('oneplus') ||
        lowerName.contains('huawei') ||
        lowerName.contains('xiaomi') ||
        lowerName.contains('samsung')) {
      return BleDeviceType.phone;
    }

    // Computers and laptops
    if (lowerName.contains('computer') ||
        lowerName.contains('laptop') ||
        lowerName.contains('desktop') ||
        lowerName.contains('pc') ||
        lowerName.contains('macbook') ||
        lowerName.contains('imac') ||
        lowerName.contains('thinkpad') ||
        lowerName.contains('surface') ||
        lowerName.contains('dell') ||
        lowerName.contains('hp') ||
        lowerName.contains('lenovo')) {
      return BleDeviceType.computer;
    }

    // Clocks and time devices
    if (lowerName.contains('clock') ||
        lowerName.contains('time') ||
        lowerName.contains('alarm') ||
        lowerName.contains('timer')) {
      return BleDeviceType.clock;
    }

    // Displays and screens
    if (lowerName.contains('display') ||
        lowerName.contains('screen') ||
        lowerName.contains('monitor') ||
        lowerName.contains('tv') ||
        lowerName.contains('television') ||
        lowerName.contains('projector')) {
      return BleDeviceType.display;
    }

    // Remote controls
    if (lowerName.contains('remote') ||
        lowerName.contains('control') ||
        lowerName.contains('controller') ||
        lowerName.contains('gamepad') ||
        lowerName.contains('joystick')) {
      return BleDeviceType.remoteControl;
    }

    // Smart glasses
    if (lowerName.contains('glass') ||
        lowerName.contains('smart glass') ||
        lowerName.contains('ar glass') ||
        lowerName.contains('vr') ||
        lowerName.contains('hololens') ||
        lowerName.contains('oculus') ||
        lowerName.contains('quest')) {
      return BleDeviceType.glasses;
    }

    // Tags and beacons
    if (lowerName.contains('tag') ||
        lowerName.contains('beacon') ||
        lowerName.contains('tile') ||
        lowerName.contains('chipolo') ||
        lowerName.contains('airtag') ||
        lowerName.contains('tracker') ||
        lowerName.contains('finder')) {
      return BleDeviceType.tag;
    }

    // Keyrings and small accessories
    if (lowerName.contains('keyring') ||
        lowerName.contains('key ring') ||
        lowerName.contains('key finder') ||
        lowerName.contains('key chain') ||
        lowerName.contains('keychain')) {
      return BleDeviceType.keyring;
    }

    // Default to unknown if no patterns match
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
  List<Object?> get props =>
      [id, name, address, rssi, deviceType, serviceUuids];
}

/// Extension to get device type display name
extension BleDeviceTypeExtension on BleDeviceType {
  String get displayName {
    switch (this) {
      case BleDeviceType.audio:
        return 'Audio Device';
      case BleDeviceType.watch:
        return 'Watch';
      case BleDeviceType.other:
        return 'Other';
      case BleDeviceType.unknown:
        return 'Unknown';
      case BleDeviceType.computer:
        return 'Computer';
      case BleDeviceType.sportsWatch:
        return 'Sports Watch';
      case BleDeviceType.clock:
        return 'Clock';
      case BleDeviceType.display:
        return 'Display';
      case BleDeviceType.remoteControl:
        return 'Remote Control';
      case BleDeviceType.glasses:
        return 'Smart Glasses';
      case BleDeviceType.tag:
        return 'Tag';
      case BleDeviceType.keyring:
        return 'Keyring';
      case BleDeviceType.phone:
        return 'Phone';
    }
  }

  /// Get localized display name using app localizations
  String localizedDisplayName(AppLocalizations l10n) {
    switch (this) {
      case BleDeviceType.audio:
        return l10n.deviceTypeAudio;
      case BleDeviceType.watch:
        return l10n.deviceTypeWatch;
      case BleDeviceType.other:
        return l10n.deviceTypeOther;
      case BleDeviceType.unknown:
        return l10n.deviceTypeUnknown;
      case BleDeviceType.computer:
        return l10n.deviceTypeComputer;
      case BleDeviceType.sportsWatch:
        return l10n.deviceTypeSportsWatch;
      case BleDeviceType.clock:
        return l10n.deviceTypeClock;
      case BleDeviceType.display:
        return l10n.deviceTypeDisplay;
      case BleDeviceType.remoteControl:
        return l10n.deviceTypeRemoteControl;
      case BleDeviceType.glasses:
        return l10n.deviceTypeGlasses;
      case BleDeviceType.tag:
        return l10n.deviceTypeTag;
      case BleDeviceType.keyring:
        return l10n.deviceTypeKeyring;
      case BleDeviceType.phone:
        return l10n.deviceTypePhone;
    }
  }
}
