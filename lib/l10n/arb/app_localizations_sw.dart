// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Swahili (`sw`).
class AppLocalizationsSw extends AppLocalizations {
  AppLocalizationsSw([String locale = 'sw']) : super(locale);

  @override
  String get appTitle => 'SmartBLE';

  @override
  String get deviceDetails => 'Maelezo ya Kifaa';

  @override
  String get settings => 'Mipangilio';

  @override
  String get stopScan => 'Acha Kutafuta';

  @override
  String get startScan => 'Anza Kutafuta';

  @override
  String get checkBluetooth => 'Angalia Bluetooth';

  @override
  String get type => 'Aina:';

  @override
  String get all => 'Zote';

  @override
  String get searchDevices => 'Tafuta vifaa kwa jina...';

  @override
  String get initializingBluetooth => 'Kuanzisha Bluetooth...';

  @override
  String get checkingBluetoothPermissions => 'Kukagua ruhusa za Bluetooth...';

  @override
  String get bluetoothPermissionsRequired => 'Ruhusa za Bluetooth zinahitajika';

  @override
  String scanningDevicesFound(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'vifaa',
      one: 'kifaa',
    );
    return 'Kutafuta... ($count $_temp0 vimepatikana)';
  }

  @override
  String devicesFound(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'vifaa',
      one: 'kifaa',
    );
    return '$count $_temp0 vimepatikana';
  }

  @override
  String get retry => 'Jaribu Tena';

  @override
  String get goBack => 'Rudi Nyuma';

  @override
  String get connection => 'Muunganisho';

  @override
  String get connect => 'Unganisha';

  @override
  String get disconnect => 'Tengua';

  @override
  String get connecting => 'Kuunganisha...';

  @override
  String get connected => 'Imeunganishwa';

  @override
  String get disconnected => 'Haijaungana';

  @override
  String get disconnecting => 'Kutenganisha...';

  @override
  String get discoveringServices => 'Kugundua huduma...';

  @override
  String get connectToDiscoverServices =>
      'Unganisha kifaa hiki ili kugundua huduma na sifa zake';

  @override
  String get noServicesFound =>
      'Hakuna huduma zilizopatikana kwenye kifaa hiki';

  @override
  String get servicesAndCharacteristics => 'Huduma na Sifa';

  @override
  String get noCharacteristicsAvailable => 'Hakuna sifa zinazopatikana';

  @override
  String bytes(String value) {
    return 'Bytes: $value';
  }

  @override
  String get empty => 'Tupu';

  @override
  String get address => 'Anwani';

  @override
  String get advertisedServices => 'Huduma Zilizotangazwa';

  @override
  String serviceCount(int count) {
    return '$count huduma';
  }

  @override
  String manufacturer(String name) {
    return 'Mtengenezaji: $name';
  }

  @override
  String get manufacturerUnavailable => 'Mtengenezaji: Haupatikani';

  @override
  String get readingManufacturer => 'Kusoma mtengenezaji...';

  @override
  String get manufacturerError => 'Mtengenezaji: Hitilafu ya kusoma';

  @override
  String get theme => 'Mandhari';

  @override
  String get unableToLoadSettings => 'Haikuweza kupakia mipangilio';

  @override
  String get resetSettings => 'Rudisha Mipangilio';

  @override
  String get resetSettingsConfirmation =>
      'Una uhakika unataka kurudisha mipangilio yote kwa maadili ya chaguo-msingi? Kitendo hiki hakiwezi kubatilishwa.';

  @override
  String get cancel => 'Ghairi';

  @override
  String get reset => 'Rudisha';

  @override
  String get light => 'Mwanga';

  @override
  String get dark => 'Giza';

  @override
  String get system => 'Mfumo';

  @override
  String get seconds => 'sekunde';

  @override
  String get minutes => 'dakika';

  @override
  String get noDevicesFound => 'Hakuna vifaa vilivyopatikana';

  @override
  String get scanningForDevices => 'Kutafuta vifaa...';

  @override
  String get tapStartToScan =>
      'Gusa \"Anza Kutafuta\" ili kugundua vifaa vya BLE vinavyoko karibu';

  @override
  String get readyToScan => 'Tayari kutafuta';

  @override
  String get scanError => 'Kosa la kutafuta';

  @override
  String get errorPrefix => 'Kosa';

  @override
  String get failedToStartScan => 'Imeshindwa kuanza kutafuta';

  @override
  String get failedToStopScan => 'Imeshindwa kuacha kutafuta';

  @override
  String get bluetoothNotAvailable => 'Bluetooth haipatikani kwenye kifaa hiki';

  @override
  String get bluetoothPermissionsDenied =>
      'Ruhusa za Bluetooth zinahitajika ili kutafuta vifaa';

  @override
  String get failedToCheckBluetooth => 'Imeshindwa kuangalia hali ya Bluetooth';
}
