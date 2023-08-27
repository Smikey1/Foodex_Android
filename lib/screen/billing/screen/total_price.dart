import 'package:flutter/material.dart';
import 'package:foodex_app/app/theme/constants.dart';
import 'package:foodex_app/app/utils/dimension.dart';
import 'package:foodex_app/model/cart.dart';
import 'package:foodex_app/repository/remote_repository/remote_cart_repository.dart';
import 'package:foodex_app/widgets/export_widgets.dart';

class TotalPrice extends StatefulWidget {
  const TotalPrice({super.key});

  @override
  State<TotalPrice> createState() => _TotalPriceState();
}

class _TotalPriceState extends State<TotalPrice> {
  List<Cart> cartList = [];
  int? totalAmount = 0;
  List<Cart> cartListForTotalAmt = [];
  int? deliveryFee = 50;
  int? totalAmountWithDeliveryFee = 0;
  @override
  void initState() {
    setTotalCartAmt();
    setFinalAmount();
    super.initState();
  }

  void setTotalCartAmt() async {
    int? myTotalAmount = 0;
    final allCart = await CartRepository().getAllCart();
    cartListForTotalAmt = allCart!.data!;
    List<int> myAmountList = [];
    for (Cart i in cartListForTotalAmt) {
      int productAmount = int.parse(i.foodId!.price) * i.quantity!;
      myAmountList.add(productAmount);
    }
    for (int i in myAmountList) {
      myTotalAmount = myTotalAmount! + i;
    }
    setState(() {
      totalAmount = myTotalAmount;
    });
  }

  void setFinalAmount() async {
    int? myTotalAmount = 0;
    final allCart = await CartRepository().getAllCart();
    cartListForTotalAmt = allCart!.data!;
    List<int> myAmountList = [];
    for (Cart i in cartListForTotalAmt) {
      int productAmount = int.parse(i.foodId!.price) * i.quantity!;
      myAmountList.add(productAmount);
    }
    for (int i in myAmountList) {
      myTotalAmount = myTotalAmount! + i;
    }
    setState(() {
      totalAmountWithDeliveryFee = myTotalAmount! + deliveryFee!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context).scaffoldBackgroundColor,
      elevation: Dimensions.height10 - 7,
      child: Padding(
        padding: EdgeInsets.all(Dimensions.height10),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SmallText(
                  text: "Sub Total",
                  size: Dimensions.font15,
                ),
                SmallText(
                  text: "\$$totalAmount",
                  size: Dimensions.font15,
                ),
              ],
            ),
            SizedBox(
              height: Dimensions.height10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SmallText(
                  text: "Delivery Fee",
                  size: Dimensions.font15,
                ),
                SizedBox(
                  height: Dimensions.height10,
                ),
                SmallText(
                  text: "\$$deliveryFee",
                  size: Dimensions.font15,
                ),
              ],
            ),
            SizedBox(
              height: Dimensions.height10,
            ),
            const Divider(
              thickness: 2,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                BigText(
                  text: "Total Bill",
                  size: Dimensions.font20,
                ),
                BigText(
                  text: "\$$totalAmountWithDeliveryFee",
                  size: Dimensions.font20,
                  color: AppColor.kErrorColor,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
