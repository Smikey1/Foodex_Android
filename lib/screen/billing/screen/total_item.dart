import 'package:flutter/material.dart';
import 'package:foodex_app/app/theme/constants.dart';
import 'package:foodex_app/app/utils/dimension.dart';
import 'package:foodex_app/model/cart.dart';
import 'package:foodex_app/repository/remote_repository/remote_cart_repository.dart';
import 'package:foodex_app/response/food_cart_response.dart';
import 'package:foodex_app/widgets/export_widgets.dart';

class CartItemScreen extends StatefulWidget {
  const CartItemScreen({super.key});

  @override
  State<CartItemScreen> createState() => _CartItemScreenState();
}

class _CartItemScreenState extends State<CartItemScreen> {
  List<Cart> cartList = [];

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context).scaffoldBackgroundColor,
      elevation: Dimensions.height10 - 7,
      child: Padding(
        padding: EdgeInsets.all(Dimensions.height10),
        child: SingleChildScrollView(
          // physics: const NeverScrollableScrollPhysics(),
          child: Column(
            children: [
              Align(
                  alignment: Alignment.centerLeft,
                  child: BigText(
                    text: "Orders",
                    fontWeight: FontWeight.bold,
                    size: Dimensions.font15,
                  )),
              Divider(
                thickness: Dimensions.height5 - 3,
              ),
              sendCartToBill(),
            ],
          ),
        ),
      ),
    );
  }

  FutureBuilder<CartResponse?> sendCartToBill() {
    return FutureBuilder<CartResponse?>(
        future: CartRepository().getAllCart(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            cartList = snapshot.data!.data!;
            return SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  for (int index = 0; index < cartList.length; index++)
                    Padding(
                      padding: const EdgeInsets.all(7.0),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
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
                                      image: NetworkImage(cartList[index]
                                          .foodId!
                                          .foodPhoto[0]))),
                            ),

                            //------------------- Text and icon section --------------------
                            Padding(
                              padding: EdgeInsets.only(
                                  left: Dimensions.width10,
                                  right: Dimensions.width10),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    width: Dimensions.width100,
                                    child: Text(
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      cartList[index].foodId!.title,
                                      style: TextStyle(
                                          fontSize: Dimensions.font15,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                  BigText(
                                    text:
                                        '\$${int.parse(cartList[index].foodId!.price) * cartList[index].quantity!}',
                                    size: Dimensions.font15,
                                    fontWeight: FontWeight.w500,
                                    color: AppColor.kPrimaryColor,
                                    // color: AppColor.kPrimaryColor,
                                  ),
                                ],
                              ),
                            ),
                          ]),
                    ),
                ],
              ),
            );
          } else {
            return const CircularProgressIndicator();
          }
        });
  }
}
