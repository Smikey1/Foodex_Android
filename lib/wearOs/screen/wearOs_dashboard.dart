import 'package:flutter/material.dart';
import 'package:foodex_app/app/theme/constants.dart';
import 'package:foodex_app/wearOs/screen/wearOs_logout.dart';
import 'package:foodex_app/wearOs/screen/wearOs_profile.dart';

class WearOsDashboard extends StatefulWidget {
  const WearOsDashboard({
    Key? key,
  }) : super(key: key);
  static String routeName = "/WearOsDashboard";

  @override
  State<WearOsDashboard> createState() => _WearOsDashboardState();
}

class _WearOsDashboardState extends State<WearOsDashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(5.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const UserProfile(),
              // const WearOsCartScreen(),
              SizedBox(
                width: double.infinity,
                height: 40,
                child: TextButton(
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    backgroundColor: AppColor.kPrimaryColor,
                  ),
                  onPressed: () {},
                  child: const Text(
                    "My Cart",
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              SizedBox(
                width: double.infinity,
                height: 40,
                child: TextButton(
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    backgroundColor: AppColor.kPrimaryColor,
                  ),
                  onPressed: () {},
                  child: const Text(
                    "My Order",
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              const WearOsLogoutScreen(),
              const SizedBox(
                height: 5,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
