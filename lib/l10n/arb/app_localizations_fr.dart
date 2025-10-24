// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for French (`fr`).
class AppLocalizationsFr extends AppLocalizations {
  AppLocalizationsFr([String locale = 'fr']) : super(locale);

  @override
  String get appTitle => 'SmartBLE';

  @override
  String get deviceDetails => 'Détails du Périphérique';

  @override
  String get settings => 'Paramètres';

  @override
  String get stopScan => 'Arrêter la Recherche';

  @override
  String get startScan => 'Démarrer la Recherche';

  @override
  String get checkBluetooth => 'Vérifier Bluetooth';

  @override
  String get type => 'Type :';

  @override
  String get all => 'Tout';

  @override
  String get searchDevices => 'Rechercher des appareils par nom...';

  @override
  String get initializingBluetooth => 'Initialisation Bluetooth...';

  @override
  String get checkingBluetoothPermissions =>
      'Vérification des permissions Bluetooth...';

  @override
  String get bluetoothPermissionsRequired => 'Permissions Bluetooth requises';

  @override
  String scanningDevicesFound(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'appareils',
      one: 'appareil',
    );
    return 'Recherche en cours... ($count $_temp0 trouvé(s))';
  }

  @override
  String devicesFound(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'appareils',
      one: 'appareil',
    );
    return '$count $_temp0 trouvé(s)';
  }

  @override
  String get retry => 'Réessayer';

  @override
  String get goBack => 'Retour';

  @override
  String get connection => 'Connexion';

  @override
  String get connect => 'Connecter';

  @override
  String get disconnect => 'Déconnecter';

  @override
  String get connecting => 'Connexion...';

  @override
  String get connected => 'Connecté';

  @override
  String get disconnected => 'Déconnecté';

  @override
  String get disconnecting => 'Déconnexion...';

  @override
  String get discoveringServices => 'Découverte des services...';

  @override
  String get connectToDiscoverServices =>
      'Connectez-vous à cet appareil pour découvrir ses services et caractéristiques';

  @override
  String get noServicesFound => 'Aucun service trouvé sur cet appareil';

  @override
  String get servicesAndCharacteristics => 'Services et Caractéristiques';

  @override
  String get noCharacteristicsAvailable => 'Aucune caractéristique disponible';

  @override
  String bytes(String value) {
    return 'Octets : $value';
  }

  @override
  String get empty => 'Vide';

  @override
  String get address => 'Adresse';

  @override
  String get advertisedServices => 'Services Annoncés';

  @override
  String serviceCount(int count) {
    return '$count service(s)';
  }

  @override
  String manufacturer(String name) {
    return 'Fabricant : $name';
  }

  @override
  String get manufacturerUnavailable => 'Fabricant : Non disponible';

  @override
  String get readingManufacturer => 'Lecture du fabricant...';

  @override
  String get manufacturerError => 'Fabricant : Erreur de lecture';

  @override
  String get theme => 'Thème';

  @override
  String get unableToLoadSettings => 'Impossible de charger les paramètres';

  @override
  String get resetSettings => 'Réinitialiser les Paramètres';

  @override
  String get resetSettingsConfirmation =>
      'Êtes-vous sûr de vouloir réinitialiser tous les paramètres à leurs valeurs par défaut ? Cette action ne peut pas être annulée.';

  @override
  String get cancel => 'Annuler';

  @override
  String get reset => 'Réinitialiser';

  @override
  String get light => 'Clair';

  @override
  String get dark => 'Sombre';

  @override
  String get system => 'Système';

  @override
  String get followSystemTheme => 'Suivre le thème du système';

  @override
  String get alwaysUseLightTheme => 'Toujours utiliser le thème clair';

  @override
  String get alwaysUseDarkTheme => 'Toujours utiliser le thème sombre';

  @override
  String get seconds => 'secondes';

  @override
  String get minutes => 'minutes';

  @override
  String get noDevicesFound => 'Aucun appareil trouvé';

  @override
  String get scanningForDevices => 'Recherche d\'appareils...';

  @override
  String get tapStartToScan =>
      'Appuyez sur \"Démarrer l\'analyse\" pour découvrir les appareils BLE à proximité';

  @override
  String get readyToScan => 'Prêt à analyser';

  @override
  String get scanError => 'Erreur d\'analyse';

  @override
  String get errorPrefix => 'Erreur';

  @override
  String get failedToStartScan => 'Échec du démarrage de l\'analyse';

  @override
  String get failedToStopScan => 'Échec de l\'arrêt de l\'analyse';

  @override
  String get bluetoothNotAvailable =>
      'Bluetooth n\'est pas disponible sur cet appareil';

  @override
  String get bluetoothPermissionsDenied =>
      'Les autorisations Bluetooth sont requises pour rechercher des appareils';

  @override
  String get failedToCheckBluetooth =>
      'Échec de la vérification de l\'état Bluetooth';

  @override
  String get appearance => 'Apparence';

  @override
  String get bluetooth => 'Bluetooth';

  @override
  String get scanning => 'Analyse';

  @override
  String get advanced => 'Avancé';

  @override
  String get scanTimeout => 'Délai d\'Analyse';

  @override
  String get scanTimeoutSubtitle => 'Durée d\'analyse des appareils';

  @override
  String get connectionTimeout => 'Délai de Connexion';

  @override
  String get connectionTimeoutSubtitle => 'Durée d\'attente des connexions';

  @override
  String get autoScanOnStart => 'Analyse Automatique au Démarrage';

  @override
  String get autoScanOnStartSubtitle =>
      'Démarrer l\'analyse automatiquement à l\'ouverture de l\'application';

  @override
  String get showUnknownDevices => 'Afficher les Appareils Inconnus';

  @override
  String get showUnknownDevicesSubtitle =>
      'Afficher les appareils sans noms annoncés';

  @override
  String get signalStrengthFilter => 'Filtre d\'Intensité du Signal';

  @override
  String get minimumRssi => 'RSSI Minimum';

  @override
  String get autoConnect => 'Connexion Automatique';

  @override
  String get autoConnectSubtitle =>
      'Se connecter automatiquement au dernier appareil';

  @override
  String get resetSettingsSubtitle =>
      'Restaurer tous les paramètres par défaut';
}
