import 'package:flutter/material.dart';

class ShowToast {
  static void showSuccessToast(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(message),
      duration: const Duration(seconds: 5),
      backgroundColor: Colors.green,
      behavior: SnackBarBehavior.floating,
      action: SnackBarAction(
          label: 'OK', onPressed: () {}, textColor: Colors.white),
    ));
  }

  static void showWarningToast(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(message),
      duration: const Duration(seconds: 5),
      backgroundColor: Colors.yellowAccent,
      behavior: SnackBarBehavior.floating,
      action: SnackBarAction(
          label: 'OK', onPressed: () {}, textColor: Colors.white),
    ));
  }

  static void showAlertDialog(BuildContext context, String title,String message) {
    showDialog(

        context: context, builder: (context) =>
        AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: [
            TextButton(child: Text("OK"),
                onPressed: () {
                  Navigator.pop(context);
                }),
          ],
        ),barrierDismissible: false);
  }

  static void showErrorToast(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(message),
      duration: const Duration(seconds: 5),
      backgroundColor: Colors.red,
      behavior: SnackBarBehavior.floating,
      action: SnackBarAction(
          label: 'OK', onPressed: () {}, textColor: Colors.white),
    ));
  }
}
