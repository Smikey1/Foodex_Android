import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:foodex_app/app/theme/constants.dart';

class MyThemes {
  static final darkTheme = ThemeData(
    scaffoldBackgroundColor: AppColor.kContentColorDarkTheme,
    cardColor: AppColor.kContentColorDarkTheme.withOpacity(0.8),

    colorScheme: const ColorScheme.dark().copyWith(
        primary: AppColor.kPrimaryColor,
        secondary: AppColor.kSecondaryColor,
        background: AppColor.bgFillColor,
        onPrimary: Colors.white,
        onSecondaryContainer: AppColor.kSecondaryColor),
    // textTheme: Colors.white
  );

  static final lightTheme = ThemeData(
      scaffoldBackgroundColor: AppColor.kContentColorLightTheme,
      cardColor: AppColor.kContentColorLightTheme.withOpacity(0.8),
      colorScheme: const ColorScheme.light().copyWith(
          primary: AppColor.kPrimaryColor,
          secondary: AppColor.kSecondaryColor,
          background: AppColor.bgFillColor,
          onPrimary: Colors.black,
          onSecondaryContainer: AppColor.kSecondaryColor));
}

class ThemeProvider extends ChangeNotifier {
  ThemeMode themeMode = ThemeMode.system;

  // bool get isDarkMode => themeMode == ThemeMode.dark;

  bool get isDarkMode {
    if (themeMode == ThemeMode.system) {
      final brightness = SchedulerBinding.instance.window.platformBrightness;
      return brightness == Brightness.dark;
    } else {
      return themeMode == ThemeMode.dark;
    }
  }

  void toggleTheme(bool isOn) {
    themeMode = isOn ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }
}
