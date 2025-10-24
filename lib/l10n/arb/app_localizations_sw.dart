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
  String get followSystemTheme => 'Fuata muundo wa mfumo';

  @override
  String get alwaysUseLightTheme => 'Tumia muundo mwanga kila wakati';

  @override
  String get alwaysUseDarkTheme => 'Tumia muundo wa giza kila wakati';

  @override
  String get deviceTypeAudio => 'Kifaa cha Sauti';

  @override
  String get deviceTypeWatch => 'Saa';

  @override
  String get deviceTypeOther => 'Kingine';

  @override
  String get deviceTypeUnknown => 'Haijulikani';

  @override
  String get deviceTypeComputer => 'Kompyuta';

  @override
  String get deviceTypeSportsWatch => 'Saa ya Michezo';

  @override
  String get deviceTypeClock => 'Saa ya Ukutani';

  @override
  String get deviceTypeDisplay => 'Skrini';

  @override
  String get deviceTypeRemoteControl => 'Udhibiti wa Mbali';

  @override
  String get deviceTypeGlasses => 'Miwani Mahiri';

  @override
  String get deviceTypeTag => 'Lebo';

  @override
  String get deviceTypeKeyring => 'Ukanda wa Funguo';

  @override
  String get deviceTypePhone => 'Simu';

  @override
  String get characteristicRead => 'Soma';

  @override
  String get characteristicWrite => 'Andika';

  @override
  String get characteristicWriteNoResponse => 'Andika (Bila Jibu)';

  @override
  String get characteristicNotify => 'Arifu';

  @override
  String get characteristicIndicate => 'Onyesha';

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

  @override
  String get appearance => 'Muonekano';

  @override
  String get bluetooth => 'Bluetooth';

  @override
  String get scanning => 'Kutafuta';

  @override
  String get advanced => 'Kwa Utaalamu';

  @override
  String get scanTimeout => 'Muda wa Kutafuta';

  @override
  String get scanTimeoutSubtitle => 'Muda wa kutafuta vifaa';

  @override
  String get connectionTimeout => 'Muda wa Kuunganisha';

  @override
  String get connectionTimeoutSubtitle => 'Muda wa kusubiri miunganisho';

  @override
  String get autoScanOnStart => 'Tafuta Kiotomatiki Mwanzoni';

  @override
  String get autoScanOnStartSubtitle =>
      'Anza kutafuta kiotomatiki wakati programu inapofunguka';

  @override
  String get showUnknownDevices => 'Onyesha Vifaa Visivyojulikana';

  @override
  String get showUnknownDevicesSubtitle =>
      'Onyesha vifaa bila majina ya utangazaji';

  @override
  String get signalStrengthFilter => 'Kichuja cha Nguvu ya Ishara';

  @override
  String get minimumRssi => 'Kiwango cha Chini cha RSSI';

  @override
  String get autoConnect => 'Unganisha Kiotomatiki';

  @override
  String get autoConnectSubtitle => 'Unganisha kiotomatiki na kifaa cha mwisho';

  @override
  String get resetSettingsSubtitle => 'Rejesha mipangilio yote kwa msingi';
}
