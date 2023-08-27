import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:foodex_app/app/theme/constants.dart';
import 'package:foodex_app/helper/objectbox.dart';
import 'package:foodex_app/sensor/shake_sensor/shake_sensor.dart';
import 'package:foodex_app/state/objectbox_state.dart';
import 'package:khalti_flutter/khalti_flutter.dart';
import 'dart:async';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // create an object for objectBoxInstance
  ObjectBoxState.objectBoxInstance = await ObjectBoxInstance.init();

  AwesomeNotifications().initialize(
    null,
    [
      NotificationChannel(
        channelKey:
            'basic_channel', //shown when enabling permission in the setting
        channelName: 'basic_channel', //name shown in setting
        defaultColor:
            AppColor.kPrimaryColor, //default color of the notification
        importance:
            NotificationImportance.High, //display notification on screen
        channelShowBadge:
            true, // to show number of notification badge on app icon
        // locked: false,
        channelDescription: 'test',
      ),
    ],
  );

  // Disable landscape mode
  SystemChrome.setPreferredOrientations(
          [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown])
      .then((value) => runApp(const MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return KhaltiScope(
        enabledDebugging: true,
        publicKey: "test_public_key_bcbec49746364b548f9cf8ab6f0e097d",
        builder: (context, navigatorKey) {
          return MaterialApp(
              navigatorKey: navigatorKey,
              supportedLocales: const [
                Locale('en', 'US'),
                Locale('ne', 'NP'),
              ],
              localizationsDelegates: const [
                KhaltiLocalizations.delegate,
              ],
              debugShowCheckedModeBanner: false,
              home: const ShakeSensor());
        });
  }
}
