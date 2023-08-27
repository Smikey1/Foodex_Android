import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:foodex_app/app/constraints/api_url.dart';
import 'package:foodex_app/app/theme/constants.dart';
import 'package:foodex_app/app/utils/dimension.dart';
import 'package:foodex_app/app/utils/notification.dart';
import 'package:foodex_app/home_button.dart';
import 'package:foodex_app/repository/remote_repository/food_order_repository.dart';
import 'package:foodex_app/screen/billing/screen/address.dart';
import 'package:foodex_app/screen/billing/screen/payment.dart';
import 'package:foodex_app/screen/billing/screen/total_item.dart';
import 'package:foodex_app/screen/billing/screen/total_price.dart';
import 'package:foodex_app/screen/cart/cart.dart';
import 'package:foodex_app/widgets/export_widgets.dart';
import 'package:khalti_flutter/khalti_flutter.dart';

class BillingScreen extends StatefulWidget {
  const BillingScreen({super.key});

  @override
  State<BillingScreen> createState() => _BillingScreenState();
}

class _BillingScreenState extends State<BillingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // appBar: AppBar(
        //   title: const Center(child: Text('Billing Screen')),
        //   backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        // ),
        body: SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(Dimensions.height10 / 2),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                // crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  GestureDetector(
                      onTap: () {
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                            builder: (_) => const CartScreen(),
                          ),
                        );
                      },
                      child: AppIcon(
                        backgroundColor:
                            Theme.of(context).scaffoldBackgroundColor,
                        icon: Icons.arrow_back_ios,
                        iconColor: Theme.of(context).colorScheme.onPrimary,
                        // size: Dimensions.iconSize20,
                      )),
                  Container(
                    // padding: EdgeInsets.only(top: Dimensions.height30),
                    color: Theme.of(context).scaffoldBackgroundColor,
                    child: Text(
                      'Payment',
                      style: TextStyle(
                        // color: Colors.white,
                        fontSize: Dimensions.font26,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  // const SizedBox(
                  //   width: ,
                  // ),
                  Container(
                    // padding: EdgeInsets.only(top: Dimensions.height30),
                    color: Theme.of(context).scaffoldBackgroundColor,
                    child: Center(
                      child: Text(
                        'Hell',
                        style: TextStyle(
                          color: Theme.of(context).scaffoldBackgroundColor,
                          fontSize: Dimensions.font26,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const Divider(),
              SizedBox(
                height: Dimensions.height10 / 2,
              ),
              const UserAddress(),
              SizedBox(
                height: Dimensions.height10,
              ),
              const CartItemScreen(),
              SizedBox(
                height: Dimensions.height10,
              ),
              PaymentScreen(),
              const TotalPrice(),
              Container(
                padding: EdgeInsets.all(Dimensions.height10 - 3),
                height: Dimensions.height50 + 20,
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: AppColor.kPrimaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                          Radius.circular(Dimensions.radius10)),
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
        isScrollControlled: true,
        // useSafeArea: false,
        builder: (BuildContext context) {
          return FractionallySizedBox(
            heightFactor: 0.3,
            child: Padding(
              padding: EdgeInsets.all(Dimensions.height20 + 5),
              child: Column(
                children: [
                  Text(
                    "Confirm your order with",
                    style: TextStyle(fontSize: Dimensions.font20),
                  ),
                  SizedBox(
                    height: Dimensions.height10,
                  ),
                  Text(
                    getSelectedPaymentMethod!,
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
                    height: Dimensions.height30,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.green),
                          onPressed: () async {
                            final result =
                                await OrderRepository().addProductToOrder();
                            if (result == true) {
                              setPaymentMethod(getSelectedPaymentMethod!);
                            }
                          },
                          icon: const Icon(Icons.check),
                          label: const Text("Confirm")),
                      ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: AppColor.kErrorColor),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: const Icon(
                            Icons.cancel,
                            color: Colors.white,
                          ),
                          label: const Text("Cancel")),
                    ],
                  ),
                ],
              ),
            ),
          );
        });
  }

// Cash Success dialog
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
        // Navigator.of(context).pop();
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (_) => const DashboardButton(),
          ),
        );
      },
    ).show();
  }

// Khalti Success dialog
  khaltiWallet() {
    KhaltiScope.of(context).pay(
      config: PaymentConfig(
          amount: 1000,
          productIdentity: "1",
          productName: "nike blazers mid 77",
          mobile: "9808792437"),
      preferences: [PaymentPreference.khalti],
      onSuccess: onSuccess,
      onFailure: onFailure,
      onCancel: onCanceled,
    );
  }

  // method to handle success
  void onSuccess(PaymentSuccessModel success) {
    AwesomeDialog(
      context: context,
      dialogType: DialogType.SUCCES,
      animType: AnimType.TOPSLIDE,
      // showCloseIcon: true,
      title: "Order Placed",
      desc: "Your Order has been placed Successfully",
      autoHide: const Duration(seconds: 5),
      // btnCancelOnPress: () {

      btnOkOnPress: () async {
        // Navigator.of(context).pop();
        MyNotification.showNotification(
          notificationTitle: "Order Success",
          notificationMessage: "Your Order has been placed",
        );
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (_) => const DashboardButton(),
          ),
        );
      },
    ).show();
  }

  // method to handle failure
  void onFailure(PaymentFailureModel failure) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text("Failure"),
            content: const Text("Payment failed"),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text("OK"))
            ],
          );
        });
  }

  // method to handle onCanceled
  void onCanceled() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text("Canceled"),
            content: const Text("Payment canceled"),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text("OK"))
            ],
          );
        });
  }

  void setPaymentMethod(String selectedPaymentMethod) {
    print(selectedPaymentMethod);
    if (getSelectedPaymentMethod == "COD") {
      showSuccessDialog(context);
      MyNotification.showNotification(
          notificationTitle: "Order Placed",
          notificationMessage: "Your oder has been placed successfully");
    } else if (getSelectedPaymentMethod == "Khalti") {
      khaltiWallet();
    } else {
      print("From esewa");
    }
  }
}
