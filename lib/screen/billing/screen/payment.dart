import 'package:flutter/material.dart';
import 'package:foodex_app/app/utils/dimension.dart';
import 'package:foodex_app/widgets/export_widgets.dart';

enum paymentEnum { COD, Khalti, Esewa }

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context).scaffoldBackgroundColor,
      elevation: Dimensions.height10,
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: EdgeInsets.all(Dimensions.height10),
          child: Column(
            children: [
              GestureDetector(
                onTap: () {
                  print(getSelectedValue(selectedIndex));
                },
                child: Align(
                    alignment: Alignment.centerLeft,
                    child: BigText(
                      text: "Choose Payment Method",
                      size: Dimensions.font15,
                    )),
              ),
              Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedIndex = 1;
                      });
                    },
                    child: Row(
                      children: [
                        Radio(
                          value: selectedIndex,
                          groupValue: 1,
                          onChanged: (value) {
                            setState(() {
                              selectedIndex = 1;
                            });
                          },
                        ),
                        AppIcon(icon: Icons.money, size: Dimensions.iconSize20),
                        SizedBox(
                          width: Dimensions.height10,
                        ),
                        SmallText(
                          text: 'Cash on Delivery',
                          size: Dimensions.font15,
                        ),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedIndex = 2;
                      });
                    },
                  child:Row(
                    children: [
                      Radio(
                        value: selectedIndex,
                        groupValue: 2,
                        onChanged: (value) {
                          setState(() {
                            print("The value is:");
                            selectedIndex = 2;
                          });
                        },
                      ),
                      CircleAvatar(
                        radius: Dimensions.radius15,
                        backgroundColor: Colors.transparent,
                        backgroundImage: const NetworkImage(
                            "https://res.cloudinary.com/dymp3ozdm/image/upload/v1676926243/foodex/Logo/khalti-removebg-preview_sx6sbt.png"),
                      ),
                      SizedBox(
                        width: Dimensions.width15,
                      ),
                      SmallText(
                        text: 'Khalti',
                        size: Dimensions.font15,
                      ),
                    ],
                  ),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedIndex = 3;
                      });
                    },
                  child:Row(
                    children: [
                      Radio(
                        value: selectedIndex,
                        groupValue: 3,
                        onChanged: (value) {
                          setState(() {
                            selectedIndex = 3;
                          });
                        },
                      ),
                      CircleAvatar(
                        backgroundColor: Colors.transparent,
                        radius: Dimensions.radius15 - 3,
                        backgroundImage: const NetworkImage(
                            "https://res.cloudinary.com/dymp3ozdm/image/upload/v1676926067/foodex/Logo/esewa_p5x3o4.png"),
                      ),
                      SizedBox(
                        width: Dimensions.width10,
                      ),
                      SmallText(
                        text: 'Esewa',
                        size: Dimensions.font15,
                      ),
                    ],
                  ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  String getSelectedValue(int selectedIndex) {
    String paymentMethod = '';
    if (selectedIndex == 1) {
      paymentMethod = "COD";
    } else if (selectedIndex == 2) {
      paymentMethod = "Khalti";
    } else if (selectedIndex == 3) {
      paymentMethod = "Esewa";
    }
    return paymentMethod;
  }
}
