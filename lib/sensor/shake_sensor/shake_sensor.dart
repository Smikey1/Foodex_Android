import 'dart:io';

import 'package:flutter/material.dart';
import 'package:foodex_app/app/router/routes.dart';
import 'package:foodex_app/app/theme/theme.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:shake/shake.dart';

class ShakeSensor extends StatefulWidget {
  const ShakeSensor({super.key});

  @override
  State<ShakeSensor> createState() => _ShakeSensorState();
}

class _ShakeSensorState extends State<ShakeSensor> {
  late ShakeDetector detector;

  @override
  void initState() {
    super.initState();

    detector = ShakeDetector.autoStart(onPhoneShake: () {
      // SystemChannels.platform.invokeMethod('SystemNavigator.pop');
      exit(0);
      // setState(() {});
    });
  }

  @override
  void dispose() {
    detector.stopListening();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => ThemeProvider(),
        builder: (context, _) {
          final themeProvider = Provider.of<ThemeProvider>(context);
          return GetMaterialApp(
            debugShowCheckedModeBanner: false,
            themeMode: themeProvider.themeMode,
            theme: MyThemes.lightTheme,
            darkTheme: MyThemes.darkTheme,
            // home: const BillingScreen(),
            initialRoute: RouterHelper.splashScreen,
            getPages: RouterHelper.routes,
          );
        });
  }
}
