import 'package:flutter/material.dart';
import 'package:foodex_app/app/router/routes.dart';
import 'package:foodex_app/app/theme/constants.dart';
import 'package:foodex_app/app/utils/dimension.dart';
import 'package:foodex_app/screen/food/our_menu.dart';
import 'package:foodex_app/widgets/export_widgets.dart';
import 'package:get/get.dart';

import '../../model/food.dart';

class CategoryScreen extends StatefulWidget {
  final Food? receievedFood;
  const CategoryScreen(@required this.receievedFood, {super.key});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  bool isFromHomePage = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GestureDetector(
        onTap: () {
          Get.toNamed(RouterHelper.getPopularFood());
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (_) => OurFoodMenu(
                      receivedFoodId: widget.receievedFood!.id,
                      receivedFoodPrice: widget.receievedFood!.price,
                      receivedFood: widget.receievedFood!.title)));
        },
        child: Container(
          margin: EdgeInsets.only(
              left: Dimensions.width20,
              right: Dimensions.width20,
              bottom: Dimensions.height10),
          child: Column(
            children: [
              Row(children: [
                //----------------------- Image Section ------------------------
                Container(
                  width: Dimensions.listViewImgSize,
                  height: Dimensions.listViewImgSize,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(Dimensions.radius20),
                      // color: AppColor.kPrimaryColor,
                      image: DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(
                              widget.receievedFood!.foodPhoto[0]!))),
                ),

                //------------------- Text and icon section --------------------
                Container(
                  height: Dimensions.listViewTextContSize,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(Dimensions.radius20),
                        bottomRight: Radius.circular(Dimensions.radius20)),
                    // color: Theme.of(context).scaffoldBackgroundColor
                  ),
                ),
              ]),
              Center(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: Dimensions.height10,
                  ),
                  BigText(text: widget.receievedFood!.title),
                  const SizedBox(height: 4.0),
                  Text(
                    "\$${widget.receievedFood!.price}",
                    style: const TextStyle(
                      color: Colors.green,
                      fontSize: 15.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: Dimensions.height5),

                  // ------------------- Rating Section ----------------
                  Wrap(
                      children: List.generate(
                          5,
                          (index) => Icon(
                                Icons.star,
                                color: AppColor.kSecondaryColor,
                                size: Dimensions.iconSize24,
                              ))),
                  SizedBox(
                    height: Dimensions.height10,
                  ),

                  // -------------- Bottom Icons Section ---------------s
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      const IconTextWidget(
                        icon: Icons.location_on,
                        Text: '1.7km',
                        iconColor: Colors.blue,
                      ),
                      SizedBox(width: Dimensions.width5),
                      const IconTextWidget(
                          icon: Icons.access_time_rounded,
                          Text: '32 min',
                          iconColor: AppColor.kPrimaryColor),
                      SizedBox(width: Dimensions.width5),
                    ],
                  ),
                  // ================= Popular Section End =============
                ],
              ))
            ],
          ),
        ),
      ),
    );
  }
}
