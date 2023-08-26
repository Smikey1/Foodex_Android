import 'package:flutter/material.dart';
import 'package:foodex_app/app/utils/dimension.dart';
import 'package:foodex_app/screen/map/screen/location_screen.dart';

import '../export_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // @override
  // void initState() {
  //   MyNotification.showNotification(
  //       notificationTitle: "Login Success",
  //       notificationMessage: "Login Successfully");
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // const Text("Hello"),

            //====================== Top Bar Start ============================================
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                // crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // ------------------ Location -----------------------------------
                  SizedBox(
                    width: Dimensions.height45,
                    height: Dimensions.height45,
                    child: IconButton(
                      icon:
                          Icon(Icons.location_on, size: Dimensions.iconSize24),
                      color: Colors.orange,
                      onPressed: () {
                        print("This is called");
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => const LocationScreen()));
                      },
                    ),
                  ),

                  SizedBox(
                    width: Dimensions.height20 * 5,
                  ),

                  SizedBox(
                    width: Dimensions.height45,
                    height: Dimensions.height45,
                    child: IconButton(
                      icon: Icon(Icons.search, size: Dimensions.iconSize24),
                      color: Colors.orange,
                      onPressed: () {},
                    ),
                  ),
                  // ---------------------- Cart -----------------------------------
                  SizedBox(
                    width: Dimensions.height45,
                    height: Dimensions.height45,
                    child: IconButton(
                      icon: Icon(Icons.shopping_cart,
                          size: Dimensions.iconSize24),
                      color: Colors.orange,
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => const CartScreen()));
                      },
                    ),
                  ),
                ],
              ),
            ),
            // const Divider(),

            // ============================ Top Bar End ============================

            // ======================== Special Food class Called ==================
            const Expanded(
                child: SingleChildScrollView(child: FoodListScreen())),
          ]),
    );
  }
}
