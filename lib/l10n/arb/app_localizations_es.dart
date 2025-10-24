// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get appTitle => 'SmartBLE';

  @override
  String get deviceDetails => 'Detalles del Dispositivo';

  @override
  String get settings => 'Configuración';

  @override
  String get stopScan => 'Detener Búsqueda';

  @override
  String get startScan => 'Iniciar Búsqueda';

  @override
  String get checkBluetooth => 'Verificar Bluetooth';

  @override
  String get type => 'Tipo:';

  @override
  String get all => 'Todos';

  @override
  String get searchDevices => 'Buscar dispositivos por nombre...';

  @override
  String get initializingBluetooth => 'Inicializando Bluetooth...';

  @override
  String get checkingBluetoothPermissions =>
      'Verificando permisos de Bluetooth...';

  @override
  String get bluetoothPermissionsRequired =>
      'Se requieren permisos de Bluetooth';

  @override
  String scanningDevicesFound(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'dispositivos',
      one: 'dispositivo',
    );
    return 'Buscando... ($count $_temp0 encontrado(s))';
  }

  @override
  String devicesFound(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'dispositivos',
      one: 'dispositivo',
    );
    return '$count $_temp0 encontrado(s)';
  }

  @override
  String get retry => 'Reintentar';

  @override
  String get goBack => 'Volver';

  @override
  String get connection => 'Conexión';

  @override
  String get connect => 'Conectar';

  @override
  String get disconnect => 'Desconectar';

  @override
  String get connecting => 'Conectando...';

  @override
  String get connected => 'Conectado';

  @override
  String get disconnected => 'Desconectado';

  @override
  String get disconnecting => 'Desconectando...';

  @override
  String get discoveringServices => 'Descubriendo servicios...';

  @override
  String get connectToDiscoverServices =>
      'Conecta a este dispositivo para descubrir sus servicios y características';

  @override
  String get noServicesFound =>
      'No se encontraron servicios en este dispositivo';

  @override
  String get servicesAndCharacteristics => 'Servicios y Características';

  @override
  String get noCharacteristicsAvailable => 'No hay características disponibles';

  @override
  String bytes(String value) {
    return 'Bytes: $value';
  }

  @override
  String get empty => 'Vacío';

  @override
  String get address => 'Dirección';

  @override
  String get advertisedServices => 'Servicios Anunciados';

  @override
  String serviceCount(int count) {
    return '$count servicio(s)';
  }

  @override
  String manufacturer(String name) {
    return 'Fabricante: $name';
  }

  @override
  String get manufacturerUnavailable => 'Fabricante: No disponible';

  @override
  String get readingManufacturer => 'Leyendo fabricante...';

  @override
  String get manufacturerError => 'Fabricante: Error al leer';

  @override
  String get theme => 'Tema';

  @override
  String get unableToLoadSettings => 'No se puede cargar la configuración';

  @override
  String get resetSettings => 'Restablecer Configuración';

  @override
  String get resetSettingsConfirmation =>
      '¿Estás seguro de que quieres restablecer toda la configuración a sus valores predeterminados? Esta acción no se puede deshacer.';

  @override
  String get cancel => 'Cancelar';

  @override
  String get reset => 'Restablecer';

  @override
  String get light => 'Claro';

  @override
  String get dark => 'Oscuro';

  @override
  String get system => 'Sistema';

  @override
  String get seconds => 'segundos';

  @override
  String get minutes => 'minutos';

  @override
  String get noDevicesFound => 'No se encontraron dispositivos';

  @override
  String get scanningForDevices => 'Buscando dispositivos...';

  @override
  String get tapStartToScan =>
      'Toca \"Iniciar Búsqueda\" para descubrir dispositivos BLE cercanos';

  @override
  String get readyToScan => 'Listo para escanear';

  @override
  String get scanError => 'Error de búsqueda';

  @override
  String get errorPrefix => 'Error';

  @override
  String get failedToStartScan => 'Error al iniciar búsqueda';

  @override
  String get failedToStopScan => 'Error al detener búsqueda';

  @override
  String get bluetoothNotAvailable =>
      'Bluetooth no está disponible en este dispositivo';

  @override
  String get bluetoothPermissionsDenied =>
      'Se requieren permisos de Bluetooth para buscar dispositivos';

  @override
  String get failedToCheckBluetooth =>
      'Error al verificar el estado del Bluetooth';

  @override
  String get appearance => 'Apariencia';

  @override
  String get bluetooth => 'Bluetooth';

  @override
  String get scanning => 'Escaneo';

  @override
  String get advanced => 'Avanzado';

  @override
  String get scanTimeout => 'Tiempo de Espera de Escaneo';

  @override
  String get scanTimeoutSubtitle => 'Cuánto tiempo escanear dispositivos';

  @override
  String get connectionTimeout => 'Tiempo de Espera de Conexión';

  @override
  String get connectionTimeoutSubtitle =>
      'Cuánto tiempo esperar las conexiones';

  @override
  String get autoScanOnStart => 'Escaneo Automático al Iniciar';

  @override
  String get autoScanOnStartSubtitle =>
      'Comenzar escaneo automáticamente al abrir la aplicación';

  @override
  String get showUnknownDevices => 'Mostrar Dispositivos Desconocidos';

  @override
  String get showUnknownDevicesSubtitle =>
      'Mostrar dispositivos sin nombres anunciados';

  @override
  String get signalStrengthFilter => 'Filtro de Intensidad de Señal';

  @override
  String get minimumRssi => 'RSSI Mínimo';

  @override
  String get autoConnect => 'Conexión Automática';

  @override
  String get autoConnectSubtitle =>
      'Conectar automáticamente al último dispositivo';

  @override
  String get resetSettingsSubtitle =>
      'Restaurar todas las configuraciones por defecto';
}
