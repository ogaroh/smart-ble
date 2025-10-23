import 'package:equatable/equatable.dart';
import '../../../core/theme/app_theme.dart';

/// States for Settings
abstract class SettingsState extends Equatable {
  const SettingsState();

  @override
  List<Object?> get props => [];
}

/// Initial settings state
class SettingsInitial extends SettingsState {
  const SettingsInitial();
}

/// Settings loading state
class SettingsLoading extends SettingsState {
  const SettingsLoading();
}

/// Settings loaded state
class SettingsLoaded extends SettingsState {
  final AppThemeMode themeMode;
  final int scanTimeoutSeconds;
  final int connectionTimeoutSeconds;
  final bool autoConnect;
  final bool autoScanOnStart;
  final int rssiThreshold;
  final bool showUnknownDevices;
  
  const SettingsLoaded({
    this.themeMode = AppThemeMode.system,
    this.scanTimeoutSeconds = 15,
    this.connectionTimeoutSeconds = 15,
    this.autoConnect = false,
    this.autoScanOnStart = false,
    this.rssiThreshold = -100,
    this.showUnknownDevices = true,
  });
  
  @override
  List<Object?> get props => [
    themeMode,
    scanTimeoutSeconds,
    connectionTimeoutSeconds,
    autoConnect,
    autoScanOnStart,
    rssiThreshold,
    showUnknownDevices,
  ];
  
  SettingsLoaded copyWith({
    AppThemeMode? themeMode,
    int? scanTimeoutSeconds,
    int? connectionTimeoutSeconds,
    bool? autoConnect,
    bool? autoScanOnStart,
    int? rssiThreshold,
    bool? showUnknownDevices,
  }) {
    return SettingsLoaded(
      themeMode: themeMode ?? this.themeMode,
      scanTimeoutSeconds: scanTimeoutSeconds ?? this.scanTimeoutSeconds,
      connectionTimeoutSeconds: connectionTimeoutSeconds ?? this.connectionTimeoutSeconds,
      autoConnect: autoConnect ?? this.autoConnect,
      autoScanOnStart: autoScanOnStart ?? this.autoScanOnStart,
      rssiThreshold: rssiThreshold ?? this.rssiThreshold,
      showUnknownDevices: showUnknownDevices ?? this.showUnknownDevices,
    );
  }
  
  /// Get scan timeout as Duration
  Duration get scanTimeout => Duration(seconds: scanTimeoutSeconds);
  
  /// Get connection timeout as Duration
  Duration get connectionTimeout => Duration(seconds: connectionTimeoutSeconds);
  
  /// Check if device should be shown based on RSSI threshold
  bool shouldShowDevice(int rssi) {
    return rssi >= rssiThreshold;
  }
}

/// Settings error state
class SettingsError extends SettingsState {
  final String message;
  
  const SettingsError(this.message);
  
  @override
  List<Object> get props => [message];
}

