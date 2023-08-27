import 'dart:async';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:foodex_app/app/theme/constants.dart';
import 'package:foodex_app/app/utils/dimension.dart';
import 'package:foodex_app/screen/export_screen.dart';
import 'package:foodex_app/widgets/snack_bar.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:proximity_sensor/proximity_sensor.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DashboardButton extends StatefulWidget {
  const DashboardButton({super.key});

  @override
  State<DashboardButton> createState() => _DashboardButtonState();
}

class _DashboardButtonState extends State<DashboardButton> {
  var currentIndex = 0;
  List<Widget> lstBottomScreen = [
    const HomeScreen(),
    const OrderScreen(),
    const ProfileScreen(),
  ];

  bool _isNear = false;
  late StreamSubscription<dynamic> _streamSubscription;

  @override
  void initState() {
    listenSensor();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _streamSubscription.cancel();
  }

  Future<void> listenSensor() async {
    _streamSubscription = ProximitySensor.events.listen((int event) {
      setState(() {
        _isNear = (event > 0) ? true : false;
        print("IS NEAR -->$_isNear");
      });
      if (_isNear == true) {
        // show logout alert dialog
        showAlertDialog(context);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          color: AppColor.kPrimaryColor,
          animationDuration: const Duration(milliseconds: 300),
          onTap: (index) {
            setState(() {
              currentIndex = index;
            });
          },
          items: [
            Icon(LineAwesomeIcons.home,
                size: Dimensions.iconSize20 + 10, color: Colors.white),
            Icon(
              LineAwesomeIcons.history,
              size: Dimensions.iconSize20 + 10,
              color: Colors.white,
            ),
            Icon(
              LineAwesomeIcons.user,
              size: Dimensions.iconSize20 + 10,
              color: Colors.white,
            ),
          ]),
      body: lstBottomScreen[currentIndex],
    );
  }

  void showAlertDialog(BuildContext context) {
    AwesomeDialog(
      context: context,
      dialogType: DialogType.WARNING,
      animType: AnimType.TOPSLIDE,
      showCloseIcon: true,
      title: "Log Out",
      desc: "Are you sure you want to log out?",
      // autoHide: const Duration(seconds: 3),
      btnCancelOnPress: () {},
      btnOkOnPress: () async {
        SharedPreferences pref = await SharedPreferences.getInstance();
        showSnackbar(context, "Logout Successfully!", Colors.orange);
        pref.clear();
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (_) => const LoginScreen(),
          ),
        );
      },
    ).show();
  }
}
