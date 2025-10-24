import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_es.dart';
import 'app_localizations_fr.dart';
import 'app_localizations_sw.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'arb/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
      : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('sw'),
    Locale('es'),
    Locale('fr')
  ];

  /// The main application title
  ///
  /// In en, this message translates to:
  /// **'SmartBLE'**
  String get appTitle;

  /// Title for device details screen
  ///
  /// In en, this message translates to:
  /// **'Device Details'**
  String get deviceDetails;

  /// Settings screen title
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// Button text to stop BLE scanning
  ///
  /// In en, this message translates to:
  /// **'Stop Scan'**
  String get stopScan;

  /// Button text to start BLE scanning
  ///
  /// In en, this message translates to:
  /// **'Start Scan'**
  String get startScan;

  /// Button text when Bluetooth needs to be enabled
  ///
  /// In en, this message translates to:
  /// **'Check Bluetooth'**
  String get checkBluetooth;

  /// Label for device type filter
  ///
  /// In en, this message translates to:
  /// **'Type:'**
  String get type;

  /// Filter option to show all device types
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get all;

  /// Placeholder text for device search field
  ///
  /// In en, this message translates to:
  /// **'Search devices by name...'**
  String get searchDevices;

  /// Status message while Bluetooth is being initialized
  ///
  /// In en, this message translates to:
  /// **'Initializing Bluetooth...'**
  String get initializingBluetooth;

  /// Status message while checking Bluetooth permissions
  ///
  /// In en, this message translates to:
  /// **'Checking Bluetooth permissions...'**
  String get checkingBluetoothPermissions;

  /// Error message when Bluetooth permissions are missing
  ///
  /// In en, this message translates to:
  /// **'Bluetooth permissions required'**
  String get bluetoothPermissionsRequired;

  /// Status message showing scanning progress
  ///
  /// In en, this message translates to:
  /// **'Scanning... ({count} {count, plural, =1{device} other{devices}} found)'**
  String scanningDevicesFound(int count);

  /// Status message showing number of devices found
  ///
  /// In en, this message translates to:
  /// **'{count} {count, plural, =1{device} other{devices}} found'**
  String devicesFound(int count);

  /// Button text to retry an action
  ///
  /// In en, this message translates to:
  /// **'Retry'**
  String get retry;

  /// Button text to go back
  ///
  /// In en, this message translates to:
  /// **'Go Back'**
  String get goBack;

  /// Connection status section title
  ///
  /// In en, this message translates to:
  /// **'Connection'**
  String get connection;

  /// Button text to connect to a device
  ///
  /// In en, this message translates to:
  /// **'Connect'**
  String get connect;

  /// Button text to disconnect from a device
  ///
  /// In en, this message translates to:
  /// **'Disconnect'**
  String get disconnect;

  /// Connection status when connecting
  ///
  /// In en, this message translates to:
  /// **'Connecting...'**
  String get connecting;

  /// Connection status when connected
  ///
  /// In en, this message translates to:
  /// **'Connected'**
  String get connected;

  /// Connection status when disconnected
  ///
  /// In en, this message translates to:
  /// **'Disconnected'**
  String get disconnected;

  /// Connection status when disconnecting
  ///
  /// In en, this message translates to:
  /// **'Disconnecting...'**
  String get disconnecting;

  /// Status message while discovering BLE services
  ///
  /// In en, this message translates to:
  /// **'Discovering services...'**
  String get discoveringServices;

  /// Instructions to connect device for service discovery
  ///
  /// In en, this message translates to:
  /// **'Connect to this device to discover its services and characteristics'**
  String get connectToDiscoverServices;

  /// Message when no BLE services are found
  ///
  /// In en, this message translates to:
  /// **'No services found on this device'**
  String get noServicesFound;

  /// Title for services and characteristics section
  ///
  /// In en, this message translates to:
  /// **'Services & Characteristics'**
  String get servicesAndCharacteristics;

  /// Message when no characteristics are available for a service
  ///
  /// In en, this message translates to:
  /// **'No characteristics available'**
  String get noCharacteristicsAvailable;

  /// Label showing characteristic byte value
  ///
  /// In en, this message translates to:
  /// **'Bytes: {value}'**
  String bytes(String value);

  /// Text shown when a characteristic value is empty
  ///
  /// In en, this message translates to:
  /// **'Empty'**
  String get empty;

  /// Label for device MAC address
  ///
  /// In en, this message translates to:
  /// **'Address'**
  String get address;

  /// Label for number of advertised services
  ///
  /// In en, this message translates to:
  /// **'Advertised Services'**
  String get advertisedServices;

  /// Text showing number of services
  ///
  /// In en, this message translates to:
  /// **'{count} service(s)'**
  String serviceCount(int count);

  /// Label showing manufacturer name
  ///
  /// In en, this message translates to:
  /// **'Manufacturer: {name}'**
  String manufacturer(String name);

  /// Label when manufacturer info is unavailable
  ///
  /// In en, this message translates to:
  /// **'Manufacturer: Unavailable'**
  String get manufacturerUnavailable;

  /// Status message while reading manufacturer info
  ///
  /// In en, this message translates to:
  /// **'Reading manufacturer...'**
  String get readingManufacturer;

  /// Error message when manufacturer info cannot be read
  ///
  /// In en, this message translates to:
  /// **'Manufacturer: Error reading'**
  String get manufacturerError;

  /// Theme settings label
  ///
  /// In en, this message translates to:
  /// **'Theme'**
  String get theme;

  /// Error message when settings cannot be loaded
  ///
  /// In en, this message translates to:
  /// **'Unable to load settings'**
  String get unableToLoadSettings;

  /// Action to reset all settings
  ///
  /// In en, this message translates to:
  /// **'Reset Settings'**
  String get resetSettings;

  /// Confirmation dialog message for resetting settings
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to reset all settings to their default values? This action cannot be undone.'**
  String get resetSettingsConfirmation;

  /// Cancel action button
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// Reset action button
  ///
  /// In en, this message translates to:
  /// **'Reset'**
  String get reset;

  /// Light theme option
  ///
  /// In en, this message translates to:
  /// **'Light'**
  String get light;

  /// Dark theme option
  ///
  /// In en, this message translates to:
  /// **'Dark'**
  String get dark;

  /// System theme option
  ///
  /// In en, this message translates to:
  /// **'System'**
  String get system;

  /// Theme description for system mode
  ///
  /// In en, this message translates to:
  /// **'Follow system theme'**
  String get followSystemTheme;

  /// Theme description for light mode
  ///
  /// In en, this message translates to:
  /// **'Always use light theme'**
  String get alwaysUseLightTheme;

  /// Theme description for dark mode
  ///
  /// In en, this message translates to:
  /// **'Always use dark theme'**
  String get alwaysUseDarkTheme;

  /// BLE device type: Audio Device
  ///
  /// In en, this message translates to:
  /// **'Audio Device'**
  String get deviceTypeAudio;

  /// BLE device type: Watch
  ///
  /// In en, this message translates to:
  /// **'Watch'**
  String get deviceTypeWatch;

  /// BLE device type: Other
  ///
  /// In en, this message translates to:
  /// **'Other'**
  String get deviceTypeOther;

  /// BLE device type: Unknown
  ///
  /// In en, this message translates to:
  /// **'Unknown'**
  String get deviceTypeUnknown;

  /// BLE device type: Computer
  ///
  /// In en, this message translates to:
  /// **'Computer'**
  String get deviceTypeComputer;

  /// BLE device type: Sports Watch
  ///
  /// In en, this message translates to:
  /// **'Sports Watch'**
  String get deviceTypeSportsWatch;

  /// BLE device type: Clock
  ///
  /// In en, this message translates to:
  /// **'Clock'**
  String get deviceTypeClock;

  /// BLE device type: Display
  ///
  /// In en, this message translates to:
  /// **'Display'**
  String get deviceTypeDisplay;

  /// BLE device type: Remote Control
  ///
  /// In en, this message translates to:
  /// **'Remote Control'**
  String get deviceTypeRemoteControl;

  /// BLE device type: Smart Glasses
  ///
  /// In en, this message translates to:
  /// **'Smart Glasses'**
  String get deviceTypeGlasses;

  /// BLE device type: Tag
  ///
  /// In en, this message translates to:
  /// **'Tag'**
  String get deviceTypeTag;

  /// BLE device type: Keyring
  ///
  /// In en, this message translates to:
  /// **'Keyring'**
  String get deviceTypeKeyring;

  /// BLE device type: Phone
  ///
  /// In en, this message translates to:
  /// **'Phone'**
  String get deviceTypePhone;

  /// BLE characteristic property: Read
  ///
  /// In en, this message translates to:
  /// **'Read'**
  String get characteristicRead;

  /// BLE characteristic property: Write
  ///
  /// In en, this message translates to:
  /// **'Write'**
  String get characteristicWrite;

  /// BLE characteristic property: Write without response
  ///
  /// In en, this message translates to:
  /// **'Write (No Response)'**
  String get characteristicWriteNoResponse;

  /// BLE characteristic property: Notify
  ///
  /// In en, this message translates to:
  /// **'Notify'**
  String get characteristicNotify;

  /// BLE characteristic property: Indicate
  ///
  /// In en, this message translates to:
  /// **'Indicate'**
  String get characteristicIndicate;

  /// Time unit: seconds
  ///
  /// In en, this message translates to:
  /// **'seconds'**
  String get seconds;

  /// Time unit: minutes
  ///
  /// In en, this message translates to:
  /// **'minutes'**
  String get minutes;

  /// Message when no BLE devices are found
  ///
  /// In en, this message translates to:
  /// **'No devices found'**
  String get noDevicesFound;

  /// Message shown while actively scanning for devices
  ///
  /// In en, this message translates to:
  /// **'Scanning for devices...'**
  String get scanningForDevices;

  /// Instruction text when not scanning
  ///
  /// In en, this message translates to:
  /// **'Tap \"Start Scan\" to discover nearby BLE devices'**
  String get tapStartToScan;

  /// Status message when ready to start scanning
  ///
  /// In en, this message translates to:
  /// **'Ready to scan'**
  String get readyToScan;

  /// Prefix for scan error messages
  ///
  /// In en, this message translates to:
  /// **'Scan error'**
  String get scanError;

  /// Generic error prefix
  ///
  /// In en, this message translates to:
  /// **'Error'**
  String get errorPrefix;

  /// Error message when scan fails to start
  ///
  /// In en, this message translates to:
  /// **'Failed to start scan'**
  String get failedToStartScan;

  /// Error message when scan fails to stop
  ///
  /// In en, this message translates to:
  /// **'Failed to stop scan'**
  String get failedToStopScan;

  /// Error when Bluetooth hardware is not available
  ///
  /// In en, this message translates to:
  /// **'Bluetooth is not available on this device'**
  String get bluetoothNotAvailable;

  /// Error when Bluetooth permissions are denied
  ///
  /// In en, this message translates to:
  /// **'Bluetooth permissions are required to scan for devices'**
  String get bluetoothPermissionsDenied;

  /// Error when unable to check Bluetooth status
  ///
  /// In en, this message translates to:
  /// **'Failed to check Bluetooth status'**
  String get failedToCheckBluetooth;

  /// Settings section title for appearance settings
  ///
  /// In en, this message translates to:
  /// **'Appearance'**
  String get appearance;

  /// Settings section title for Bluetooth settings
  ///
  /// In en, this message translates to:
  /// **'Bluetooth'**
  String get bluetooth;

  /// Settings section title for scanning preferences
  ///
  /// In en, this message translates to:
  /// **'Scanning'**
  String get scanning;

  /// Settings section title for advanced settings
  ///
  /// In en, this message translates to:
  /// **'Advanced'**
  String get advanced;

  /// Setting for scan timeout duration
  ///
  /// In en, this message translates to:
  /// **'Scan Timeout'**
  String get scanTimeout;

  /// Subtitle explaining scan timeout setting
  ///
  /// In en, this message translates to:
  /// **'How long to scan for devices'**
  String get scanTimeoutSubtitle;

  /// Setting for connection timeout duration
  ///
  /// In en, this message translates to:
  /// **'Connection Timeout'**
  String get connectionTimeout;

  /// Subtitle explaining connection timeout setting
  ///
  /// In en, this message translates to:
  /// **'How long to wait for connections'**
  String get connectionTimeoutSubtitle;

  /// Setting to enable automatic scanning on app start
  ///
  /// In en, this message translates to:
  /// **'Auto-scan on Start'**
  String get autoScanOnStart;

  /// Subtitle explaining auto-scan setting
  ///
  /// In en, this message translates to:
  /// **'Automatically start scanning when app opens'**
  String get autoScanOnStartSubtitle;

  /// Setting to show/hide unknown devices
  ///
  /// In en, this message translates to:
  /// **'Show Unknown Devices'**
  String get showUnknownDevices;

  /// Subtitle explaining unknown devices setting
  ///
  /// In en, this message translates to:
  /// **'Display devices without advertised names'**
  String get showUnknownDevicesSubtitle;

  /// Setting for signal strength filtering
  ///
  /// In en, this message translates to:
  /// **'Signal Strength Filter'**
  String get signalStrengthFilter;

  /// Label for minimum RSSI value
  ///
  /// In en, this message translates to:
  /// **'Minimum RSSI'**
  String get minimumRssi;

  /// Setting for automatic device connection
  ///
  /// In en, this message translates to:
  /// **'Auto-connect'**
  String get autoConnect;

  /// Subtitle explaining auto-connect setting
  ///
  /// In en, this message translates to:
  /// **'Automatically connect to last device'**
  String get autoConnectSubtitle;

  /// Subtitle for reset settings action
  ///
  /// In en, this message translates to:
  /// **'Restore all settings to defaults'**
  String get resetSettingsSubtitle;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'es', 'fr', 'sw'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'es':
      return AppLocalizationsEs();
    case 'fr':
      return AppLocalizationsFr();
    case 'sw':
      return AppLocalizationsSw();
  }

  throw FlutterError(
      'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
      'an issue with the localizations generation tool. Please file an issue '
      'on GitHub with a reproducible sample app and the gen-l10n configuration '
      'that was used.');
}
