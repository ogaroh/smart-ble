import 'package:flutter/material.dart';
import 'package:smart_ble/flavors.dart' show F;
import 'package:smart_ble/l10n/l10n.dart';
import 'features/ble_scan/view/ble_scan_screen.dart';

// Define color variables
final Color pinkColor = const Color(0xFFDA79E5);
final Color purpleColor = const Color(0xFF6139F7);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SmartBLE',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: purpleColor),
        useMaterial3: true,
      ),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: const BleScanScreen(),
      builder: (context, child) {
        return Banner(
          message: F.appFlavor?.name ?? "SmartBLE",
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
  }
}
