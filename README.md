# SmartBLE - IoT Flutter Application (BLE)

## Mobile Application Overview

A comprehensive Flutter application for Bluetooth Low Energy (BLE) device scanning, connection, and interaction with Material 3 design principles.

---

## Instructions on How to Run the Application

### Prerequisites

- Flutter SDK (3.0.0 or later)
- Dart SDK (2.19.0 or later)
- Android Studio / Xcode for device deployment
- Physical device with Bluetooth capabilities (BLE scanning requires hardware)

### Setup Instructions

1. **Clone the Repository**

   ```bash
   git clone https://github.com/ogaroh/smart-ble.git
   cd smart_ble
   ```

2. **Install Dependencies**

   ```bash
   flutter pub get
   ```

3. **Configure Flavors**
   The app supports multiple build flavors:

   - `dev` - Development environment
   - `stag` - Staging environment
   - `prod` - Production environment

4. **Run the Application**

   **Development Mode:**

   ```bash
   flutter run --flavor dev --target lib/main_dev.dart
   ```

   **Production Mode:**

   ```bash
   flutter run --flavor prod --target lib/main_prod.dart
   ```

   **Build APK:**

   ```bash
   flutter build apk --flavor prod --release --target lib/main_prod.dart
   ```

   **Build Appbundle (Play Store Release):**

   ```bash
   flutter build appbundle --flavor prod --release --target lib/main_prod.dart
   ```

### Platform-Specific Setup

#### Android

- Minimum SDK: 21 (Android 5.0)
- Target SDK: 34
- Permissions automatically handled: `BLUETOOTH`, `BLUETOOTH_ADMIN`, `ACCESS_FINE_LOCATION`

#### iOS

- iOS 12.0 or later
- Bluetooth permissions handled via Info.plist

### Important Notes

- **Physical Device Required**: BLE functionality requires a physical device with Bluetooth capabilities
- **Location Permission**: Android requires location permission for BLE scanning
- **Bluetooth Must Be Enabled**: Ensure Bluetooth is enabled on the device before running

---

## State Management Choice Explanation

### BLoC (Business Logic Component) Pattern

**Why BLoC was chosen:**

1. **Separation of Concerns**: Clear separation between UI, business logic, and data layers
2. **Testability**: Easy to unit test business logic independent of UI
3. **Scalability**: Excellent for complex applications with multiple screens and states
4. **Reactive Programming**: Stream-based use-case perfect for BLE connection state management
5. **Ecosystem**: Excellent support from the community in general

### Architecture Implementation

```
├── Core Layer
│   ├── Models (BLE data structures)
│   ├── Theme (Material 3 styling)
│   └── Repository (BLE operations)
├── Feature Layer
│   ├── Device Scanner (BlocProvider + BlocBuilder)
│   └── Device Details (BlocProvider + BlocConsumer)
│   └── Settings (BlocProvider + BlocConsumer)
└── Presentation Layer
    ├── Screens (StatelessWidgets)
    └── Widgets (Reusable components)
```

**Key BLoC Components:**

- **DeviceScannerBloc**: Manages BLE scanning, device discovery, and filtering
- **DeviceDetailBloc**: Handles device connection, service discovery, and characteristic operations
- **SettingsBloc**: Theme changes, Bluetooth timeout settings, Scanning preferences & other advanced settings (granular) that might be implemented later
- **Events**: User actions (scan, connect, read characteristics)
- **States**: UI states (loading, loaded, error, connecting, etc.)

**State Flow Example:**

```
User clicks "Connect" → ConnectToDeviceEvent →
DeviceDetailConnecting (immediate UI feedback) →
BLE Connection → DeviceDetailConnected →
Auto Service Discovery → DeviceDetailDiscoveringServices →
Services Found → DeviceDetailConnected (with services)
```

---

## Challenges Faced & Assumptions Made

### Challenges Overcome

#### 1. **Connection State Management**

- **Challenge**: BLE connection states can change rapidly and unpredictably
- **Solution**: Implemented immediate UI feedback with state-specific classes (DeviceDetailConnecting, DeviceDetailConnected, etc.)

#### 2. **Device Scanning Reliability**

- **Challenge**: BLE scanning can be inconsistent, especially on different devices
- **Solution**: Added robust error handling, scan timeouts, and user feedback for scanning issues

#### 3. **Manufacturer Information Reading**

- **Challenge**: Not all devices expose manufacturer information via standard characteristics
- **Solution**: Graceful fallback with proper error states (unavailable, loading, error, available)

#### 4. **Material 3 Design Implementation**

- **Challenge**: Ensuring consistent theming across complex UI components
- **Solution**: Custom theme system with AppColors class and comprehensive styling

#### 5. **Multi-Flavor Architecture**

- **Challenge**: Supporting dev/staging/production environments
- **Solution**: Implemented flavorizr configuration with separate main entry points

### Assumptions Made

#### 1. **Device Capabilities**

- Assumed target devices have Bluetooth 4.0+ BLE support
- Assumed users will grant necessary permissions when prompted
- Assumed physical device testing (emulator limitations acknowledged)

#### 2. **User Experience**

- Users prefer immediate visual feedback over waiting for actual BLE responses
- Device connection attempts should have reasonable timeouts
- Error messages should be user-friendly rather than technical

#### 3. **BLE Standards**

- Standard BLE service UUIDs (Device Information: 180A, Battery: 180F)
- Common characteristic UUIDs for manufacturer name (2A29), model number (2A24)
- UTF-8 encoding for readable characteristic values

#### 4. **Performance**

- Device lists under 50 items perform adequately without any lag
- Service discovery is fast enough for auto-triggering on connection
- Memory usage acceptable for typical BLE device discovery & communication sessions

---

## 🎯 Bonus Challenges Attempted

### ✅ **Challenge #1: Enhanced UI/UX**

- **Implementation**: Full Material 3 design system with dynamic theming & custom settings
- **Features**:
  - Added an extra Settings module
  - Custom color schemes and typography
  - Smooth animations and transitions
  - Consistent iconography and spacing
  - Responsive layout design

### ✅ **Challenge #2: Manufacturer Information Reading**

- **Implementation**: Automatic manufacturer name detection via the Device Information Service (0x180A)
- **Features**:
  - Auto-discovery of manufacturer name characteristic (0x2A29)
  - Loading states with progress indicators
  - Error handling for unsupported devices
  - Graceful fallback for unavailable information

### 📋 **Additional Enhancements Implemented**

#### **Multi-Environment Support**

- Dev, Staging, and Production flavors
- Environment-specific configurations
- Separate app icons and names per flavor

#### **Comprehensive Error Handling**

- Network-aware error messages
- User-friendly error states
- Recovery suggestions and actions

#### **Advanced BLE Features**

- Service and characteristic discovery
- Real-time connection state monitoring
- RSSI signal strength display
- Characteristic property analysis (Read, Write, Notify, etc.)

#### **Code Quality**

- Comprehensive code documentation
- Error boundary implementations
- Proper resource cleanup (connection disposal)
- Memory leak prevention etc.

---

## 📁 Download Links

### 🔗 **Functional APK**

[Download Smart BLE APK](https://github.com/ogaroh/smart-ble/releases/download/v1.0.0/smart-ble-app-prod-release.apk)
_Production build with release optimizations_

### 🎥 **Demo Video**

[Watch Application Demo](https://drive.google.com/file/d/1Y5KLVzOvpAhhDievRVR9xLYuCB8zUcct/view?usp=sharing)
_Complete walkthrough of BLE scanning, connection, and service discovery_

---

## 📊 Technical Specifications

- **Flutter Version**: 3.24.5
- **Dart Version**: 3.5.4
- **Key Dependencies**:

  - `flutter_blue_plus: ^1.36.8` (BLE functionality)
  - `flutter_bloc: ^8.1.6` (State management)
  - `permission_handler: ^11.4.0` (Runtime permissions)
  - `equatable: ^2.0.5` (Value equality)

- **Supported Platforms**: Android (API 21+), iOS (12.0+)
- **Architecture**: Clean Architecture with BLoC pattern
- **Design System**: Material 3 with custom theming

---

## 🎉 Conclusion

This Smart BLE application demonstrates a production-ready Flutter implementation with modern architecture patterns, comprehensive error handling, and user-centric design. The BLoC pattern provides excellent separation of concerns and maintainability, while the Material 3 design ensures a polished user experience across different devices and screen sizes.

The implementation successfully addresses all core requirements while adding significant value through bonus features and robust engineering practices.
