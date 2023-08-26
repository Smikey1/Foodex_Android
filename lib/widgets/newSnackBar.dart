import 'package:flutter/material.dart';
import 'package:flutter_flushbar/flutter_flushbar.dart';

class SnackbarWidget {
  showBlurredSnackBar(BuildContext context, String message, Color color) {
    Flushbar(
      icon: const Icon(Icons.error_sharp, size: 30, color: Colors.white),
      shouldIconPulse: true,
      message: message,
      // mainButton: TextButton(
      //   child: const Text(
      //     'View Product',
      //     style: TextStyle(color: Colors.white, fontSize: 16),
      //   ),
      //   onPressed: () {},
      // ),
      // padding: const EdgeInsets.only(left: 15, bottom: 15),
      flushbarPosition: FlushbarPosition.TOP,
      margin: const EdgeInsets.fromLTRB(40, 0, 50, 40),
      duration: const Duration(seconds: 3),
      borderRadius: BorderRadius.circular(10),
      barBlur: 20,
      backgroundColor: color.withOpacity(0.7),
    ).show(context);
  }

  showTopSnackBar(BuildContext context, String message, Color color) {
    Flushbar(
      icon: const Padding(
        padding: EdgeInsets.only(left: 40, bottom: 15),
        child: Icon(Icons.error_sharp, size: 30, color: Colors.white),
      ),
      shouldIconPulse: true,
      message: message,
      // mainButton: TextButton(
      //   child: const Text(
      //     'View Product',
      //     style: TextStyle(color: Colors.white, fontSize: 16),
      //   ),
      //   onPressed: () {},
      // ),
      padding: const EdgeInsets.only(left: 45, bottom: 15),
      flushbarPosition: FlushbarPosition.TOP,
      margin: const EdgeInsets.fromLTRB(0, 10, 0, 0),
      duration: const Duration(seconds: 3),
      borderRadius: BorderRadius.circular(10),
      barBlur: 20,
      backgroundColor: color.withOpacity(0.7),
    ).show(context);
  }

  // showDismissSnackBar(BuildContext context, String message, Color color) {
  //   Flushbar(
  //     icon: const Icon(Icons.error, size: 32, color: Colors.white),
  //     shouldIconPulse: false,
  //     message: message,
  //     flushbarPosition: FlushbarPosition.TOP,
  //     margin: const EdgeInsets.fromLTRB(8, 8, 8, 0),
  //     borderRadius: BorderRadius.circular(16),
  //     backgroundColor: color,
  //     barBlur: 10,
  //     padding: const EdgeInsets.all(24),
  //     animationDuration: const Duration(microseconds: 3),
  //     dismissDirection: FlushbarDismissDirection.HORIZONTAL,
  //   ).show(context);
  // }
}
