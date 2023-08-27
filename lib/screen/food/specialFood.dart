import 'package:flutter/material.dart';
import 'package:foodex_app/app/constraints/permissions.dart';
import 'package:foodex_app/app/theme/constants.dart';
import 'package:foodex_app/app/utils/dimension.dart';
import 'package:foodex_app/model/export_model.dart';
import 'package:foodex_app/repository/remote_repository/export_remote_repo.dart';
import 'package:foodex_app/repository/remote_repository/remote_cart_repository.dart';
import 'package:foodex_app/response/single_food_response.dart';
import 'package:foodex_app/screen/export_screen.dart';
import 'package:foodex_app/widgets/export_widgets.dart';
import 'package:foodex_app/app/utils/notification.dart';
import 'package:foodex_app/widgets/snack_bar.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

class SpecialFoodDetails extends StatefulWidget {
  final String? receivedFoodId;
  final String? receivedFoodPrice;
  final String? receivedFoodName;
  const SpecialFoodDetails(
      {super.key,
      required this.receivedFoodId,
      required this.receivedFoodPrice,
      required this.receivedFoodName});

  @override
  State<SpecialFoodDetails> createState() => _SpecialFoodDetailsState();
}

class _SpecialFoodDetailsState extends State<SpecialFoodDetails> {
  int? foodPrice = 0;
  int qty = 1;

  bool isAddedToCart = false;

  bool isCartDelete = false;

  addToCart(String foodId, String quantity) async {
    final isNewItemAddedToCart =
        await CartRepository().addProductToCart(foodId, quantity);
    return isNewItemAddedToCart;
  }

  deleteProductFromCart(String foodId) async {
    final isDeleted = await CartRepository().deleteProductFromCart(foodId);
    return isDeleted;
  }

  @override
  void initState() {
    getSpecialFood();
    foodPrice = int.parse(widget.receivedFoodPrice!);
    super.initState();
  }

  int getTotalAmt(int foodPrice, int qty) {
    return foodPrice * qty;
  }

  FutureBuilder<SingleFoodResponse?> getSpecialFood() {
    return FutureBuilder<SingleFoodResponse?>(
        future: FoodRepository().getSingleFood(widget.receivedFoodId!),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            Food? foodData = snapshot.data!.data!;
            foodPrice = int.parse(foodData.price);
            print("The Food: -->${foodData.title}");
            return Stack(
              children: [
                //Background Image
                Positioned(
                    left: 0,
                    right: 0,
                    child: Container(
                      width: double.infinity,
                      height: Dimensions.popularFoodImageSize,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage(
                                foodData.foodPhoto.isNotEmpty
                                    ? foodData.foodPhoto[0]
                                    : imageUnavailable,
                              ))),
                    )),
                // icon Widget
                Positioned(
                    top: Dimensions.height45,
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
                              icon: LineAwesomeIcons.arrow_left,
                              size: Dimensions.height20 + 20,
                              iconSize: Dimensions.iconSize20 + 10,
                              iconColor: AppColor.kSecondaryColor,
                            )),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => const CartScreen()));
                          },
                          child: Stack(
                            children: [
                              AppIcon(
                                icon: Icons.shopping_cart_outlined,
                                iconColor: AppColor.kSecondaryColor,
                                size: Dimensions.height20 + 20,
                                iconSize: Dimensions.iconSize20 + 10,
                              ),
                              isAddedToCart == true
                                  ? Positioned(
                                      top: 0,
                                      right: 0,
                                      child: AppIcon(
                                        icon: Icons.brightness_1,
                                        backgroundColor: Colors.red,
                                        iconColor: Colors.red,
                                        size: Dimensions.height20,
                                        iconSize: Dimensions.iconSize20,
                                      ))
                                  : Container(),
                            ],
                          ),
                        ),
                      ],
                    )),
                // Food Introduction
                Positioned(
                    left: 0,
                    right: 0,
                    bottom: 0,
                    top: Dimensions.popularFoodImageSize - 20,
                    child: Container(
                        padding: EdgeInsets.only(
                            left: Dimensions.width20,
                            right: Dimensions.width20,
                            top: Dimensions.height20),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(Dimensions.radius20),
                            topLeft: Radius.circular(Dimensions.radius20),
                          ),
                          color: Theme.of(context).scaffoldBackgroundColor,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            FoodDetail(
                              text: foodData.title,
                            ),
                            SizedBox(
                              height: Dimensions.height20,
                            ),
                            BigText(text: 'Introduce'),
                            SizedBox(
                              height: Dimensions.height20,
                            ),
                            Expanded(
                                child: SingleChildScrollView(
                              child: Center(
                                child: Text(
                                  foodData.description,
                                  textAlign: TextAlign.justify,
                                ),
                              ),
                            )),
                          ],
                        )))
              ],
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.white,
      body: getSpecialFood(),
      bottomNavigationBar: Container(
        height: Dimensions.bottomHeightBar,
        padding: EdgeInsets.only(
            top: Dimensions.height30,
            bottom: Dimensions.height30,
            left: Dimensions.width20,
            right: Dimensions.width20),
        decoration: BoxDecoration(
            color: AppColor.kPrimaryColor,
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
                color: Colors.white,
              ),
              child: Row(children: [
                InkWell(
                  onTap: () {
                    setState(() {
                      qty > 1
                          ? qty -= 1
                          : showSnackbar(
                              context,
                              "Quantity  1 Items Must be selected",
                              AppColor.kErrorColor);
                    });
                  },
                  child: const Icon(
                    Icons.remove,
                    color: AppColor.kErrorColor,
                  ),
                ),
                SizedBox(
                  width: Dimensions.width10 / 2,
                ),
                BigText(
                  text: "$qty",
                  color: Colors.black,
                ),
                SizedBox(
                  width: Dimensions.width10 / 2,
                ),
                InkWell(
                  onTap: () {
                    setState(() {
                      qty += 1;
                    });
                  },
                  child: const Icon(
                    Icons.add,
                    color: Colors.green,
                  ),
                )
              ]),
            ),
            Container(
              padding: EdgeInsets.only(
                  top: Dimensions.height20,
                  bottom: Dimensions.height20,
                  left: Dimensions.width20,
                  right: Dimensions.width20),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(Dimensions.radius20),
                  color: AppColor.kSecondaryColor),
              child: GestureDetector(
                onTap: () async {
                  final result =
                      await addToCart(widget.receivedFoodId!, qty.toString());
                  setState(() {
                    isAddedToCart = result != null ? true : false;
                  });
                  MyNotification.showNotification(
                    notificationTitle: "FoodEx Cart",
                    notificationMessage:
                        " ${widget.receivedFoodName!} Add to Cart Successfully",
                  );
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                        backgroundColor: Colors.green,
                        content: const Text(
                          "Item added to cart Successfully",
                          style: TextStyle(color: Colors.white),
                        ),
                        action: SnackBarAction(
                            label: "View Cart",
                            textColor: Colors.white,
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => const CartScreen()));
                            })),
                  );
                },
                child: BigText(
                  text: 'Rs.${getTotalAmt(foodPrice!, qty)} | Add to cart',
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
