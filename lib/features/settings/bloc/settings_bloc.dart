import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../core/theme/app_theme.dart';
import 'settings_event.dart';
import 'settings_state.dart';

/// BLoC for managing app settings
class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  late final SharedPreferences _prefs;
  
  SettingsBloc() : super(const SettingsInitial()) {
    on<LoadSettingsEvent>(_onLoadSettings);
    on<UpdateThemeModeEvent>(_onUpdateThemeMode);
    on<UpdateScanTimeoutEvent>(_onUpdateScanTimeout);
    on<UpdateConnectionTimeoutEvent>(_onUpdateConnectionTimeout);
    on<UpdateAutoConnectEvent>(_onUpdateAutoConnect);
    on<UpdateAutoScanEvent>(_onUpdateAutoScan);
    on<UpdateRssiThresholdEvent>(_onUpdateRssiThreshold);
    on<UpdateShowUnknownDevicesEvent>(_onUpdateShowUnknownDevices);
    on<ResetSettingsEvent>(_onResetSettings);
    
    // Load settings on initialization
    _initializeSettings();
  }
  
  /// Keys for SharedPreferences
  static const String _themeModeKey = 'theme_mode';
  static const String _scanTimeoutKey = 'scan_timeout';
  static const String _connectionTimeoutKey = 'connection_timeout';
  static const String _autoConnectKey = 'auto_connect';
  static const String _autoScanKey = 'auto_scan';
  static const String _rssiThresholdKey = 'rssi_threshold';
  static const String _showUnknownDevicesKey = 'show_unknown_devices';
  
  /// Public method to initialize settings
  Future<void> initializeSettings() async {
    await _initializeSettings();
  }

  /// Initialize SharedPreferences
  Future<void> _initializeSettings() async {
    try {
      _prefs = await SharedPreferences.getInstance();
      add(const LoadSettingsEvent());
    } catch (e) {
      // Handle initialization error in the event handler instead
      rethrow;
    }
  }
  
  /// Load settings from SharedPreferences
  Future<void> _onLoadSettings(LoadSettingsEvent event, Emitter<SettingsState> emit) async {
    try {
      emit(const SettingsLoading());
      
      // Load theme mode
      final themeModeIndex = _prefs.getInt(_themeModeKey) ?? AppThemeMode.system.index;
      final themeMode = AppThemeMode.values[themeModeIndex];
      
      // Load other settings with defaults
      final scanTimeout = _prefs.getInt(_scanTimeoutKey) ?? 15;
      final connectionTimeout = _prefs.getInt(_connectionTimeoutKey) ?? 15;
      final autoConnect = _prefs.getBool(_autoConnectKey) ?? false;
      final autoScan = _prefs.getBool(_autoScanKey) ?? false;
      final rssiThreshold = _prefs.getInt(_rssiThresholdKey) ?? -100;
      final showUnknownDevices = _prefs.getBool(_showUnknownDevicesKey) ?? true;
      
      emit(SettingsLoaded(
        themeMode: themeMode,
        scanTimeoutSeconds: scanTimeout,
        connectionTimeoutSeconds: connectionTimeout,
        autoConnect: autoConnect,
        autoScanOnStart: autoScan,
        rssiThreshold: rssiThreshold,
        showUnknownDevices: showUnknownDevices,
      ));
    } catch (e) {
      emit(SettingsError('Failed to load settings: $e'));
    }
  }
  
  /// Update theme mode
  Future<void> _onUpdateThemeMode(UpdateThemeModeEvent event, Emitter<SettingsState> emit) async {
    if (state is SettingsLoaded) {
      try {
        await _prefs.setInt(_themeModeKey, event.themeMode.index);
        final currentState = state as SettingsLoaded;
        emit(currentState.copyWith(themeMode: event.themeMode));
      } catch (e) {
        emit(SettingsError('Failed to update theme mode: $e'));
      }
    }
  }
  
  /// Update scan timeout
  Future<void> _onUpdateScanTimeout(UpdateScanTimeoutEvent event, Emitter<SettingsState> emit) async {
    if (state is SettingsLoaded) {
      try {
        await _prefs.setInt(_scanTimeoutKey, event.timeoutSeconds);
        final currentState = state as SettingsLoaded;
        emit(currentState.copyWith(scanTimeoutSeconds: event.timeoutSeconds));
      } catch (e) {
        emit(SettingsError('Failed to update scan timeout: $e'));
      }
    }
  }
  
  /// Update connection timeout
  Future<void> _onUpdateConnectionTimeout(UpdateConnectionTimeoutEvent event, Emitter<SettingsState> emit) async {
    if (state is SettingsLoaded) {
      try {
        await _prefs.setInt(_connectionTimeoutKey, event.timeoutSeconds);
        final currentState = state as SettingsLoaded;
        emit(currentState.copyWith(connectionTimeoutSeconds: event.timeoutSeconds));
      } catch (e) {
        emit(SettingsError('Failed to update connection timeout: $e'));
      }
    }
  }
  
  /// Update auto-connect setting
  Future<void> _onUpdateAutoConnect(UpdateAutoConnectEvent event, Emitter<SettingsState> emit) async {
    if (state is SettingsLoaded) {
      try {
        await _prefs.setBool(_autoConnectKey, event.enabled);
        final currentState = state as SettingsLoaded;
        emit(currentState.copyWith(autoConnect: event.enabled));
      } catch (e) {
        emit(SettingsError('Failed to update auto-connect: $e'));
      }
    }
  }
  
  /// Update auto-scan setting
  Future<void> _onUpdateAutoScan(UpdateAutoScanEvent event, Emitter<SettingsState> emit) async {
    if (state is SettingsLoaded) {
      try {
        await _prefs.setBool(_autoScanKey, event.enabled);
        final currentState = state as SettingsLoaded;
        emit(currentState.copyWith(autoScanOnStart: event.enabled));
      } catch (e) {
        emit(SettingsError('Failed to update auto-scan: $e'));
      }
    }
  }
  
  /// Update RSSI threshold
  Future<void> _onUpdateRssiThreshold(UpdateRssiThresholdEvent event, Emitter<SettingsState> emit) async {
    if (state is SettingsLoaded) {
      try {
        await _prefs.setInt(_rssiThresholdKey, event.threshold);
        final currentState = state as SettingsLoaded;
        emit(currentState.copyWith(rssiThreshold: event.threshold));
      } catch (e) {
        emit(SettingsError('Failed to update RSSI threshold: $e'));
      }
    }
  }
  
  /// Update show unknown devices setting
  Future<void> _onUpdateShowUnknownDevices(UpdateShowUnknownDevicesEvent event, Emitter<SettingsState> emit) async {
    if (state is SettingsLoaded) {
      try {
        await _prefs.setBool(_showUnknownDevicesKey, event.show);
        final currentState = state as SettingsLoaded;
        emit(currentState.copyWith(showUnknownDevices: event.show));
      } catch (e) {
        emit(SettingsError('Failed to update show unknown devices: $e'));
      }
    }
  }
  
  /// Reset all settings to defaults
  Future<void> _onResetSettings(ResetSettingsEvent event, Emitter<SettingsState> emit) async {
    try {
      emit(const SettingsLoading());
      
      // Clear all settings
      await _prefs.clear();
      
      // Emit default settings
      emit(const SettingsLoaded());
    } catch (e) {
      emit(SettingsError('Failed to reset settings: $e'));
    }
  }
}

/// Global instance for easy access
SettingsBloc? _globalSettingsBloc;

SettingsBloc get globalSettingsBloc {
  _globalSettingsBloc ??= SettingsBloc();
  return _globalSettingsBloc!;
}