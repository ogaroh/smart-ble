import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_ble/core/theme/app_theme.dart';
import '../../../core/models/ble_device.dart';
import '../../../core/models/ble_models.dart';
import '../../../l10n/l10n.dart';
import '../bloc/device_detail_bloc.dart';
import '../bloc/device_detail_event.dart';
import '../bloc/device_detail_state.dart';

/// Screen for displaying device details, connection, and services
class DeviceDetailScreen extends StatelessWidget {
  final BleDevice device;

  const DeviceDetailScreen({
    super.key,
    required this.device,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          DeviceDetailBloc()..add(InitializeDeviceEvent(device)),
      child: const DeviceDetailView(),
    );
  }
}

class DeviceDetailView extends StatelessWidget {
  const DeviceDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.l10n.deviceDetails),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: BlocConsumer<DeviceDetailBloc, DeviceDetailState>(
        listener: (context, state) {
          if (state is DeviceDetailError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  state.message,
                  style: TextStyle(color: AppColors.lightSurface),
                ),
                backgroundColor: AppColors.error,
              ),
            );
          } else if (state is DeviceDetailLoaded &&
              state.errorMessage != null) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  state.errorMessage ?? "Error",
                  style: TextStyle(color: AppColors.lightSurface),
                ),
                backgroundColor: AppColors.warning,
              ),
            );
          }
        },
        builder: (context, state) {
          if (state is DeviceDetailInitial) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is DeviceDetailError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.error_outline,
                    size: 64,
                    color: Colors.red[300],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Error: ${state.message}',
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text(context.l10n.goBack),
                  ),
                ],
              ),
            );
          }

          final deviceState = state as DeviceDetailLoaded;
          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildDeviceInfo(context, deviceState),
                const SizedBox(height: 16),
                _buildConnectionCard(context, deviceState),
                const SizedBox(height: 16),
                _buildServicesSection(context, deviceState),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildDeviceInfo(BuildContext context, DeviceDetailLoaded state) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  backgroundColor: _getDeviceTypeColor(state.device.deviceType),
                  child: Icon(
                    _getDeviceTypeIcon(state.device.deviceType),
                    color: Colors.white,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        state.device.name,
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        state.device.deviceType
                            .localizedDisplayName(context.l10n),
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: Colors.grey[600],
                            ),
                      ),
                      const SizedBox(height: 4),
                      _buildManufacturerInfo(context, state),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            const Divider(),
            const SizedBox(height: 8),
            _buildInfoRow('Address', state.device.address),
            _buildInfoRow('RSSI', '${state.device.rssi} dBm'),
            if (state.device.serviceUuids.isNotEmpty)
              _buildInfoRow('Advertised Services',
                  '${state.device.serviceUuids.length} service(s)'),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 100,
            child: Text(
              '$label:',
              style: const TextStyle(fontWeight: FontWeight.w500),
            ),
          ),
          Expanded(
            child: Text(value),
          ),
        ],
      ),
    );
  }

  Widget _buildConnectionCard(BuildContext context, DeviceDetailLoaded state) {
    final isConnected = state.connectionState == BleConnectionState.connected ||
        state is DeviceDetailConnected;
    final isConnecting =
        state.connectionState == BleConnectionState.connecting ||
            state is DeviceDetailConnecting;
    final isDisconnecting =
        state.connectionState == BleConnectionState.disconnecting ||
            state is DeviceDetailDisconnecting;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              context.l10n.connection,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Icon(
                  isConnected
                      ? Icons.bluetooth_connected
                      : isConnecting || isDisconnecting
                          ? Icons.bluetooth_searching
                          : Icons.bluetooth_disabled,
                  color: isConnected
                      ? Colors.green
                      : isConnecting || isDisconnecting
                          ? Colors.orange
                          : Colors.grey,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    state.connectionState.localizedDisplayName(context),
                    style: TextStyle(
                      color: isConnected
                          ? Colors.green
                          : isConnecting || isDisconnecting
                              ? Colors.orange
                              : Colors.grey,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                if (isConnecting || isDisconnecting)
                  const SizedBox(
                    width: 16,
                    height: 16,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  ),
              ],
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: isConnecting || isDisconnecting
                    ? null
                    : () {
                        if (isConnected) {
                          context
                              .read<DeviceDetailBloc>()
                              .add(const DisconnectFromDeviceEvent());
                        } else {
                          context
                              .read<DeviceDetailBloc>()
                              .add(const ConnectToDeviceEvent());
                        }
                      },
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      isConnected ? AppColors.error : AppColors.primaryBlue,
                  foregroundColor: Colors.white,
                ),
                child: Text(isConnected
                    ? context.l10n.disconnect
                    : context.l10n.connect),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildServicesSection(BuildContext context, DeviceDetailLoaded state) {
    if (state.connectionState != BleConnectionState.connected) {
      return Card(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Icon(
                Icons.info_outline,
                size: 48,
                color: Colors.grey[400],
              ),
              const SizedBox(height: 16),
              Text(
                context.l10n.connectToDiscoverServices,
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.grey),
              ),
            ],
          ),
        ),
      );
    }

    if (state is DeviceDetailDiscoveringServices) {
      return Card(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              const CircularProgressIndicator(),
              const SizedBox(height: 16),
              Text(context.l10n.discoveringServices),
            ],
          ),
        ),
      );
    }

    if (state.services.isEmpty) {
      return Card(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Icon(
                Icons.search_off,
                size: 48,
                color: Colors.grey[400],
              ),
              const SizedBox(height: 16),
              const Text(
                'No services found on this device',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey),
              ),
            ],
          ),
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Services & Characteristics',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        const SizedBox(height: 8),
        ...state.services.map((service) => _buildServiceCard(context, service)),
      ],
    );
  }

  Widget _buildServiceCard(BuildContext context, BleServiceModel service) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: ExpansionTile(
        dense: true,
        visualDensity: VisualDensity.compact,
        leading: Icon(
          Icons.settings_bluetooth,
          color: service.isPrimary ? AppColors.primaryBlue : Colors.grey,
        ),
        title: Text(
          service.displayName,
          style: const TextStyle(fontWeight: FontWeight.w600),
        ),
        subtitle: Text(
          service.uuid,
          style: const TextStyle(fontSize: 12, color: Colors.grey),
        ),
        children: [
          if (service.characteristics.isEmpty)
            const ListTile(
              leading: Icon(Icons.info_outline, color: Colors.grey),
              title: Text(
                'No characteristics available',
                style: TextStyle(color: Colors.grey),
              ),
            )
          else
            ...service.characteristics.map((characteristic) =>
                _buildCharacteristicTile(context, service, characteristic)),
        ],
      ),
    );
  }

  Widget _buildCharacteristicTile(BuildContext context, BleServiceModel service,
      BleCharacteristicModel characteristic) {
    return ListTile(
      leading: const Icon(Icons.data_object, color: Colors.green),
      title: Text(characteristic.displayName),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            characteristic.uuid,
            style: const TextStyle(fontSize: 12, color: Colors.grey),
          ),
          const SizedBox(height: 4),
          Wrap(
            spacing: 4,
            children: characteristic.properties
                .map((property) => Chip(
                      label: Text(
                        property.displayName,
                        style: const TextStyle(fontSize: 10),
                      ),
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      visualDensity: VisualDensity.compact,
                    ))
                .toList(),
          ),
          if (characteristic.value != null) ...[
            const SizedBox(height: 4),
            Text(
              'Bytes: ${_formatCharacteristicValue(characteristic.value!)}',
              style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w500),
            ),
          ],
        ],
      ),
      trailing:
          characteristic.properties.contains(BleCharacteristicProperty.read)
              ? IconButton(
                  icon: const Icon(
                    Icons.download,
                    color: AppColors.primaryBlue,
                  ),
                  onPressed: () {
                    context.read<DeviceDetailBloc>().add(
                          ReadCharacteristicEvent(
                              service.uuid, characteristic.uuid),
                        );
                  },
                )
              : null,
    );
  }

  String _formatCharacteristicValue(List<int> value) {
    if (value.isEmpty) return 'Empty';

    // Try to decode as UTF-8 string first
    try {
      final string = String.fromCharCodes(value);
      if (string.isNotEmpty && !string.contains('\u0000')) {
        return '"$string"';
      }
    } catch (e) {
      // Fall back to hex representation
    }

    // Show as hex bytes
    return value
        .map((byte) => byte.toRadixString(16).padLeft(2, '0').toUpperCase())
        .join(' ');
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
        return Colors.pink;
      case BleDeviceType.sportsWatch:
        return Colors.green;
      case BleDeviceType.clock:
        return Colors.teal;
      case BleDeviceType.display:
        return Colors.indigo;
      case BleDeviceType.remoteControl:
        return Colors.deepPurpleAccent;
      default:
        return Colors.pink;
    }
  }

  Widget _buildManufacturerInfo(
      BuildContext context, DeviceDetailLoaded state) {
    switch (state.manufacturerStatus) {
      case ManufacturerInfoStatus.unavailable:
        return Row(
          children: [
            Icon(
              Icons.business,
              size: 14,
              color: Colors.grey[500],
            ),
            const SizedBox(width: 4),
            Text(
              'Manufacturer: Unavailable',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Colors.grey[500],
                    fontStyle: FontStyle.italic,
                  ),
            ),
          ],
        );
      case ManufacturerInfoStatus.loading:
        return Row(
          children: [
            SizedBox(
              width: 12,
              height: 12,
              child: CircularProgressIndicator(
                strokeWidth: 1.5,
                valueColor: AlwaysStoppedAnimation<Color>(Colors.orange[600]!),
              ),
            ),
            const SizedBox(width: 6),
            Text(
              'Reading manufacturer...',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Colors.orange[600],
                    fontStyle: FontStyle.italic,
                  ),
            ),
          ],
        );
      case ManufacturerInfoStatus.available:
        return Row(
          children: [
            Icon(
              Icons.business,
              size: 14,
              color: Colors.green[600],
            ),
            const SizedBox(width: 4),
            Flexible(
              child: Text(
                'Manufacturer: ${state.manufacturerName}',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Colors.green[600],
                      fontWeight: FontWeight.w500,
                    ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        );
      case ManufacturerInfoStatus.error:
        return Row(
          children: [
            Icon(
              Icons.error_outline,
              size: 14,
              color: Colors.red[600],
            ),
            const SizedBox(width: 4),
            Text(
              'Manufacturer: Error reading',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Colors.red[600],
                    fontStyle: FontStyle.italic,
                  ),
            ),
          ],
        );
    }
  }
}
