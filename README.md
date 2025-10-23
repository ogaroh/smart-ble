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

[To be documented based on implementation choice - Provider, Riverpod, BLoC, etc.]

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

## Architecture

- Clean separation between UI and BLE logic
- Reactive state management for real-time updates
- Proper handling of platform-specific requirements
- Graceful error states and loading indicators

## Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Add tests if applicable
5. Submit a pull request

## License

[Add license information]
