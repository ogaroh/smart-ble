import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smart_ble/l10n/arb/app_localizations.dart';

/// App color scheme definitions
class AppColors {
  // Brand colors
  static const Color primaryBlue = Color(0xFF6139F7);
  static const Color primaryPink = Color(0xFFDA79E5);
  static const Color lightPink = Color.fromARGB(255, 249, 244, 249);

  // Light theme colors
  static const Color lightBackground = Color(0xFFFAFAFA);
  static const Color lightSurface = Color(0xFFFFFFFF);
  static const Color lightSurfaceVariant = Color(0xFFF5F5F7);
  static const Color lightOnBackground = Color(0xFF1A1A1A);
  static const Color lightOnSurface = Color(0xFF2D2D2D);
  static const Color lightOnSurfaceVariant = Color(0xFF6B6B6B);

  // Dark theme colors
  static const Color darkBackground = Color(0xFF0D0D0F);
  static const Color darkSurface = Color(0xFF1C1C1E);
  static const Color darkSurfaceVariant = Color(0xFF2C2C2E);
  static const Color darkOnBackground = Color(0xFFF2F2F7);
  static const Color darkOnSurface = Color(0xFFE5E5EA);
  static const Color darkOnSurfaceVariant = Color(0xFF8E8E93);

  // Status colors
  static const Color success = Color(0xFF30D158);
  static const Color warning = Color(0xFFFF9F0A);
  static const Color error = Color(0xFFFF453A);
  static const Color info = Color(0xFF007AFF);

  // BLE device type colors
  static const Color audioDevice = Color(0xFF9F44D3);
  static const Color smartwatch = Color(0xFF0077BE);
  static const Color otherDevice = Color(0xFFFF8C00);
  static const Color unknownDevice = Color(0xFF8E8E93);

  // Signal strength colors
  static const Color signalStrong = Color(0xFF30D158);
  static const Color signalGood = Color(0xFFFF9F0A);
  static const Color signalWeak = Color(0xFFFF453A);
}

/// Theme mode enumeration
enum AppThemeMode {
  system,
  light,
  dark,
}

extension AppThemeModeExtensions on AppThemeMode {
  String get displayName {
    switch (this) {
      case AppThemeMode.system:
        return 'System';
      case AppThemeMode.light:
        return 'Light';
      case AppThemeMode.dark:
        return 'Dark';
    }
  }

  String get description {
    switch (this) {
      case AppThemeMode.system:
        return 'Follow system theme';
      case AppThemeMode.light:
        return 'Always use light theme';
      case AppThemeMode.dark:
        return 'Always use dark theme';
    }
  }

  /// Get localized display name using app localizations
  String localizedDisplayName(AppLocalizations l10n) {
    switch (this) {
      case AppThemeMode.system:
        return l10n.system;
      case AppThemeMode.light:
        return l10n.light;
      case AppThemeMode.dark:
        return l10n.dark;
    }
  }

  /// Get localized description using app localizations
  String localizedDescription(AppLocalizations l10n) {
    switch (this) {
      case AppThemeMode.system:
        return l10n.followSystemTheme;
      case AppThemeMode.light:
        return l10n.alwaysUseLightTheme;
      case AppThemeMode.dark:
        return l10n.alwaysUseDarkTheme;
    }
  }

  ThemeMode get themeMode {
    switch (this) {
      case AppThemeMode.system:
        return ThemeMode.system;
      case AppThemeMode.light:
        return ThemeMode.light;
      case AppThemeMode.dark:
        return ThemeMode.dark;
    }
  }
}

/// App theme configuration
class AppTheme {
  static ThemeData get lightTheme {
    final colorScheme = ColorScheme.fromSeed(
      seedColor: AppColors.primaryBlue,
      brightness: Brightness.light,
      surface: AppColors.lightSurface,
      onSurface: AppColors.lightOnSurface,
      surfaceContainerHighest: AppColors.lightSurfaceVariant,
      onSurfaceVariant: AppColors.lightOnSurfaceVariant,
    );

    return ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme,
      textTheme: GoogleFonts.latoTextTheme().copyWith(
        // Headlines
        headlineLarge: GoogleFonts.lato(
          fontSize: 32,
          fontWeight: FontWeight.w700,
          letterSpacing: -0.25,
          color: colorScheme.onSurface,
        ),
        headlineMedium: GoogleFonts.lato(
          fontSize: 28,
          fontWeight: FontWeight.w600,
          letterSpacing: -0.15,
          color: colorScheme.onSurface,
        ),
        headlineSmall: GoogleFonts.lato(
          fontSize: 24,
          fontWeight: FontWeight.w600,
          letterSpacing: 0,
          color: colorScheme.onSurface,
        ),
        // Titles
        titleLarge: GoogleFonts.lato(
          fontSize: 22,
          fontWeight: FontWeight.w600,
          letterSpacing: 0,
          color: colorScheme.onSurface,
        ),
        titleMedium: GoogleFonts.lato(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.15,
          color: colorScheme.onSurface,
        ),
        titleSmall: GoogleFonts.lato(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          letterSpacing: 0.1,
          color: colorScheme.onSurfaceVariant,
        ),
        // Body text
        bodyLarge: GoogleFonts.lato(
          fontSize: 16,
          fontWeight: FontWeight.w400,
          letterSpacing: 0.5,
          color: colorScheme.onSurface,
        ),
        bodyMedium: GoogleFonts.lato(
          fontSize: 14,
          fontWeight: FontWeight.w400,
          letterSpacing: 0.25,
          color: colorScheme.onSurface,
        ),
        bodySmall: GoogleFonts.lato(
          fontSize: 12,
          fontWeight: FontWeight.w400,
          letterSpacing: 0.4,
          color: colorScheme.onSurfaceVariant,
        ),
        // Labels
        labelLarge: GoogleFonts.lato(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          letterSpacing: 0.1,
          color: colorScheme.onSurface,
        ),
        labelMedium: GoogleFonts.lato(
          fontSize: 12,
          fontWeight: FontWeight.w500,
          letterSpacing: 0.5,
          color: colorScheme.onSurface,
        ),
        labelSmall: GoogleFonts.lato(
          fontSize: 11,
          fontWeight: FontWeight.w500,
          letterSpacing: 0.5,
          color: colorScheme.onSurfaceVariant,
        ),
      ),
      appBarTheme: AppBarTheme(
        elevation: 0,
        centerTitle: true,
        backgroundColor: colorScheme.surface,
        foregroundColor: colorScheme.onSurface,
        titleTextStyle: GoogleFonts.lato(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: colorScheme.onSurface,
        ),
        scrolledUnderElevation: 0,
      ),
      cardTheme: CardThemeData(
        elevation: 1.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        color: const Color.fromARGB(255, 253, 240, 254),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          elevation: 2,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          textStyle: GoogleFonts.lato(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          textStyle: GoogleFonts.lato(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      chipTheme: ChipThemeData(
        backgroundColor: AppColors.lightOnSurfaceVariant,
        selectedColor: AppColors.primaryBlue,
        elevation: 0,
        labelStyle: GoogleFonts.lato(
          fontSize: 12,
          fontWeight: FontWeight.w500,
          color: AppColors.lightSurface,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        checkmarkColor: colorScheme.surface,
        shadowColor: Colors.transparent,
      ),
      listTileTheme: ListTileThemeData(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        dense: true,
        visualDensity: VisualDensity.compact,
        isThreeLine: false,
      ),
    );
  }

  static ThemeData get darkTheme {
    final colorScheme = ColorScheme.fromSeed(
      seedColor: AppColors.primaryBlue,
      brightness: Brightness.dark,
      surface: AppColors.darkSurface,
      onSurface: AppColors.darkOnSurface,
      surfaceContainerHighest: AppColors.darkSurfaceVariant,
      onSurfaceVariant: AppColors.darkOnSurfaceVariant,
    );

    return ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme,
      textTheme: GoogleFonts.latoTextTheme(ThemeData.dark().textTheme).copyWith(
        // Headlines
        headlineLarge: GoogleFonts.lato(
          fontSize: 32,
          fontWeight: FontWeight.w700,
          letterSpacing: -0.25,
          color: colorScheme.onSurface,
        ),
        headlineMedium: GoogleFonts.lato(
          fontSize: 28,
          fontWeight: FontWeight.w600,
          letterSpacing: -0.15,
          color: colorScheme.onSurface,
        ),
        headlineSmall: GoogleFonts.lato(
          fontSize: 24,
          fontWeight: FontWeight.w600,
          letterSpacing: 0,
          color: colorScheme.onSurface,
        ),
        // Titles
        titleLarge: GoogleFonts.lato(
          fontSize: 22,
          fontWeight: FontWeight.w600,
          letterSpacing: 0,
          color: colorScheme.onSurface,
        ),
        titleMedium: GoogleFonts.lato(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.15,
          color: colorScheme.onSurface,
        ),
        titleSmall: GoogleFonts.lato(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          letterSpacing: 0.1,
          color: colorScheme.onSurfaceVariant,
        ),
        // Body text
        bodyLarge: GoogleFonts.lato(
          fontSize: 16,
          fontWeight: FontWeight.w400,
          letterSpacing: 0.5,
          color: colorScheme.onSurface,
        ),
        bodyMedium: GoogleFonts.lato(
          fontSize: 14,
          fontWeight: FontWeight.w400,
          letterSpacing: 0.25,
          color: colorScheme.onSurface,
        ),
        bodySmall: GoogleFonts.lato(
          fontSize: 12,
          fontWeight: FontWeight.w400,
          letterSpacing: 0.4,
          color: colorScheme.onSurfaceVariant,
        ),
        // Labels
        labelLarge: GoogleFonts.lato(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          letterSpacing: 0.1,
          color: colorScheme.onSurface,
        ),
        labelMedium: GoogleFonts.lato(
          fontSize: 12,
          fontWeight: FontWeight.w500,
          letterSpacing: 0.5,
          color: colorScheme.onSurface,
        ),
        labelSmall: GoogleFonts.lato(
          fontSize: 11,
          fontWeight: FontWeight.w500,
          letterSpacing: 0.5,
          color: colorScheme.onSurfaceVariant,
        ),
      ),
      appBarTheme: AppBarTheme(
        elevation: 0,
        centerTitle: true,
        backgroundColor: colorScheme.surface,
        foregroundColor: colorScheme.onSurface,
        titleTextStyle: GoogleFonts.lato(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: colorScheme.onSurface,
        ),
        scrolledUnderElevation: 0,
      ),
      cardTheme: CardThemeData(
        elevation: 8,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        color: colorScheme.surface,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          elevation: 4,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          textStyle: GoogleFonts.lato(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          textStyle: GoogleFonts.lato(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      chipTheme: ChipThemeData(
        backgroundColor: colorScheme.surfaceContainerHighest,
        selectedColor: AppColors.primaryBlue,
        labelStyle: GoogleFonts.lato(
          fontSize: 12,
          fontWeight: FontWeight.w500,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      listTileTheme: ListTileThemeData(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }
}

/// Extension to get device type colors from the theme
extension DeviceTypeColors on ColorScheme {
  Color getDeviceTypeColor(String deviceType) {
    switch (deviceType.toLowerCase()) {
      case 'audio':
      case 'audiodevice':
        return AppColors.audioDevice;
      case 'smartwatch':
        return AppColors.smartwatch;
      case 'other':
        return AppColors.otherDevice;
      default:
        return AppColors.unknownDevice;
    }
  }

  Color getSignalStrengthColor(int rssi) {
    if (rssi >= -50) return AppColors.signalStrong;
    if (rssi >= -70) return AppColors.signalGood;
    return AppColors.signalWeak;
  }
}
