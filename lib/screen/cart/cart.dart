import 'package:flutter/material.dart';
import 'package:foodex_app/app/router/routes.dart';
import 'package:foodex_app/app/theme/constants.dart';
import 'package:foodex_app/app/utils/dimension.dart';
import 'package:foodex_app/app/utils/notification.dart';
import 'package:foodex_app/model/cart.dart';
import 'package:foodex_app/repository/remote_repository/remote_cart_repository.dart';
import 'package:foodex_app/response/food_cart_response.dart';
import 'package:foodex_app/screen/billing/screen/billing_screen.dart';
import 'package:foodex_app/screen/food/specialFood.dart';
import 'package:foodex_app/widgets/export_widgets.dart';
import 'package:foodex_app/widgets/snack_bar.dart';
import 'package:get/get.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

class CartScreen extends StatefulWidget {
  final String? receivedFood;
  const CartScreen({super.key, this.receivedFood});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  List<Cart> cartList = [];
  int? totalAmount = 0;
  List<Cart> cartListForTotalAmt = [];
  @override
  void initState() {
    setTotalCartAmt();
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        // ----------------------- Top NavBar ----------------------------------
        Positioned(
            top: Dimensions.height20 * 3,
            left: Dimensions.width20,
            right: Dimensions.width20,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: AppIcon(
                    icon: Icons.arrow_back_ios,
                    iconColor: Colors.white,
                    backgroundColor: AppColor.kSecondaryColor,
                    iconSize: Dimensions.iconSize24,
                  ),
                ),
                SizedBox(
                  width: Dimensions.width20 * 5,
                ),
                GestureDetector(
                  onTap: () {
                    Get.toNamed(RouterHelper.getInitial());
                  },
                  child: AppIcon(
                    icon: Icons.home_outlined,
                    iconColor: Colors.white,
                    backgroundColor: AppColor.kSecondaryColor,
                    iconSize: Dimensions.iconSize24,
                  ),
                ),
                AppIcon(
                  icon: LineAwesomeIcons.history,
                  iconColor: Colors.white,
                  backgroundColor: AppColor.kSecondaryColor,
                  iconSize: Dimensions.iconSize24,
                ),
              ],
            )),
        getAllCart(),
      ]),

      //------------------------------ Bottom Nav bar --------------------------
      bottomNavigationBar: Container(
        height: Dimensions.bottomHeightBar,
        padding: EdgeInsets.only(
            top: Dimensions.height30,
            bottom: Dimensions.height30,
            left: Dimensions.width20,
            right: Dimensions.width20),
        decoration: BoxDecoration(
            color: Theme.of(context).scaffoldBackgroundColor,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(Dimensions.radius20 * 2),
                topRight: Radius.circular(Dimensions.radius20 * 2))),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              padding: EdgeInsets.only(
                  top: Dimensions.height20,
                  bottom: Dimensions.height20,
                  left: Dimensions.width20,
                  right: Dimensions.width20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(Dimensions.radius20),
                color: Colors.black12,
              ),
              child: BigText(
                text: "Total Rs.$totalAmount",
              ),
            ),
            GestureDetector(
              onTap: () {
                if (totalAmount == 0) {
                  showSnackbar(context,
                      "Your cart is empty. Please add some item!", Colors.red);
                } else {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (_) => const BillingScreen(),
                    ),
                  );
                }
              },
              child: Container(
                padding: EdgeInsets.only(
                    top: Dimensions.height20,
                    bottom: Dimensions.height20,
                    left: Dimensions.width20,
                    right: Dimensions.width20),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(Dimensions.radius20),
                    color: Theme.of(context).colorScheme.primary),
                child: BigText(
                  text: 'Checkout',
                  color: Colors.white,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  // -------------------------------------- Get All Cart -----------------------
  FutureBuilder<CartResponse?> getAllCart() {
    return FutureBuilder<CartResponse?>(
        future: CartRepository().getAllCart(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            cartList = snapshot.data!.data!;
            return Positioned(
                top: Dimensions.height20 * 5,
                left: Dimensions.width20,
                right: Dimensions.width20,
                bottom: 0,
                child: Container(
                  // color: Colors.red,
                  margin: EdgeInsets.only(top: Dimensions.height15),
                  child: MediaQuery.removePadding(
                    context: context,
                    removeTop: true,
                    child: ListView.builder(
                        itemCount: cartList.length,
                        itemBuilder: (_, index) {
                          return GestureDetector(
                            onLongPress: () {
                              showAlertDialog(context, cartList[index]);
                            },
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => SpecialFoodDetails(
                                            receivedFoodId:
                                                cartList[index].foodId!.id!,
                                            receivedFoodPrice:
                                                cartList[index].foodId!.price,
                                            receivedFoodName:
                                                cartList[index].foodId!.title,
                                          )));
                            },
                            child: SizedBox(
                              width: double.maxFinite,
                              height: Dimensions.height20 * 5,
                              child: Row(children: [
                                Container(
                                  width: Dimensions.height20 * 5,
                                  height: Dimensions.height20 * 5,
                                  margin: EdgeInsets.only(
                                      bottom: Dimensions.height10),
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image: NetworkImage(cartList[index]
                                            .foodId!
                                            .foodPhoto[0])),
                                    borderRadius: BorderRadius.circular(
                                        Dimensions.radius20),
                                    color: Colors.white,
                                  ),
                                ),
                                SizedBox(
                                  width: Dimensions.width10,
                                ),
                                Expanded(
                                  child: SizedBox(
                                    height: Dimensions.height20 * 5,
                                    child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          BigText(
                                              text:
                                                  cartList[index].foodId!.title,
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .onPrimary),
                                          SmallText(
                                              text: cartList[index]
                                                  .foodId!
                                                  .description),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              BigText(
                                                  text:
                                                      'Rs.${int.parse(cartList[index].foodId!.price) * cartList[index].quantity!}',
                                                  color: Colors.green),
                                              Container(
                                                padding: EdgeInsets.only(
                                                    top: Dimensions.height10,
                                                    bottom: Dimensions.height10,
                                                    left: Dimensions.width10,
                                                    right: Dimensions.width10),
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            Dimensions
                                                                .radius20),
                                                    color: Theme.of(context)
                                                        .scaffoldBackgroundColor,
                                                    boxShadow: [
                                                      BoxShadow(
                                                        color: Colors.grey
                                                            .withOpacity(0.5),
                                                        spreadRadius: 1,
                                                        blurRadius: 7,
                                                        offset:
                                                            const Offset(0, 3),
                                                      ),
                                                    ]),
                                                child: Row(children: [
                                                  const Text('Qty:',
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Colors.green)),
                                                  SizedBox(
                                                    width:
                                                        Dimensions.width10 / 2,
                                                  ),
                                                  Text(
                                                      '${cartList[index].quantity!}',
                                                      style: const TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Colors.green)),
                                                  SizedBox(
                                                    width:
                                                        Dimensions.width10 / 2,
                                                  ),
                                                ]),
                                              ),
                                            ],
                                          )
                                        ]),
                                  ),
                                )
                              ]),
                            ),
                          );
                        }),
                  ),
                ));
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        });
  }

  void getCheckoutDetails() {
    print(
        "The total item need to checkout is:--> ${cartListForTotalAmt.length}");
    for (var element in cartListForTotalAmt) {
      print(
          "The Food name is:--> ${element.foodId!.title} with qty: -->${element.quantity}");
    }
    print("The total amount need to payment is:--> $totalAmount");
  }

  // final mq = MediaQuery.of(context);

  void showAlertDialog(BuildContext context, Cart cart) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return Dialog(
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            insetPadding: const EdgeInsets.all(12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Remove ${cart.foodId!.title} from cart:',
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    // color: Colors.green,
                    width: double.maxFinite,
                    height: Dimensions.height20 * 5,
                    child: Row(children: [
                      Container(
                        width: Dimensions.height20 * 5,
                        height: Dimensions.height20 * 5,
                        margin: EdgeInsets.only(bottom: Dimensions.height10),
                        decoration: BoxDecoration(
                          image: DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage(cart.foodId!.foodPhoto[0])),
                          borderRadius:
                              BorderRadius.circular(Dimensions.radius20),
                          // color: Colors,
                        ),
                      ),
                      SizedBox(
                        width: Dimensions.width10,
                      ),
                      Expanded(
                        child: SizedBox(
                          height: Dimensions.height20 * 5,
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                BigText(
                                    text: cart.foodId!.title,
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onPrimary),
                                SmallText(text: cart.foodId!.description),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    BigText(
                                        text:
                                            'Rs.${int.parse(cart.foodId!.price) * cart.quantity!}',
                                        color: Colors.green),
                                    Container(
                                      padding: EdgeInsets.only(
                                          top: Dimensions.height10,
                                          bottom: Dimensions.height10,
                                          left: Dimensions.width10,
                                          right: Dimensions.width10),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(
                                            Dimensions.radius20),
                                        color: Theme.of(context)
                                            .scaffoldBackgroundColor,
                                      ),
                                      child: Row(children: [
                                        const Text('Qty:',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.green)),
                                        SizedBox(
                                          width: Dimensions.width10 / 2,
                                        ),
                                        Text("${cart.quantity}",
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.green)),
                                        SizedBox(
                                          width: Dimensions.width10 / 2,
                                        ),
                                      ]),
                                    ),
                                  ],
                                )
                              ]),
                        ),
                      )
                    ]),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: AppColor.kErrorColor),
                          child: const Text(
                            'Remove',
                            style: TextStyle(color: Colors.white),
                          ),
                          onPressed: () async {
                            List<Cart> cloneCartList = cartList;
                            final result = await CartRepository()
                                .deleteProductFromCart(cart.foodId!.id!);
                            if (result == true) {
                              cartList.removeAt(
                                cloneCartList.length - 1,
                              );
                              setState(() {
                                cartList = cloneCartList;
                                setTotalCartAmt();
                              });
                              MyNotification.showNotification(
                                notificationTitle: "Cart",
                                notificationMessage:
                                    "${cart.foodId!.title} removed from cart",
                              );

                              Navigator.of(context).pop();
                            }
                          }),
                      ElevatedButton(
                        child: const Text(
                          'Cancel',
                          style: TextStyle(color: Colors.white),
                        ),
                        onPressed: () => Navigator.of(context).pop(),
                      ),
                    ],
                  )
                ],
              ),
            ),
          );
        });
  }
}
