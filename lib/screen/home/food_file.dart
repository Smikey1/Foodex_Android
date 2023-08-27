import 'package:flutter/material.dart';
import 'package:foodex_app/app/constraints/permissions.dart';
import 'package:foodex_app/app/theme/constants.dart';
import 'package:foodex_app/app/utils/dimension.dart';
import 'package:foodex_app/model/food.dart';
import 'package:foodex_app/repository/remote_repository/remote_food_repository.dart';
import 'package:foodex_app/response/food_response.dart';
import 'package:foodex_app/screen/food/our_menu.dart';
import 'package:foodex_app/widgets/big_text.dart';
import 'package:foodex_app/widgets/icon_text.dart';
import 'package:foodex_app/widgets/small_text.dart';

class FoodFile extends StatefulWidget {
  static String route = "HomeScreen";

  const FoodFile({super.key});

  @override
  State<FoodFile> createState() => _FoodFileState();
}

class _FoodFileState extends State<FoodFile> {
  FutureBuilder<FoodResponse?> getAllFood() {
    return FutureBuilder<FoodResponse?>(
      future: FoodRepository().getAllFood(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<Food>? foodList = snapshot.data!.data!;
          // print("The Foods: -->${foodList[0].id}");
          return ListView.builder(
            itemCount: foodList.length,
            // Widget ko meaning --> my creative design
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  // Get.toNamed(RouterHelper.getPopularFood());
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => OurFoodMenu(
                                receivedFoodId: foodList[index].id,
                                receivedFoodPrice: foodList[index].price,
                                receivedFood: foodList[index].title,
                              )));
                },
                child: Container(
                  margin: EdgeInsets.only(
                      left: Dimensions.width20,
                      right: Dimensions.width20,
                      bottom: Dimensions.height10),
                  child: Row(children: [
                    //----------------------- Image Section ------------------------
                    Container(
                      width: Dimensions.listViewImgSize,
                      height: Dimensions.listViewImgSize,
                      decoration: BoxDecoration(
                          borderRadius:
                              BorderRadius.circular(Dimensions.radius20),
                          // color: AppColor.kPrimaryColor,
                          image: DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage(
                                  foodList[index].foodPhoto.isNotEmpty
                                      ? foodList[index].foodPhoto[0]
                                      : imageUnavailable))),
                    ),

                    //------------------- Text and icon section --------------------
                    Expanded(
                      child: Container(
                        height: Dimensions.listViewTextContSize,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(Dimensions.radius20),
                              bottomRight:
                                  Radius.circular(Dimensions.radius20)),
                          // color: Theme.of(context).scaffoldBackgroundColor
                        ),
                        child: Padding(
                          padding: EdgeInsets.only(
                              left: Dimensions.width10,
                              right: Dimensions.width10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              BigText(text: foodList[index].title),
                              SizedBox(
                                height: Dimensions.height10,
                              ),
                              SmallText(text: foodList[index].description),
                              SizedBox(
                                height: Dimensions.height10,
                              ),

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

                              // -------------- Bottom Icons Section ---------------
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const IconTextWidget(
                                      icon: Icons.favorite,
                                      Text: '',
                                      iconColor: AppColor.kPrimaryColor),
                                  SizedBox(width: Dimensions.width5),
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
                          ),
                        ),
                      ),
                    ),
                  ]),
                ),
              );
            },
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
    return SingleChildScrollView(child: getAllFood());
  }
}
