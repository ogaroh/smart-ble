import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_ble/core/theme/app_theme.dart';
import '../../../core/models/ble_device.dart';
import '../../device_detail/view/device_detail_screen.dart';
import '../../settings/view/settings_screen.dart';
import '../bloc/ble_scan_bloc.dart';
import '../bloc/ble_scan_event.dart';
import '../bloc/ble_scan_state.dart';

/// Main screen for scanning and displaying BLE devices
class BleScanScreen extends StatelessWidget {
  const BleScanScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => BleScanBloc(),
      child: const BleScanView(),
    );
  }
}

class BleScanView extends StatefulWidget {
  const BleScanView({super.key});

  @override
  State<BleScanView> createState() => _BleScanViewState();
}

class _BleScanViewState extends State<BleScanView> {
  final TextEditingController _filterController = TextEditingController();
  BleDeviceType? _selectedDeviceType;

  @override
  void initState() {
    super.initState();
    _filterController.addListener(_onFilterChanged);
  }

  @override
  void dispose() {
    _filterController.removeListener(_onFilterChanged);
    _filterController.dispose();
    super.dispose();
  }

  void _onFilterChanged() {
    context.read<BleScanBloc>().add(UpdateFilterEvent(_filterController.text));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Container(
          margin: const EdgeInsets.only(left: 5.0),
          decoration: BoxDecoration(color: AppColors.lightBackground),
          child: Image.asset(
            'assets/images/app_icon/android_app_icon_adaptive_foreground.png',
            fit: BoxFit.contain,
          ),
        ),
        title: const Text('SmartBLE'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const SettingsScreen(),
                ),
              );
            },
          ),
        ],
      ),
      body: BlocConsumer<BleScanBloc, BleScanState>(
        listener: (context, state) {
          if (state is BleScanError) {
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
          return Column(
            children: [
              _buildHeader(context, state),
              _buildFilters(context, state),
              Expanded(
                child: _buildBody(context, state),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildHeader(BuildContext context, BleScanState state) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildScanButton(context, state),
          const SizedBox(height: 8),
          _buildStatusText(context, state),
        ],
      ),
    );
  }

  Widget _buildScanButton(BuildContext context, BleScanState state) {
    final isScanning = state is BleScanScanning;
    final canScan = state is BleScanReady;

    return SizedBox(
      width: double.infinity,
      child: ElevatedButton.icon(
        onPressed: canScan || isScanning
            ? () {
                if (isScanning) {
                  context.read<BleScanBloc>().add(const StopScanEvent());
                } else {
                  context.read<BleScanBloc>().add(const StartScanEvent());
                }
              }
            : () {
                context
                    .read<BleScanBloc>()
                    .add(const RefreshBluetoothStatusEvent());
              },
        icon: isScanning
            ? const SizedBox(
                width: 16,
                height: 16,
                child: CircularProgressIndicator(
                    strokeWidth: 2, color: Colors.white),
              )
            : Icon(canScan ? Icons.search : Icons.bluetooth_disabled),
        label: Text(isScanning
            ? 'Stop Scan'
            : (canScan ? 'Start Scan' : 'Check Bluetooth')),
        style: ElevatedButton.styleFrom(
          backgroundColor: isScanning
              ? AppColors.error
              : (canScan ? AppColors.primaryBlue : AppColors.warning),
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 12),
        ),
      ),
    );
  }

  Widget _buildStatusText(BuildContext context, BleScanState state) {
    String statusText;
    Color statusColor;

    if (state is BleScanCheckingPermissions) {
      statusText = 'Checking Bluetooth permissions...';
      statusColor = Colors.orange;
    } else if (state is BleScanPermissionsDenied) {
      statusText = 'Bluetooth permissions required';
      statusColor = AppColors.error;
    } else if (state is BleScanBluetoothUnavailable) {
      statusText = state.message;
      statusColor = AppColors.error;
    } else if (state is BleScanScanning) {
      final deviceCount = state.filteredDevices.length;
      statusText =
          'Scanning... ($deviceCount device${deviceCount != 1 ? 's' : ''} found)';
      statusColor = AppColors.primaryBlue;
    } else if (state is BleScanReady) {
      final deviceCount = state.filteredDevices.length;
      statusText = '$deviceCount device${deviceCount != 1 ? 's' : ''} found';
      statusColor = Colors.pinkAccent;
    } else if (state is BleScanError) {
      statusText = 'Error: ${state.message}';
      statusColor = AppColors.error;
    } else {
      statusText = 'Ready to scan';
      statusColor = Colors.grey;
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(Icons.circle, size: 8, color: statusColor),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            statusText,
            style: TextStyle(
              color: statusColor,
              fontWeight: FontWeight.w600,
            ),
            textAlign: TextAlign.start,
          ),
        ),
      ],
    );
  }

  Widget _buildFilters(BuildContext context, BleScanState state) {
    if (state is! BleScanReady) return const SizedBox.shrink();

    return Container(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          // Name filter
          CupertinoSearchTextField(
            controller: _filterController,
            placeholder: 'Search devices by name...',
            borderRadius: BorderRadius.circular(12),
            style: TextStyle(
              color: Theme.of(context).colorScheme.onSurface,
            ),
          ),
          const SizedBox(height: 12),

          // Device type filter
          Row(
            children: [
              const Text('Type:',
                  style: TextStyle(fontWeight: FontWeight.w500)),
              const SizedBox(width: 8),
              Expanded(
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      FilterChip(
                        label: const Text('All'),
                        selected: _selectedDeviceType == null,
                        onSelected: (selected) {
                          if (selected) {
                            setState(() => _selectedDeviceType = null);
                            context
                                .read<BleScanBloc>()
                                .add(const UpdateDeviceTypeFilterEvent(null));
                          }
                        },
                      ),
                      const SizedBox(width: 3),
                      ...BleDeviceType.values
                          .where((type) =>
                              type != BleDeviceType.unknown &&
                              type != BleDeviceType.other)
                          .map((deviceType) => Padding(
                                padding: const EdgeInsets.only(right: 3),
                                child: _buildDeviceTypeFilterChip(deviceType),
                              )),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBody(BuildContext context, BleScanState state) {
    if (state is BleScanInitial || state is BleScanCheckingPermissions) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(),
            SizedBox(height: 16),
            Text('Initializing Bluetooth...'),
          ],
        ),
      );
    }

    if (state is BleScanPermissionsDenied ||
        state is BleScanBluetoothUnavailable) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.bluetooth_disabled,
              size: 64,
              color: Colors.grey[400],
            ),
            const SizedBox(height: 16),
            Text(
              state is BleScanPermissionsDenied
                  ? state.message
                  : (state as BleScanBluetoothUnavailable).message,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                context
                    .read<BleScanBloc>()
                    .add(const RefreshBluetoothStatusEvent());
              },
              child: const Text('Retry'),
            ),
          ],
        ),
      );
    }

    if (state is BleScanReady) {
      if (state.filteredDevices.isEmpty) {
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.bluetooth_searching,
                size: 64,
                color: Colors.grey[400],
              ),
              const SizedBox(height: 16),
              Text(
                state is BleScanScanning
                    ? 'Scanning for devices...'
                    : 'No devices found',
                style: const TextStyle(fontSize: 16),
              ),
              if (state is! BleScanScanning) ...[
                const SizedBox(height: 8),
                const Text(
                  'Tap "Start Scan" to discover nearby BLE devices',
                  style: TextStyle(color: Colors.grey),
                ),
              ],
            ],
          ),
        );
      }

      return RefreshIndicator(
        onRefresh: () async {
          context.read<BleScanBloc>().add(const ClearDevicesEvent());
          context.read<BleScanBloc>().add(const StartScanEvent());
        },
        child: ListView.builder(
          padding: const EdgeInsets.all(8),
          itemCount: state.filteredDevices.length,
          itemBuilder: (context, index) {
            final device = state.filteredDevices[index];
            return _buildDeviceCard(context, device);
          },
        ),
      );
    }

    return const SizedBox.shrink();
  }

  Widget _buildDeviceCard(BuildContext context, BleDevice device) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: _getDeviceTypeColor(device.deviceType),
          child: Icon(
            _getDeviceTypeIcon(device.deviceType),
            color: Colors.white,
          ),
        ),
        title: Text(
          device.name,
          style: const TextStyle(fontWeight: FontWeight.w600),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(device.address),
            Text(
              '${device.deviceType.displayName} • RSSI: ${device.rssi} dBm',
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: 12,
              ),
            ),
          ],
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: _getRssiColor(device.rssi).withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: _getRssiColor(device.rssi).withValues(alpha: 0.3),
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    _getRssiIcon(device.rssi),
                    size: 16,
                    color: _getRssiColor(device.rssi),
                  ),
                  const SizedBox(width: 4),
                  Text(
                    _getRssiText(device.rssi),
                    style: TextStyle(
                      color: _getRssiColor(device.rssi),
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            const Icon(Icons.chevron_right),
          ],
        ),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DeviceDetailScreen(device: device),
            ),
          );
        },
      ),
    );
  }

  IconData _getDeviceTypeIcon(BleDeviceType deviceType) {
    switch (deviceType) {
      case BleDeviceType.audio:
        return Icons.headphones;
      case BleDeviceType.watch:
        return Icons.watch;
      case BleDeviceType.other:
        return Icons.device_unknown;
      case BleDeviceType.unknown:
        return Icons.bluetooth;
      case BleDeviceType.computer:
        return Icons.computer;
      case BleDeviceType.sportsWatch:
        return Icons.fitness_center;
      case BleDeviceType.clock:
        return Icons.access_time;
      case BleDeviceType.display:
        return Icons.monitor;
      case BleDeviceType.remoteControl:
        return Icons.settings_remote;
      case BleDeviceType.glasses:
        return Icons.visibility;
      case BleDeviceType.tag:
        return Icons.local_offer;
      case BleDeviceType.keyring:
        return Icons.vpn_key;
      case BleDeviceType.phone:
        return Icons.smartphone;
    }
  }

  Color _getDeviceTypeColor(BleDeviceType deviceType) {
    switch (deviceType) {
      case BleDeviceType.audio:
        return Colors.purple;
      case BleDeviceType.watch:
        return AppColors.primaryBlue;
      case BleDeviceType.other:
        return Colors.orange;
      case BleDeviceType.unknown:
        return Colors.grey;
      case BleDeviceType.computer:
        return Colors.teal;
      case BleDeviceType.sportsWatch:
        return Colors.green;
      case BleDeviceType.clock:
        return Colors.indigo;
      case BleDeviceType.display:
        return Colors.cyan;
      case BleDeviceType.remoteControl:
        return Colors.deepPurple;
      case BleDeviceType.glasses:
        return Colors.amber;
      case BleDeviceType.tag:
        return Colors.pink;
      case BleDeviceType.keyring:
        return Colors.brown;
      case BleDeviceType.phone:
        return Colors.red;
    }
  }

  IconData _getRssiIcon(int rssi) {
    if (rssi >= -50) return Icons.network_cell;
    if (rssi >= -70) return Icons.network_cell;
    if (rssi >= -85) return Icons.network_cell;
    return Icons.network_cell;
  }

  Color _getRssiColor(int rssi) {
    if (rssi >= -50) return Colors.green;
    if (rssi >= -70) return Colors.orange;
    return AppColors.error;
  }

  String _getRssiText(int rssi) {
    if (rssi >= -50) return 'Strong';
    if (rssi >= -70) return 'Good';
    if (rssi >= -85) return 'Fair';
    return 'Weak';
  }

  Widget _buildDeviceTypeFilterChip(BleDeviceType deviceType) {
    return FilterChip(
      label: Text(deviceType.displayName),
      selected: _selectedDeviceType == deviceType,
      onSelected: (selected) {
        final selectedType = selected ? deviceType : null;
        setState(() => _selectedDeviceType = selectedType);
        context
            .read<BleScanBloc>()
            .add(UpdateDeviceTypeFilterEvent(selectedType));
      },
    );
  }
}
