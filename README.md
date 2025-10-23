# SmartBLE

A modern Flutter application for scanning and connecting to Bluetooth Low Energy (BLE) smart devices. This app provides a clean, intuitive interface with comprehensive theming support for discovering nearby BLE devices, managing connections, and exploring device services.

## ✨ Features

### 🔍 BLE Scan Screen
- **Permission Management**: Automatically requests and handles Bluetooth and Location permissions (including Android 12+ BLUETOOTH_SCAN and BLUETOOTH_CONNECT permissions)
- **Bluetooth Status Detection**: Detects and prompts users to enable Bluetooth when disabled
- **Real-time Device Scanning**: Start/stop BLE scanning with real-time device discovery
- **Comprehensive Device Information**: Displays device name, MAC address/UUID, and signal strength (RSSI)
- **Modern Search Interface**: iOS-style Cupertino search field for enhanced UX
- **Smart Filtering**: 
  - Text-based filtering by device name with real-time results
  - Predefined filters for device types (Audio Devices, Smartwatches)
  - RSSI-based signal strength filtering
- **Intuitive Navigation**: Tap any device to view detailed information

### 📱 Device Detail Screen
- **Device Information**: Shows selected device's name, address, and current RSSI
- **Connection Management**: Connect/disconnect with real-time connection state updates
- **Service Discovery**: Automatic discovery of device services and characteristics upon connection
- **Service/Characteristic Explorer**: Expandable list showing all services with their characteristics and properties (Read, Write, Notify)

### ⚙️ Settings & Customization
- **Theme Management**: Light, Dark, and System theme modes with instant switching
- **BLE Configuration**: Customizable scan and connection timeouts
- **Scanning Preferences**: 
  - Auto-scan on startup toggle
  - Show/hide unknown devices
  - Adjustable RSSI threshold slider
- **Advanced Options**: Auto-connect to last device, reset to defaults
- **Persistent Storage**: All settings saved using SharedPreferences

### 🎨 Modern UI/UX
- **Material 3 Design**: Latest Material Design principles with custom theming
- **Google Fonts Integration**: Lato font family for consistent, professional typography
- **Custom Color Scheme**: Brand-aligned purple/pink color palette
- **Responsive Layout**: Optimized for various screen sizes
- **Smooth Animations**: Polished transitions and interactions

## 🛠 Technical Stack

- **Framework**: Flutter & Dart (stable version) with Material 3
- **State Management**: BLoC pattern for predictable state handling
- **BLE Integration**: flutter_blue_plus ^1.32.12 for robust BLE operations
- **Fonts**: google_fonts ^6.2.1 for enhanced typography
- **Storage**: shared_preferences ^2.3.2 for settings persistence
- **Permissions**: permission_handler ^11.3.1 for platform permissions
- **Architecture**: Clean Architecture with feature-based organization
- **Platform Support**: Android and iOS with proper native configurations

## 🚀 Getting Started

### Prerequisites
- Flutter SDK (stable version)
- Android Studio / Xcode for platform-specific development  
- Physical device with Bluetooth capabilities (BLE scanning requires hardware)

### Installation

1. **Clone the repository:**
```bash
git clone <repository-url>
cd smart_ble
```

2. **Install dependencies:**
```bash
flutter pub get
```

3. **Run the application:**

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

### 📖 Usage Guide

1. **First Launch**: Grant Bluetooth and Location permissions when prompted
2. **Scanning**: Tap the scan button to discover nearby BLE devices
3. **Filtering**: Use the search bar or filter buttons to find specific devices
4. **Device Connection**: Tap any discovered device to view details and connect
5. **Settings**: Access the settings via the gear icon to customize:
   - Theme preference (Light/Dark/System)
   - BLE timeouts and behavior
   - Scanning preferences
   - RSSI filtering thresholds

## 🏗 Architecture & Recent Updates

### Major Features Added (October 2025)

#### 🎨 Modern UI/UX Overhaul
- **CupertinoSearchTextField**: Replaced standard search with iOS-style search field
- **Google Fonts Integration**: Implemented Lato font family across the entire app
- **Comprehensive Theme System**: 
  - Material 3 design implementation
  - Custom brand colors (purple #6139F7, pink #DA79E5)
  - Complete light/dark theme support with system preference detection

#### ⚙️ Settings & Preferences System
- **Settings Screen**: Full-featured configuration panel with organized sections
- **Theme Control**: Light/Dark/System mode switching with instant preview
- **BLE Configuration**: Customizable scan (5-60s) and connection timeouts
- **Scanning Options**: Auto-scan toggle, unknown device visibility, RSSI filtering
- **Persistent Storage**: SharedPreferences integration for settings persistence

#### 🛠 Technical Improvements  
- **BLoC Architecture**: Implemented proper state management for settings
- **Clean Code**: Fixed all deprecation warnings, updated to latest Material 3 APIs
- **Feature Organization**: Modular structure with clear separation of concerns

### Platform Configuration

#### Android
- Configured AndroidManifest.xml with required Bluetooth permissions
- Supports Android 12+ permission model (BLUETOOTH_SCAN, BLUETOOTH_CONNECT)
- Location permissions for BLE scanning

#### iOS  
- Info.plist configured with Bluetooth usage descriptions
- Background modes for maintaining BLE connections

## 📁 App Flavors

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

## 🏛 State Management & Architecture

The application uses **Flutter BLoC (Business Logic Component)** pattern for predictable state management, ensuring clean separation between UI and business logic.

### Architecture Overview

The app follows a clean, feature-based architecture with clear separation of concerns:

```
lib/
├── core/
│   ├── models/           # Domain models (BLE devices, services, characteristics)
│   ├── theme/           # App-wide theming (AppTheme, AppColors)
│   └── repositories/     # Data access layer (BLE repository)
├── features/
│   ├── ble_scan/        # BLE scanning feature
│   │   ├── bloc/        # State management (BleScanBloc)
│   │   └── view/        # UI components (BleScanScreen)
│   ├── device_detail/   # Device connection feature  
│   │   ├── bloc/        # State management (DeviceDetailBloc)
│   │   └── view/        # UI components (DeviceDetailScreen)
│   └── settings/        # Settings & preferences feature
│       ├── bloc/        # State management (SettingsBloc)
│       └── view/        # UI components (SettingsScreen)
└── app.dart            # App configuration with theme management
```

### BLoC Implementation

#### 1. **BLE Scan BLoC** (`BleScanBloc`)
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

#### 2. **Device Detail BLoC** (`DeviceDetailBloc`) 
- **Purpose**: Manages device connection, service discovery, and characteristic operations

#### 3. **Settings BLoC** (`SettingsBloc`) ⭐ *New*
- **Purpose**: Manages app settings, theme preferences, and BLE configuration
- **Key Features**:
  - SharedPreferences integration for persistence
  - Theme mode management (Light/Dark/System)
  - BLE timeout configurations
  - Scanning preferences and RSSI filtering
- **Key Events**:
  - `LoadSettingsEvent` - Loads saved settings
  - `UpdateThemeModeEvent` - Changes app theme
  - `UpdateScanTimeoutEvent` - Configures scan duration
  - `ResetSettingsEvent` - Restores defaults

## 📦 Dependencies

### Core Dependencies
```yaml
dependencies:
  flutter_blue_plus: ^1.32.12     # BLE operations
  flutter_bloc: ^8.1.6            # State management
  google_fonts: ^6.2.1            # Typography (Lato font)
  shared_preferences: ^2.3.2      # Settings persistence
  permission_handler: ^11.3.1     # Platform permissions
  equatable: ^2.0.5               # Value equality
  
dev_dependencies:
  flutter_lints: ^5.0.0           # Dart/Flutter linting
  flutter_native_splash: ^2.4.4   # Splash screen generation
  flavorizr: ^2.2.3               # App flavors configuration
```

### Recent Additions (October 2025)
- **google_fonts**: Added for Lato font family integration
- **shared_preferences**: Added for settings persistence
- **Enhanced theming**: Updated to latest Material 3 APIs

## 🔧 Key Features & Implementation

### Repository Pattern
- **BLE Repository**: Centralized BLE operations management
- **Permission Handling**: Android 12+ and iOS permission management  
- **Real-time Streams**: Reactive BLE device discovery
- **Connection Management**: Robust connection state handling

### Error Handling & Reliability
- Bluetooth permission denials with user guidance
- Connection failure recovery and retry logic
- Service discovery error handling
- Bluetooth adapter state monitoring
- Graceful handling of unexpected disconnections

## 📈 Recent Updates & Improvements

### October 2025 Major Release
- ✅ **UI Modernization**: CupertinoSearchTextField, Google Fonts (Lato)
- ✅ **Comprehensive Theming**: Material 3 with Light/Dark/System modes
- ✅ **Settings System**: Complete preferences management with BLoC
- ✅ **Code Quality**: Fixed all deprecation warnings, updated APIs
- ✅ **Architecture Enhancement**: Improved separation of concerns

### Build & Performance Fixes
- **Kotlin Compatibility**: Updated from 1.8.22 to 2.1.0+
- **Flavor Configuration**: Properly configured dev/stag/prod builds
- **Material 3 Migration**: Updated deprecated color properties
- **Performance Optimization**: Efficient state management and rebuilds

## 🧪 Development & Testing

### Code Quality
- **Flutter Lints**: Strict linting rules for consistent code quality
- **No Issues Found**: All deprecation warnings resolved ✅
- **Material 3 Compliance**: Updated to latest design APIs
- **BLoC Testing**: Testable architecture for business logic

### Build Verification
```bash
# Verify code quality
flutter analyze
# Result: No issues found! ✅

# Build verification
flutter build apk --debug
# Result: ✓ Built successfully ✅
```

## 🚀 Future Enhancements

### Planned Features
- **Characteristic Operations**: Read/Write/Notify functionality
- **Connection History**: Remember previously connected devices
- **Export Functionality**: Save scan results and device information
- **Advanced Filtering**: More sophisticated device filtering options
- **Testing Suite**: Comprehensive unit and widget tests

## 📱 Screenshots

*[Screenshots would be added here showing the modern UI with different themes]*

## 🤝 Contributing

Contributions are welcome! Please ensure:
- Follow the established BLoC pattern
- Maintain the feature-based architecture
- Update tests for any new functionality
- Follow Flutter/Dart style guidelines

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

---

**SmartBLE** - A modern, comprehensive Flutter BLE scanner with advanced theming and settings management.
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
