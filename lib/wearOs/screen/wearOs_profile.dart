import 'package:flutter/material.dart';
import 'package:foodex_app/wearOs/screen/wearOs_login.dart';
import 'package:foodex_app/wearOs/widget/wearOs_snackbar.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WearOsProfileScreen extends StatefulWidget {
  const WearOsProfileScreen({super.key});

  @override
  State<WearOsProfileScreen> createState() => _WearOsProfileScreenState();
}

class _WearOsProfileScreenState extends State<WearOsProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () async {
                  SharedPreferences pref =
                      await SharedPreferences.getInstance();
                  wearOsShowSnackbar(
                      context, "Logout Successfully!", Colors.orange);
                  pref.clear();
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (_) => const WearOsLogin(),
                    ),
                  );
                },
                child: const Text("Log Out"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
