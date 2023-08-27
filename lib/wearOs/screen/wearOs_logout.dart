import 'package:flutter/material.dart';
import 'package:foodex_app/wearOs/screen/wearOs_login.dart';
import 'package:foodex_app/wearOs/widget/wearOs_snackbar.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WearOsLogoutScreen extends StatefulWidget {
  const WearOsLogoutScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<WearOsLogoutScreen> createState() => WearOsLogoutScreenState();
}

class WearOsLogoutScreenState extends State<WearOsLogoutScreen> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 40,
      child: TextButton(
        style: TextButton.styleFrom(
          foregroundColor: Colors.white,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          backgroundColor: Colors.red,
        ),
        onPressed: () async {
          SharedPreferences pref = await SharedPreferences.getInstance();
          pref.clear();
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const WearOsLogin(),
            ),
          );
          wearOsShowSnackbar(context, "Logout Successfully!", Colors.redAccent);
        },
        child: const Text(
          "Log Out",
          style: TextStyle(
            fontSize: 15,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
