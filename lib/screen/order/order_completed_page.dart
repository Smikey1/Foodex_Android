import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:foodex_app/app/constraints/permissions.dart';
import 'package:foodex_app/app/theme/constants.dart';
import 'package:foodex_app/app/utils/dimension.dart';
import 'package:foodex_app/model/order.dart';
import 'package:foodex_app/repository/remote_repository/food_order_repository.dart';
import 'package:foodex_app/response/food_order_response.dart';
import 'package:foodex_app/screen/billing/screen/billing_screen.dart';
import 'package:foodex_app/screen/food/specialFood.dart';
import 'package:foodex_app/widgets/big_text.dart';
import 'package:foodex_app/widgets/icon_text.dart';
import 'package:foodex_app/widgets/small_text.dart';

class OrderCompletedPage extends StatefulWidget {
  const OrderCompletedPage({super.key});

  @override
  State<OrderCompletedPage> createState() => _OrderCompletedPageState();
}

class _OrderCompletedPageState extends State<OrderCompletedPage> {
  List<Order> orderList = [];
  FutureBuilder<OrderResponse?> getAllOrder() {
    return FutureBuilder<OrderResponse?>(
        future: OrderRepository().getAllOrder(ORDER_COMPLETED),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            orderList = snapshot.data!.data!;
            return ListView.builder(
              itemCount: orderList.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => SpecialFoodDetails(
                                receivedFoodId: orderList[index].foodId!.id,
                                receivedFoodPrice:
                                    orderList[index].foodId!.price,
                                receivedFoodName:
                                    orderList[index].foodId!.title)));
                  },
                  child: Padding(
                    padding: EdgeInsets.all(Dimensions.height5),
                    child: Card(
                      color: Theme.of(context).cardColor,
                      elevation: Dimensions.height10,
                      child: Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(
                                top: Dimensions.width10,
                                left: Dimensions.width20,
                                right: Dimensions.width20,
                                bottom: Dimensions.width10),
                            child: Row(children: [
                              BigText(text: "Order Id: 12345"),
                              const Spacer(),
                              IconTextWidget(
                                icon: Icons.attach_money,
                                Text:
                                    "Total: ${orderList[index].foodId!.price}",
                                iconColor: AppColor.kPrimaryColor,
                              ),
                            ]),
                          ),
                          Divider(
                            thickness: Dimensions.height5 - 3,
                          ),
                          Container(
                            // color: Theme.of(context).scaffoldBackgroundColor,
                            margin: EdgeInsets.only(
                              top: Dimensions.width10 / 2,
                              left: Dimensions.width20,
                              right: Dimensions.width20,
                              bottom: Dimensions.width10,
                            ),
                            child: Row(children: [
                              //----------------------- Image Section ------------------------
                              Container(
                                width: Dimensions.width100,
                                height: Dimensions.height100,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(
                                        Dimensions.radius20),
                                    // color: AppColor.kPrimaryColor,
                                    image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image: NetworkImage(orderList[index]
                                            .foodId!
                                            .foodPhoto[0]))),
                              ),

                              //------------------- Text and icon section --------------------
                              Expanded(
                                child: Padding(
                                  padding: EdgeInsets.only(
                                      left: Dimensions.width10,
                                      right: Dimensions.width10),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    // mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          BigText(
                                              text:
                                                  "${orderList[index].foodId!.title} "),
                                          SizedBox(
                                            height: Dimensions.height15,
                                          ),
                                          Row(
                                            children: [
                                              SmallText(
                                                  text:
                                                      " ${orderList[index].orderedQuantity} items"),
                                              SizedBox(
                                                height: Dimensions.height10,
                                                child: VerticalDivider(
                                                  width: Dimensions.width10,
                                                  thickness:
                                                      Dimensions.height10 - 3,
                                                  indent: Dimensions.height20,
                                                  endIndent:
                                                      Dimensions.height5 - 3,
                                                  color: Colors.black,
                                                ),
                                              ),
                                              SmallText(text: "1.3 km"),
                                            ],
                                          ),
                                          SizedBox(
                                            height: Dimensions.height15,
                                          ),
                                          Row(
                                            children: [
                                              BigText(
                                                text:
                                                    "Rs.${orderList[index].foodId!.price}.0",
                                                color: AppColor.kPrimaryColor,
                                              ),
                                              SizedBox(
                                                height: Dimensions.height10,
                                                child: VerticalDivider(
                                                  width: Dimensions.width10,
                                                  thickness:
                                                      Dimensions.height10 - 3,
                                                  indent: Dimensions.height20,
                                                  endIndent:
                                                      Dimensions.height5 - 3,
                                                  color: Colors.black,
                                                ),
                                              ),
                                              Container(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal:
                                                        Dimensions.width10,
                                                    vertical:
                                                        Dimensions.height5),
                                                decoration: BoxDecoration(
                                                    color:
                                                        AppColor.kPrimaryColor,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            Dimensions
                                                                .radius10)),
                                                child: SmallText(
                                                  text: "Paid",
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ]),
                          ),
                          Divider(
                            thickness: Dimensions.height5 - 3,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              ElevatedButton(
                                onPressed: () {},
                                style: ElevatedButton.styleFrom(
                                  side: const BorderSide(
                                      color: AppColor.kPrimaryColor),
                                  backgroundColor: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                        Dimensions.radius10),
                                  ),
                                ),
                                child: const Text(
                                  'Leave a Review',
                                  style:
                                      TextStyle(color: AppColor.kPrimaryColor),
                                ),
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  showAlertDialog(context);
                                },
                                style: ElevatedButton.styleFrom(
                                  side: const BorderSide(color: Colors.green),
                                  backgroundColor: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                        Dimensions.radius10),
                                  ),
                                ),
                                child: const Text(
                                  'Order Again',
                                  style: TextStyle(
                                      color: Colors.green,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: Dimensions.height5,
                          )
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        });
  }

  @override
  Widget build(BuildContext context) {
    return getAllOrder();
  }

  void showAlertDialog(BuildContext context) {
    AwesomeDialog(
      context: context,
      dialogType: DialogType.WARNING,
      animType: AnimType.TOPSLIDE,
      showCloseIcon: true,
      title: "Order Again",
      desc: "Do you want to order this food again?",
      autoHide: const Duration(seconds: 3),
      btnCancelOnPress: () {
        Navigator.of(context).pop();
      },
      btnOkOnPress: () async {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => const BillingScreen(),
          ),
        );
      },
    ).show();
  }
}
