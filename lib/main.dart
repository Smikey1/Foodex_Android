import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:foodex_app/app/theme/constants.dart';
import 'package:foodex_app/helper/objectbox.dart';
import 'package:foodex_app/sensor/shake_sensor/shake_sensor.dart';
import 'package:foodex_app/state/objectbox_state.dart';

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

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const ShakeSensor();
  }
}
