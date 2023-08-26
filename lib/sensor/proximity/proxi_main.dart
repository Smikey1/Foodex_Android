// import 'package:flutter/material.dart';
// import 'package:foodex_app/sensor/proximity_sensor.dart';
// import 'package:provider/provider.dart';

// class ThemeNotifier with ChangeNotifier {
//   final darkTheme = ThemeData(
//     primaryColor: Colors.black,
//     brightness: Brightness.dark,
//     dividerColor: Colors.black12,
//     colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.grey)
//         .copyWith(secondary: Colors.white)
//         .copyWith(background: const Color(0xFF212121)),
//   );

//   final lightTheme = ThemeData(
//     primaryColor: Colors.white,
//     brightness: Brightness.light,
//     dividerColor: Colors.white54,
//     colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.grey)
//         .copyWith(secondary: Colors.black)
//         .copyWith(background: const Color(0xFFE5E5E5)),
//   );

//   late ThemeData _themeData;
//   ThemeData getTheme() => _themeData;

//   ThemeNotifier() {
//     StorageManager.readData('themeMode').then((value) {
//       print('value read from storage: $value');
//       var themeMode = value ?? 'light';
//       if (themeMode == 'light') {
//         _themeData = lightTheme;
//       } else {
//         print('setting dark theme');
//         _themeData = darkTheme;
//       }
//       notifyListeners();
//     });
//   }

//   void setDarkMode() async {
//     _themeData = darkTheme;
//     StorageManager.saveData('themeMode', 'dark');
//     notifyListeners();
//   }

//   void setLightMode() async {
//     _themeData = lightTheme;
//     StorageManager.saveData('themeMode', 'light');
//     notifyListeners();
//   }
// }

// void main() {
//   return runApp(ChangeNotifierProvider<ThemeNotifier>(
//     create: (_) => ThemeNotifier(),
//     child: const MyApp(),
//   ));
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Consumer<ThemeNotifier>(
//       builder: (context, theme, _) => MaterialApp(
//         theme: theme.getTheme(),
//         home: Scaffold(
//           appBar: AppBar(
//             title: const Text('Hybrid Theme'),
//           ),
//           body: Row(
//             children: [
//               Container(
//                 child: TextButton(
//                   onPressed: () => {
//                     print('Set Light Theme'),
//                     theme.setLightMode(),
//                   },
//                   child: const Text('Set Light Theme'),
//                 ),
//               ),
//               Container(
//                 child: TextButton(
//                   onPressed: () => {
//                     print('Set Dark theme'),
//                     theme.setDarkMode(),
//                   },
//                   child: const Text('Set Dark theme'),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

