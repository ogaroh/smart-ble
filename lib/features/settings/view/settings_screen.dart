import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/theme/app_theme.dart';
import '../../../l10n/l10n.dart';
import '../bloc/settings_bloc.dart';
import '../bloc/settings_event.dart';
import '../bloc/settings_state.dart';

/// Settings screen for app configuration
class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: globalSettingsBloc,
      child: const SettingsView(),
    );
  }
}

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.l10n.settings),
        backgroundColor: Theme.of(context).colorScheme.surface,
        elevation: 0,
      ),
      body: BlocConsumer<SettingsBloc, SettingsState>(
        listener: (context, state) {
          if (state is SettingsError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  state.message,
                  style: TextStyle(color: AppColors.lightSurface),
                ),
                backgroundColor: AppColors.error,
              ),
            );
          }
        },
        builder: (context, state) {
          if (state is SettingsLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (state is! SettingsLoaded) {
            return Center(
              child: Text(context.l10n.unableToLoadSettings),
            );
          }

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildAppearanceSection(context, state),
                const SizedBox(height: 12),
                _buildBluetoothSection(context, state),
                const SizedBox(height: 12),
                _buildScanningSection(context, state),
                const SizedBox(height: 12),
                _buildAdvancedSection(context, state),
                const SizedBox(height: 12),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildAppearanceSection(BuildContext context, SettingsLoaded state) {
    return _buildSection(
      context,
      title: context.l10n.appearance,
      icon: Icons.palette,
      children: [
        _buildThemeTile(context, state),
      ],
    );
  }

  Widget _buildBluetoothSection(BuildContext context, SettingsLoaded state) {
    return _buildSection(
      context,
      title: context.l10n.bluetooth,
      icon: Icons.bluetooth,
      children: [
        _buildTimeoutTile(
          context,
          title: context.l10n.scanTimeout,
          subtitle: context.l10n.scanTimeoutSubtitle,
          value: state.scanTimeoutSeconds,
          unit: context.l10n.seconds,
          onChanged: (value) {
            context.read<SettingsBloc>().add(UpdateScanTimeoutEvent(value));
          },
        ),
        _buildTimeoutTile(
          context,
          title: context.l10n.connectionTimeout,
          subtitle: context.l10n.connectionTimeoutSubtitle,
          value: state.connectionTimeoutSeconds,
          unit: context.l10n.seconds,
          onChanged: (value) {
            context
                .read<SettingsBloc>()
                .add(UpdateConnectionTimeoutEvent(value));
          },
        ),
      ],
    );
  }

  Widget _buildScanningSection(BuildContext context, SettingsLoaded state) {
    return _buildSection(
      context,
      title: context.l10n.scanning,
      icon: Icons.search,
      children: [
        _buildSwitchTile(
          context,
          title: context.l10n.autoScanOnStart,
          subtitle: context.l10n.autoScanOnStartSubtitle,
          value: state.autoScanOnStart,
          onChanged: (value) {
            context.read<SettingsBloc>().add(UpdateAutoScanEvent(value));
          },
        ),
        _buildSwitchTile(
          context,
          title: context.l10n.showUnknownDevices,
          subtitle: context.l10n.showUnknownDevicesSubtitle,
          value: state.showUnknownDevices,
          onChanged: (value) {
            context
                .read<SettingsBloc>()
                .add(UpdateShowUnknownDevicesEvent(value));
          },
        ),
        _buildSliderTile(
          context,
          title: context.l10n.signalStrengthFilter,
          subtitle: '${context.l10n.minimumRssi}: ${state.rssiThreshold} dBm',
          value: state.rssiThreshold.toDouble(),
          min: -100,
          max: -30,
          divisions: 70,
          onChanged: (value) {
            context
                .read<SettingsBloc>()
                .add(UpdateRssiThresholdEvent(value.round()));
          },
        ),
      ],
    );
  }

  Widget _buildAdvancedSection(BuildContext context, SettingsLoaded state) {
    return _buildSection(
      context,
      title: context.l10n.advanced,
      icon: Icons.settings_applications,
      children: [
        _buildSwitchTile(
          context,
          title: context.l10n.autoConnect,
          subtitle: context.l10n.autoConnectSubtitle,
          value: state.autoConnect,
          onChanged: (value) {
            context.read<SettingsBloc>().add(UpdateAutoConnectEvent(value));
          },
        ),
        _buildActionTile(
          context,
          title: context.l10n.resetSettings,
          subtitle: context.l10n.resetSettingsSubtitle,
          icon: Icons.restore,
          onTap: () => _showResetDialog(context),
          color: AppColors.error,
        ),
        Divider(
          color: AppColors.lightPink,
        ),
        InkWell(
          child: Center(
            child: Builder(builder: (context) {
              final year = DateTime.now().year;
              return Text(
                "© $year Erick Ogaro. All rights reserved.",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 10.0,
                ),
              );
            }),
          ),
          onTap: () => showLicensePage(context: context),
        ),
  
      ],
    );
  }

  Widget _buildSection(
    BuildContext context, {
    required String title,
    required IconData icon,
    required List<Widget> children,
  }) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  icon,
                  color: Theme.of(context).colorScheme.primary,
                  size: 20,
                ),
                const SizedBox(width: 12),
                Text(
                  title,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            ...children,
          ],
        ),
      ),
    );
  }

  Widget _buildThemeTile(BuildContext context, SettingsLoaded state) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      title: Text(context.l10n.theme),
      subtitle: Text(state.themeMode.localizedDescription(context.l10n)),
      trailing: DropdownButton<AppThemeMode>(
        value: state.themeMode,
        underline: const SizedBox.shrink(),
        items: AppThemeMode.values.map((mode) {
          return DropdownMenuItem<AppThemeMode>(
            value: mode,
            child: Text(mode.localizedDisplayName(context.l10n)),
          );
        }).toList(),
        onChanged: (mode) {
          if (mode != null) {
            context.read<SettingsBloc>().add(UpdateThemeModeEvent(mode));
          }
        },
      ),
    );
  }

  Widget _buildSwitchTile(
    BuildContext context, {
    required String title,
    required String subtitle,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      title: Text(title),
      subtitle: Text(subtitle),
      trailing: CupertinoSwitch(
        value: value,
        onChanged: onChanged,
        activeTrackColor: Theme.of(context).colorScheme.primary,
      ),
    );
  }

  Widget _buildTimeoutTile(
    BuildContext context, {
    required String title,
    required String subtitle,
    required int value,
    required String unit,
    required ValueChanged<int> onChanged,
  }) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      title: Text(title),
      subtitle: Text(subtitle),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('$value $unit'),
          const SizedBox(width: 8),
          PopupMenuButton<int>(
            initialValue: value,
            onSelected: onChanged,
            itemBuilder: (context) {
              final options = [5, 10, 15, 20, 30, 45, 60];
              return options.map((option) {
                return PopupMenuItem(
                  value: option,
                  child: Text('$option $unit'),
                );
              }).toList();
            },
            child: Icon(
              Icons.keyboard_arrow_down,
              color: Theme.of(context).colorScheme.onSurface,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSliderTile(
    BuildContext context, {
    required String title,
    required String subtitle,
    required double value,
    required double min,
    required double max,
    required int divisions,
    required ValueChanged<double> onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ListTile(
          contentPadding: EdgeInsets.zero,
          title: Text(title),
          subtitle: Text(subtitle),
        ),
        Slider(
          value: value,
          min: min,
          max: max,
          divisions: divisions,
          onChanged: onChanged,
          activeColor: Theme.of(context).colorScheme.primary,
        ),
      ],
    );
  }

  Widget _buildActionTile(
    BuildContext context, {
    required String title,
    required String subtitle,
    required IconData icon,
    required VoidCallback onTap,
    Color? color,
  }) {
    final effectiveColor = color ?? Theme.of(context).colorScheme.primary;

    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Icon(icon, color: effectiveColor),
      title: Text(
        title,
        style: TextStyle(color: effectiveColor),
      ),
      subtitle: Text(subtitle),
      onTap: onTap,
    );
  }

  void _showResetDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text(context.l10n.resetSettings),
        content: Text(context.l10n.resetSettingsConfirmation),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(),
            child: Text(context.l10n.cancel),
          ),
          FilledButton(
            onPressed: () {
              Navigator.of(dialogContext).pop();
              context.read<SettingsBloc>().add(const ResetSettingsEvent());
            },
            style: FilledButton.styleFrom(
              backgroundColor: AppColors.error,
            ),
            child: Text(context.l10n.reset),
          ),
        ],
      ),
    );
  }
}
