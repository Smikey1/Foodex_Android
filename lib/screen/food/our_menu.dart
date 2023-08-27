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

class OurFoodMenu extends StatefulWidget {
  final String? receivedFoodId;
  final String? receivedFoodPrice;
  final String? receivedFood;
  const OurFoodMenu({
    super.key,
    required this.receivedFoodId,
    required this.receivedFoodPrice,
    required this.receivedFood,
  });

  @override
  State<OurFoodMenu> createState() => _OurFoodMenuState();
}

class _OurFoodMenuState extends State<OurFoodMenu> {
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
    getSingleFood();
    foodPrice = int.parse(widget.receivedFoodPrice!);
    super.initState();
  }

  FutureBuilder<SingleFoodResponse?> getSingleFood() {
    return FutureBuilder<SingleFoodResponse?>(
      future: FoodRepository().getSingleFood(widget.receivedFoodId!),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          Food? foodData = snapshot.data!.data!;
          foodPrice = int.parse(foodData.price);
          print("The Food: -->${foodData.title}");
          return CustomScrollView(
            slivers: [
              SliverAppBar(
                automaticallyImplyLeading: false,
                toolbarHeight: 70,
                title: Row(
                  children: [
                    GestureDetector(
                        onTap: () {
                          // Get.toNamed(RouterHelper.getInitial());

                          // OR
                          Navigator.pop(context);
                        },
                        child: AppIcon(
                          icon: Icons.clear,
                          size: Dimensions.height20 + 20,
                          iconSize: Dimensions.iconSize20 + 10,
                          iconColor: AppColor.kSecondaryColor,
                        )),
                    const Spacer(),
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
                ),
                bottom: PreferredSize(
                  preferredSize: const Size.fromHeight(20),
                  child: Container(
                      width: double.maxFinite,
                      padding:
                          EdgeInsets.only(top: 5, bottom: Dimensions.height10),
                      decoration: BoxDecoration(
                        color: Theme.of(context).scaffoldBackgroundColor,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(Dimensions.radius20 * 2),
                            topRight: Radius.circular(Dimensions.radius20 * 2)),
                      ),
                      child: Center(
                          child: BigText(
                              size: Dimensions.font26, text: foodData.title))),
                ),
                pinned: true,
                backgroundColor: AppColor.kPrimaryColor,
                expandedHeight: 300,
                flexibleSpace: FlexibleSpaceBar(
                  background: Image.network(
                    foodData.foodPhoto.isNotEmpty
                        ? foodData.foodPhoto[0]
                        : imageUnavailable,
                    fit: BoxFit.cover,
                    width: double.maxFinite,
                  ),
                ),
              ),
              SliverToBoxAdapter(
                  child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(
                        right: Dimensions.width20, left: Dimensions.width20),
                    child: Center(
                      child: Text(
                        foodData.description,
                        textAlign: TextAlign.justify,
                      ),
                    ),
                  )
                ],
              ))
            ],
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: getSingleFood(),
      bottomNavigationBar: Column(mainAxisSize: MainAxisSize.min, children: [
        Container(
          color: Theme.of(context).scaffoldBackgroundColor,
          padding: EdgeInsets.only(
              left: Dimensions.width20 * 2.5,
              right: Dimensions.width20 * 2.5,
              top: Dimensions.height10,
              bottom: Dimensions.height10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                onTap: () {
                  setState(() {
                    qty > 1
                        ? qty -= 1
                        :
                        // SnackbarWidget().showBlurredSnackBar(
                        //     context,
                        //     "1 Quantity Items Must be selected",
                        //     AppColor.kErrorColor);
                        showSnackbar(
                            context,
                            "Quantity  1 Items Must be selected",
                            AppColor.kErrorColor);
                  });
                },
                child: AppIcon(
                  icon: Icons.remove,
                  backgroundColor: AppColor.kPrimaryColor,
                  iconColor: Colors.white,
                  iconSize: Dimensions.iconSize24,
                ),
              ),
              BigText(
                text: 'Rs. $foodPrice X $qty',
                size: Dimensions.font26,
              ),
              InkWell(
                onTap: () {
                  setState(() {
                    qty += 1;
                  });
                },
                child: AppIcon(
                  icon: Icons.add,
                  backgroundColor: AppColor.kPrimaryColor,
                  iconColor: Colors.white,
                  iconSize: Dimensions.iconSize24,
                ),
              ),
            ],
          ),
        ),
        Container(
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
                    color: Theme.of(context).colorScheme.background,
                  ),
                  child: const Icon(
                    Icons.favorite,
                    color: AppColor.kErrorColor,
                  )),
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
                    MyNotification.showNotification(
                      notificationTitle: "FoodEx Cart",
                      notificationMessage:
                          "${widget.receivedFood!} Add to Cart Successfully",
                    );
                    final result =
                        await addToCart(widget.receivedFoodId!, qty.toString());
                    setState(() {
                      isAddedToCart = result != null ? true : false;
                    });
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
      ]),
    );
  }

  int getTotalAmt(int foodPrice, int qty) {
    return foodPrice * qty;
  }
}
