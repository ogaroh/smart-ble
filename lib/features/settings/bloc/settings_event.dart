import 'package:equatable/equatable.dart';
import '../../../core/theme/app_theme.dart';

/// Events for Settings
abstract class SettingsEvent extends Equatable {
  const SettingsEvent();

  @override
  List<Object?> get props => [];
}

/// Event to load settings from storage
class LoadSettingsEvent extends SettingsEvent {
  const LoadSettingsEvent();
}

/// Event to update theme mode
class UpdateThemeModeEvent extends SettingsEvent {
  final AppThemeMode themeMode;
  
  const UpdateThemeModeEvent(this.themeMode);
  
  @override
  List<Object> get props => [themeMode];
}

/// Event to update scan timeout
class UpdateScanTimeoutEvent extends SettingsEvent {
  final int timeoutSeconds;
  
  const UpdateScanTimeoutEvent(this.timeoutSeconds);
  
  @override
  List<Object> get props => [timeoutSeconds];
}

/// Event to update connection timeout
class UpdateConnectionTimeoutEvent extends SettingsEvent {
  final int timeoutSeconds;
  
  const UpdateConnectionTimeoutEvent(this.timeoutSeconds);
  
  @override
  List<Object> get props => [timeoutSeconds];
}

/// Event to toggle auto-connect feature
class UpdateAutoConnectEvent extends SettingsEvent {
  final bool enabled;
  
  const UpdateAutoConnectEvent(this.enabled);
  
  @override
  List<Object> get props => [enabled];
}

/// Event to toggle auto-scan on app start
class UpdateAutoScanEvent extends SettingsEvent {
  final bool enabled;
  
  const UpdateAutoScanEvent(this.enabled);
  
  @override
  List<Object> get props => [enabled];
}

/// Event to update RSSI filter threshold
class UpdateRssiThresholdEvent extends SettingsEvent {
  final int threshold;
  
  const UpdateRssiThresholdEvent(this.threshold);
  
  @override
  List<Object> get props => [threshold];
}

/// Event to toggle device name filtering
class UpdateShowUnknownDevicesEvent extends SettingsEvent {
  final bool show;
  
  const UpdateShowUnknownDevicesEvent(this.show);
  
  @override
  List<Object> get props => [show];
}

/// Event to reset all settings to defaults
class ResetSettingsEvent extends SettingsEvent {
  const ResetSettingsEvent();
}