import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:foodex_app/app/theme/constants.dart';
import 'package:foodex_app/app/utils/dimension.dart';
import 'package:foodex_app/app/utils/notification.dart';
import 'package:foodex_app/screen/billing/screen/address.dart';
import 'package:foodex_app/screen/billing/screen/payment.dart';
import 'package:foodex_app/screen/billing/screen/total_item.dart';
import 'package:foodex_app/screen/billing/screen/total_price.dart';
import 'package:foodex_app/screen/order/order_main.dart';

class BillingScreen extends StatefulWidget {
  const BillingScreen({super.key});

  @override
  State<BillingScreen> createState() => _BillingScreenState();
}

class _BillingScreenState extends State<BillingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Center(child: Text('Billing Screen')),
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(Dimensions.height10),
              child: Column(
                children: [
                  const UserAddress(),
                  SizedBox(
                    height: Dimensions.height10,
                  ),
                  const CartItemScreen(),
                  SizedBox(
                    height: Dimensions.height10,
                  ),
                  const PaymentScreen(),
                  const TotalPrice(),
                  Container(
                    padding: EdgeInsets.all(Dimensions.height10 - 3),
                    height: Dimensions.height50 + 20,
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: AppColor.kPrimaryColor,
                        shape:  RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(Dimensions.radius10)),
                        ),
                      ),
                      onPressed: () {
                        showAlertDialog(context);
                      },
                      child: const Text('Place Order'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }

  void showAlertDialog(BuildContext context) {
    showModalBottomSheet(
        context: context,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        // isScrollControlled: true,
        // barrierDismissible: true,
        builder: (BuildContext context) {
          return Padding(
            padding: EdgeInsets.all(Dimensions.height20),
            child: Column(
              children: [
                Text(
                  "Conform your order with",
                  style: TextStyle(fontSize: Dimensions.font20),
                ),
                SizedBox(
                  height: Dimensions.height10,
                ),
                Text(
                  "Cash Payment",
                  style: TextStyle(fontSize: Dimensions.font20),
                ),
                SizedBox(
                  height: Dimensions.height10,
                ),
                Text(
                  "Your order will be placed and delivered on time!",
                  style: TextStyle(fontSize: Dimensions.height15),
                ),
                SizedBox(
                  height: Dimensions.height10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green),
                        onPressed: () {
                          showSuccessDialog(context);
                          MyNotification.showNotification(
                              notificationTitle: "Order Placed",
                              notificationMessage:
                                  "Your order has been placed");
                        },
                        icon: const Icon(Icons.check),
                        label: const Text("Conform")),
                    ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: AppColor.kErrorColor),
                        onPressed: () {},
                        icon: const Icon(
                          Icons.cancel,
                          color: Colors.white,
                        ),
                        label: const Text("Cancel")),
                  ],
                ),
              ],
            ),
          );
        });
  }

  void showSuccessDialog(BuildContext context) {
    AwesomeDialog(
      context: context,
      dialogType: DialogType.SUCCES,
      animType: AnimType.TOPSLIDE,
      showCloseIcon: true,
      title: "Order Placed",
      desc: "Your Order has been placed Successfully",
      autoHide: const Duration(seconds: 5),
      // btnCancelOnPress: () {

      btnOkOnPress: () async {
        Navigator.of(context).pop();

        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (_) => const OrderScreen(),
          ),
        );
      },
    ).show();
  }
}
