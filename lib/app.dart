import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_ble/flavors.dart' show F;
import 'package:smart_ble/l10n/l10n.dart';
import 'core/theme/app_theme.dart';
import 'features/ble_scan/view/ble_scan_screen.dart';
import 'features/settings/settings.dart';

// Define color variables
final Color pinkColor = const Color(0xFFDA79E5);
final Color purpleColor = const Color(0xFF6139F7);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: globalSettingsBloc),
      ],
      child: BlocBuilder<SettingsBloc, SettingsState>(
        builder: (context, state) {
          final themeMode = state is SettingsLoaded
              ? state.themeMode.themeMode
              : ThemeMode.system;

          return MaterialApp(
            title: 'SmartBLE',
            debugShowCheckedModeBanner: false,
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            themeMode: themeMode,
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            home: const BleScanScreen(),
            builder: (context, child) {
              return Banner(
                message: F.appFlavor.name,
                location: BannerLocation.topEnd,
                color: pinkColor,
                shadow: const BoxShadow(
                  color: Colors.black12,
                  blurRadius: 10,
                  offset: Offset(0, 5),
                ),
                child: child!,
              );
            },
          );
        },
      ),
    );
  }
}
