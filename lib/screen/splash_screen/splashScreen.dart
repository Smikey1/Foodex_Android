import 'dart:async';

import 'package:flutter/material.dart';
import 'package:foodex_app/app/utils/dimension.dart';
import 'package:foodex_app/dashboard_button.dart';
import 'package:foodex_app/screen/export_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../app/constraints/api_url.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late Animation<double> animation;
  late AnimationController controller;
  String? token;

  void _getDataFromSharedPre() async {
    final pref = await SharedPreferences.getInstance();
    final receivedToken = pref.getString("token");
    if (receivedToken != null) {
      token = receivedToken;
      tokenConstant = receivedToken;
    } else {
      token = null;
    }
  }

  @override
  void initState() {
    _getDataFromSharedPre();
    super.initState();
    controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 2))
          ..forward();
    animation =
        CurvedAnimation(parent: controller, curve: Curves.fastOutSlowIn);

    Timer(const Duration(seconds: 3), () {
      if (token == null) {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const LoginScreen()));
      } else {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => const DashboardButtonScreen()));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // backgroundColor: Colors.white,
        body: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        ScaleTransition(
          scale: animation,
          child: Center(
            child: Image(
              image: const NetworkImage(
                "https://res.cloudinary.com/dymp3ozdm/image/upload/v1675933591/foodex/Logo/App_icon_kalcts.png",
              ),
              width: Dimensions.height20 * 8,
              height: Dimensions.height20 * 8,
            ),
          ),
        ),
        ScaleTransition(
          scale: animation,
          child: Center(
            child: Image(
              image: const NetworkImage(
                "https://res.cloudinary.com/dymp3ozdm/image/upload/v1675933585/foodex/Logo/Artboard_5_copy_5_bnqvdq.png",
              ),
              width: Dimensions.width100 * 2,
              height: Dimensions.height50 * 4,
            ),
          ),
        ),
      ],
    ));
  }
}
