# SmartBLE

A Flutter application for scanning and connecting to Bluetooth Low Energy (BLE) smart devices. This app provides a clean, modern interface for discovering nearby BLE devices, viewing their information, and exploring their services and characteristics.

## Features

### BLE Scan Screen
- **Permission Management**: Automatically requests and handles Bluetooth and Location permissions (including Android 12+ BLUETOOTH_SCAN and BLUETOOTH_CONNECT permissions)
- **Bluetooth Status Detection**: Detects and prompts users to enable Bluetooth when disabled
- **Real-time Device Scanning**: Start/stop BLE scanning with real-time device discovery
- **Comprehensive Device Information**: Displays device name, MAC address/UUID, and signal strength (RSSI)
- **Smart Filtering**: 
  - Text-based filtering by device name
  - Predefined filters for device types (Audio Devices, Smartwatches)
- **Intuitive Navigation**: Tap any device to view detailed information

### Device Detail Screen
- **Device Information**: Shows selected device's name, address, and current RSSI
- **Connection Management**: Connect/disconnect with real-time connection state updates
- **Service Discovery**: Automatic discovery of device services and characteristics upon connection
- **Service/Characteristic Explorer**: Expandable list showing all services with their characteristics and properties (Read, Write, Notify)

## Technical Stack

- **Framework**: Flutter & Dart (stable version)
- **BLE Integration**: flutter_blue_plus package
- **UI Design**: Material 3 design principles
- **Platform Support**: Android and iOS with proper native configurations

## Getting Started

### Prerequisites
- Flutter SDK (stable version)
- Android Studio / Xcode for platform-specific development
- Physical device with Bluetooth capabilities (BLE scanning requires hardware)

### Installation

1. Clone the repository:
```bash
git clone <repository-url>
cd smart_ble
```

2. Install dependencies:
```bash
flutter pub get
```

3. Run the application:

**For development flavor:**
```bash
flutter run --flavor dev
```

**For staging flavor:**
```bash
flutter run --flavor stag
```

**For production flavor:**
```bash
flutter run --flavor prod
```

**Build APK:**
```bash
flutter build apk --flavor dev --debug
# or for release
flutter build apk --flavor prod --release
```

### Platform Configuration

#### Android
- Configured AndroidManifest.xml with required Bluetooth permissions
- Supports Android 12+ permission model (BLUETOOTH_SCAN, BLUETOOTH_CONNECT)
- Location permissions for BLE scanning

#### iOS
- Info.plist configured with Bluetooth usage descriptions
- Background modes for maintaining BLE connections

## App Flavors

The project is configured with three flavors for different environments:

- **dev**: Development environment (`SmartBLE Dev`)
  - Package ID: `dev.ogaroh.smart_ble.dev`
  - For development and testing

- **stag**: Staging environment (`SmartBLE Stag`)
  - Package ID: `dev.ogaroh.smart_ble.stag`
  - For pre-production testing

- **prod**: Production environment (`SmartBLE`)
  - Package ID: `dev.ogaroh.smart_ble`
  - For app store releases

## State Management

The application uses **Flutter BLoC (Business Logic Component)** pattern for state management, providing a predictable and testable architecture for handling complex BLE operations.

### Architecture Overview

The app follows a feature-based architecture with clear separation of concerns:

```
lib/
├── core/
│   ├── models/           # Domain models (BLE devices, services, characteristics)
│   └── repositories/     # Data access layer (BLE repository)
├── features/
│   ├── ble_scan/        # BLE scanning feature
│   │   ├── bloc/        # State management (BleScanBloc)
│   │   └── view/        # UI components (BleScanScreen)
│   └── device_detail/   # Device connection feature  
│       ├── bloc/        # State management (DeviceDetailBloc)
│       └── view/        # UI components (DeviceDetailScreen)
└── app.dart            # App configuration
```

### BLoC Implementation

#### 1. BLE Scan BLoC (`BleScanBloc`)
- **Purpose**: Manages device discovery, filtering, and scanning state
- **Key Events**:
  - `StartScanEvent` - Initiates BLE scanning
  - `StopScanEvent` - Stops BLE scanning  
  - `UpdateFilterEvent` - Updates name-based filtering
  - `UpdateDeviceTypeFilterEvent` - Updates device type filtering
  - `RefreshBluetoothStatusEvent` - Checks permissions and BT status
- **Key States**:
  - `BleScanReady` - Ready to scan with discovered devices
  - `BleScanScanning` - Actively scanning for devices
  - `BleScanPermissionsDenied` - Missing required permissions
  - `BleScanError` - Error occurred during scanning

#### 2. Device Detail BLoC (`DeviceDetailBloc`) 
- **Purpose**: Manages device connection, service discovery, and characteristic operations
- **Key Events**:
  - `ConnectToDeviceEvent` - Connects to selected device
  - `DisconnectFromDeviceEvent` - Disconnects from device
  - `DiscoverServicesEvent` - Discovers device services/characteristics
  - `ReadCharacteristicEvent` - Reads characteristic values
- **Key States**:
  - `DeviceDetailLoaded` - Device loaded, disconnected
  - `DeviceDetailConnecting` - Connection in progress
  - `DeviceDetailConnected` - Connected with services available
  - `DeviceDetailDiscoveringServices` - Discovering services

### Repository Pattern

#### BLE Repository (`BleRepository`)
- **Singleton**: Single source of truth for BLE operations
- **Responsibilities**:
  - Permission management (Android 12+ and iOS)
  - Bluetooth status monitoring
  - Device scanning with real-time updates
  - Connection management
  - Service discovery and characteristic operations
- **Streams**: Provides reactive streams for scan results and connection state
- **Error Handling**: Comprehensive error handling with meaningful error messages

### Key Benefits

1. **Predictable State**: BLoC pattern ensures predictable state transitions
2. **Testability**: Clear separation allows easy unit and widget testing
3. **Reactive UI**: Streams provide real-time UI updates
4. **Error Handling**: Robust error handling at all levels
5. **Platform Compatibility**: Handles Android 12+ permissions and iOS requirements
6. **Performance**: Efficient state management prevents unnecessary rebuilds

## Recent Fixes

### Build Configuration
- **Kotlin Version**: Updated from 1.8.22 to 2.1.0 to maintain Flutter compatibility
- **Flavor Configuration**: Properly configured Android product flavors using flutter_flavorizr
- **Build Tasks**: Fixed `assembleDevDebug` task availability through proper flavor setup

## Error Handling

The app implements robust error handling for:
- Bluetooth permission denials
- Connection failures
- Service discovery errors
- Bluetooth adapter state changes
- Unexpected disconnections

## Implementation Approach

### Development Strategy
This BLE scanner was implemented following modern Flutter best practices:

1. **Feature-First Architecture**: Each major feature (scanning, device details) is self-contained with its own BLoC, UI, and models
2. **Domain-Driven Design**: Core business logic separated from UI concerns through repository pattern
3. **Reactive Programming**: Leverages Dart streams for real-time BLE events and state updates
4. **Material 3 Design**: Modern, accessible UI following Google's latest design guidelines
5. **Platform Integration**: Proper handling of native Android and iOS BLE requirements

### Technical Decisions

#### State Management Choice: Flutter BLoC
- **Why BLoC?** Provides excellent separation of concerns, testability, and handles complex async operations well
- **Event-Driven**: Natural fit for BLE operations which are inherently event-driven (scan results, connection changes)
- **Stream-Based**: Aligns perfectly with flutter_blue_plus's stream-based API
- **Testing**: Easy to test business logic independently of UI components

#### Repository Pattern
- **Single Source of Truth**: BleRepository manages all flutter_blue_plus interactions
- **Abstraction**: UI components don't directly depend on flutter_blue_plus
- **Error Handling**: Centralized error handling and permission management
- **Caching**: Maintains discovered devices list and connection state

#### Permission Handling
- **Android 12+ Support**: Properly handles new BLUETOOTH_SCAN and BLUETOOTH_CONNECT permissions
- **iOS Compatibility**: Includes required usage descriptions and handles iOS-specific requirements
- **User Experience**: Clear messaging when permissions are denied with retry functionality

### Code Organization

```
Features follow a consistent structure:
feature/
├── bloc/           # State management
│   ├── feature_bloc.dart
│   ├── feature_event.dart  
│   └── feature_state.dart
└── view/           # UI components
    └── feature_screen.dart
```

This approach ensures:
- **Scalability**: Easy to add new features without affecting existing code
- **Maintainability**: Clear boundaries between different concerns
- **Testability**: Each layer can be tested independently
- **Reusability**: Core models and repository can be shared across features

## Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Add tests if applicable
5. Submit a pull request

## License

[Add license information]
