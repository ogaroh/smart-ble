// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'SmartBLE';

  @override
  String get deviceDetails => 'Device Details';

  @override
  String get settings => 'Settings';

  @override
  String get stopScan => 'Stop Scan';

  @override
  String get startScan => 'Start Scan';

  @override
  String get checkBluetooth => 'Check Bluetooth';

  @override
  String get type => 'Type:';

  @override
  String get all => 'All';

  @override
  String get searchDevices => 'Search devices by name...';

  @override
  String get initializingBluetooth => 'Initializing Bluetooth...';

  @override
  String get checkingBluetoothPermissions =>
      'Checking Bluetooth permissions...';

  @override
  String get bluetoothPermissionsRequired => 'Bluetooth permissions required';

  @override
  String scanningDevicesFound(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'devices',
      one: 'device',
    );
    return 'Scanning... ($count $_temp0 found)';
  }

  @override
  String devicesFound(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'devices',
      one: 'device',
    );
    return '$count $_temp0 found';
  }

  @override
  String get retry => 'Retry';

  @override
  String get goBack => 'Go Back';

  @override
  String get connection => 'Connection';

  @override
  String get connect => 'Connect';

  @override
  String get disconnect => 'Disconnect';

  @override
  String get connecting => 'Connecting...';

  @override
  String get connected => 'Connected';

  @override
  String get disconnected => 'Disconnected';

  @override
  String get disconnecting => 'Disconnecting...';

  @override
  String get discoveringServices => 'Discovering services...';

  @override
  String get connectToDiscoverServices =>
      'Connect to this device to discover its services and characteristics';

  @override
  String get noServicesFound => 'No services found on this device';

  @override
  String get servicesAndCharacteristics => 'Services & Characteristics';

  @override
  String get noCharacteristicsAvailable => 'No characteristics available';

  @override
  String bytes(String value) {
    return 'Bytes: $value';
  }

  @override
  String get empty => 'Empty';

  @override
  String get address => 'Address';

  @override
  String get advertisedServices => 'Advertised Services';

  @override
  String serviceCount(int count) {
    return '$count service(s)';
  }

  @override
  String manufacturer(String name) {
    return 'Manufacturer: $name';
  }

  @override
  String get manufacturerUnavailable => 'Manufacturer: Unavailable';

  @override
  String get readingManufacturer => 'Reading manufacturer...';

  @override
  String get manufacturerError => 'Manufacturer: Error reading';

  @override
  String get theme => 'Theme';

  @override
  String get unableToLoadSettings => 'Unable to load settings';

  @override
  String get resetSettings => 'Reset Settings';

  @override
  String get resetSettingsConfirmation =>
      'Are you sure you want to reset all settings to their default values? This action cannot be undone.';

  @override
  String get cancel => 'Cancel';

  @override
  String get reset => 'Reset';

  @override
  String get light => 'Light';

  @override
  String get dark => 'Dark';

  @override
  String get system => 'System';

  @override
  String get followSystemTheme => 'Follow system theme';

  @override
  String get alwaysUseLightTheme => 'Always use light theme';

  @override
  String get alwaysUseDarkTheme => 'Always use dark theme';

  @override
  String get deviceTypeAudio => 'Audio Device';

  @override
  String get deviceTypeWatch => 'Watch';

  @override
  String get deviceTypeOther => 'Other';

  @override
  String get deviceTypeUnknown => 'Unknown';

  @override
  String get deviceTypeComputer => 'Computer';

  @override
  String get deviceTypeSportsWatch => 'Sports Watch';

  @override
  String get deviceTypeClock => 'Clock';

  @override
  String get deviceTypeDisplay => 'Display';

  @override
  String get deviceTypeRemoteControl => 'Remote Control';

  @override
  String get deviceTypeGlasses => 'Smart Glasses';

  @override
  String get deviceTypeTag => 'Tag';

  @override
  String get deviceTypeKeyring => 'Keyring';

  @override
  String get deviceTypePhone => 'Phone';

  @override
  String get characteristicRead => 'Read';

  @override
  String get characteristicWrite => 'Write';

  @override
  String get characteristicWriteNoResponse => 'Write (No Response)';

  @override
  String get characteristicNotify => 'Notify';

  @override
  String get characteristicIndicate => 'Indicate';

  @override
  String get seconds => 'seconds';

  @override
  String get minutes => 'minutes';

  @override
  String get noDevicesFound => 'No devices found';

  @override
  String get scanningForDevices => 'Scanning for devices...';

  @override
  String get tapStartToScan =>
      'Tap \"Start Scan\" to discover nearby BLE devices';

  @override
  String get readyToScan => 'Ready to scan';

  @override
  String get scanError => 'Scan error';

  @override
  String get errorPrefix => 'Error';

  @override
  String get failedToStartScan => 'Failed to start scan';

  @override
  String get failedToStopScan => 'Failed to stop scan';

  @override
  String get bluetoothNotAvailable =>
      'Bluetooth is not available on this device';

  @override
  String get bluetoothPermissionsDenied =>
      'Bluetooth permissions are required to scan for devices';

  @override
  String get failedToCheckBluetooth => 'Failed to check Bluetooth status';

  @override
  String get appearance => 'Appearance';

  @override
  String get bluetooth => 'Bluetooth';

  @override
  String get scanning => 'Scanning';

  @override
  String get advanced => 'Advanced';

  @override
  String get scanTimeout => 'Scan Timeout';

  @override
  String get scanTimeoutSubtitle => 'How long to scan for devices';

  @override
  String get connectionTimeout => 'Connection Timeout';

  @override
  String get connectionTimeoutSubtitle => 'How long to wait for connections';

  @override
  String get autoScanOnStart => 'Auto-scan on Start';

  @override
  String get autoScanOnStartSubtitle =>
      'Automatically start scanning when app opens';

  @override
  String get showUnknownDevices => 'Show Unknown Devices';

  @override
  String get showUnknownDevicesSubtitle =>
      'Display devices without advertised names';

  @override
  String get signalStrengthFilter => 'Signal Strength Filter';

  @override
  String get minimumRssi => 'Minimum RSSI';

  @override
  String get autoConnect => 'Auto-connect';

  @override
  String get autoConnectSubtitle => 'Automatically connect to last device';

  @override
  String get resetSettingsSubtitle => 'Restore all settings to defaults';
}
