import 'package:flutter/material.dart';
import 'package:foodex_app/app/constraints/permissions.dart';
import 'package:foodex_app/app/utils/dimension.dart';
import 'package:foodex_app/model/export_model.dart';
import 'package:foodex_app/repository/remote_repository/export_remote_repo.dart';
import 'package:foodex_app/response/food_category_response.dart';
import 'package:foodex_app/response/food_response.dart';
import 'package:foodex_app/screen/export_screen.dart';
import 'package:foodex_app/screen/food/category/category.dart';
import 'package:foodex_app/screen/food/specialFood.dart';

import '../../widgets/export_widgets.dart';

class FoodListScreen extends StatefulWidget {
  const FoodListScreen({super.key});

  @override
  State<FoodListScreen> createState() => SLIDER();
}

class SLIDER extends State<FoodListScreen> {
  List<Food> originalFoodList = [];
  List<Food> searchedFoodList = [];
  final TextEditingController _searchController = TextEditingController();
  void _searchFood(String searchTypedText) {
    List<Food> searchResultFound = [];
    if (searchTypedText.isNotEmpty) {
      print(searchTypedText);
      searchResultFound = originalFoodList.where((food) {
        String productNameInSmallCase = food.title.toLowerCase();
        String searchTypedTextInSmallCase = searchTypedText.toLowerCase();
        return productNameInSmallCase.contains(searchTypedTextInSmallCase);
      }).toList();
    } else {
      searchResultFound = originalFoodList;
      print("The all data is:-->$searchResultFound");
    }
    setState(() {
      searchedFoodList = searchResultFound;
    });
  }

  PageController pageController = PageController(viewportFraction: 0.85);

  var _currPageValue = 0.0;
  final double _scaleFactor = 0.8;
  final double _height = Dimensions.pageViewContainer;

  @override
  void initState() {
    super.initState();
    pageController.addListener(() {
      setState(() {
        _currPageValue = pageController.page!;
      });
      // getAllFood();
    });
  }

  // @override
  // void dispose() {
  //   pageController.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // ======================== Slide Section Start ========================
        // -------------------------Title --------------------------------------
        Container(
          margin: EdgeInsets.only(left: Dimensions.width30),
          alignment: Alignment.topLeft,
          child: BigText(text: "Our Specials"),
        ),

        SizedBox(
          height: Dimensions.height10,
        ),
        // -------------------------- Slide widget calling ---------------------

        // const FoodSlider(),
        //
        SingleChildScrollView(child: getSpecialFood()),
        SizedBox(
          height: Dimensions.height10,
        ),
        // ============================ Slider Section End =====================

        // ======================== Catagories Section Start ===================
        // ------------------------- Title -------------------------------------
        Container(
          margin: EdgeInsets.only(left: Dimensions.width30),
          alignment: Alignment.topLeft,
          child: BigText(text: "Catagories"),
        ),
        SizedBox(
          height: Dimensions.height10,
        ),
        // ----------------------- Catagories Widget Called --------------------
        getMyCategory(),

        SizedBox(
          height: Dimensions.height10,
        ),
        // ======================== Catagories Section End =====================

        // ====================== Popular Section Start ========================
        // ------------------------ Title --------------------------------------
        Container(
          margin: EdgeInsets.only(left: Dimensions.width30),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              BigText(text: "Our Menu"),
              SizedBox(
                width: Dimensions.width10,
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 3),
                child: BigText(
                  text: '.',
                  // color: Colors.black26,
                ),
              ),
              SizedBox(
                width: Dimensions.width10,
              ),
              // ------------------------ Sub Title ----------------------------
              Container(
                margin: const EdgeInsets.only(bottom: 2),
                child: SmallText(text: "Food pairing"),
              ),
              SizedBox(
                width: Dimensions.width10,
              )
            ],
          ),
        ),
        //-------------------- List of Food and Images -------------------------
        const SingleChildScrollView(child: FoodFile()),
      ],
    );
  }

//============================= Popular Section End ============================

// ======================== SLIDER Widget SECTION ==============================

  FutureBuilder<FoodResponse?> getSpecialFood() {
    return FutureBuilder<FoodResponse?>(
      future: FoodRepository().getAllFood(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<Food>? foodList = snapshot.data!.data!;
          print("The Foods: -->${foodList[0].id}");

          return Container(
            height: Dimensions.pageView,
            color: Theme.of(context).scaffoldBackgroundColor,
            child: PageView.builder(
                controller: pageController,
                itemCount: foodList.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                      onTap: () {
                        // Get.toNamed(RouterHelper.getSpecialFood());
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => SpecialFoodDetails(
                                      receivedFoodId: foodList[index].id,
                                      receivedFoodPrice: foodList[index].price,
                                      receivedFoodName: foodList[index].title,
                                    )));
                      },
                      child: _buildPageItem(index, foodList));
                }),
          );
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  Widget _buildPageItem(int index, foodList) {
    // ------------------- logic to for customize sliding ----------------------
    Matrix4 matrix = Matrix4.identity();
    if (index == _currPageValue.floor()) {
      var currScale = 1 - (_currPageValue - index) * (1 - _scaleFactor);
      var currTrans = _height * (1 - currScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, currTrans, 0);
    } else if (index == _currPageValue.floor() + 1) {
      var currScale =
          _scaleFactor + (_currPageValue - index + 1) * (1 - _scaleFactor);
      var currTrans = _height * (1 - currScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1);
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, currTrans, 0);
    } else if (index == _currPageValue.floor() - 1) {
      var currScale = 1 - (_currPageValue - index) * (1 - _scaleFactor);
      var currTrans = _height * (1 - currScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1);
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, currTrans, 0);
    } else {
      var currScale = 0.8;
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, _height * (1 - _scaleFactor) / 2, 1);
    }

    // ----------------------------- Slider ------------------------------------
    return Transform(
      transform: matrix,
      child: Stack(
        children: [
          // ------------------------ Image Section ----------------------------
          Container(
            height: Dimensions.pageViewContainer,
            margin: EdgeInsets.only(
                left: Dimensions.width10, right: Dimensions.width10),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(Dimensions.radius30),
                color: Theme.of(context).scaffoldBackgroundColor,
                image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(foodList[index].foodPhoto.isNotEmpty
                        ? foodList[index].foodPhoto[0]
                        : imageUnavailable))),
          ),

          // ------------------------- Text and Icon Container Section -------------------
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: Dimensions.pageViewTextContainer,
              margin: EdgeInsets.only(
                  left: Dimensions.width30,
                  right: Dimensions.width30,
                  bottom: Dimensions.height30),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(Dimensions.radius20),
                  color: Theme.of(context).scaffoldBackgroundColor,
                  boxShadow: [
                    BoxShadow(
                        color: Colors.grey.withOpacity(0.50),
                        blurRadius: 5.0,
                        offset: const Offset(0, 5)),
                  ]),
              child: Container(
                  // color: Colors.black,
                  padding: EdgeInsets.only(
                      top: Dimensions.height15,
                      left: Dimensions.height15,
                      right: Dimensions.height15),
                  child: FoodDetail(
                    text: foodList[index].title,
                  )),
            ),
          ),
        ],
      ),
    );
  }
  // ============================ Slider Section End ===========================

  // ========================= Catagories Section Start ========================

  FutureBuilder<FoodCategoryResponse?> getMyCategory() {
    return FutureBuilder(
        future: FoodCategoryRepository().getAllFoodCategory(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<FoodCategory>? categoryList = snapshot.data!.data!;
            print("The Category: -->${categoryList[0]}");
            return SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Container(
                margin: EdgeInsets.only(
                    left: Dimensions.height5,
                    right: Dimensions.height5,
                    bottom: Dimensions.height5),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      vertical: Dimensions.height15,
                      horizontal: Dimensions.height5),
                  child: Row(
                    children: [
                      for (int index = 0; index < categoryList.length; index++)
                        GestureDetector(
                          onTap: () {
                            // Get.toNamed(RouterHelper.getCategoryFood());
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => FoodCategoryScreen(
                                          recievedCategoryId:
                                              categoryList[index].id!,
                                          recievedFoodCategoryTitle:
                                              categoryList[index]
                                                  .foodCategoryTitle,
                                        )));
                          },
                          child: Stack(
                            children: [
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: Dimensions.height5),
                                child: Container(
                                  width: 130,
                                  height: 130,
                                  padding: EdgeInsets.all(Dimensions.height8),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(
                                          Dimensions.radius10),
                                      image: DecorationImage(
                                          fit: BoxFit.cover,
                                          image: NetworkImage(
                                              categoryList[index]
                                                      .foodCategoryImageUrl
                                                      .isNotEmpty
                                                  ? categoryList[index]
                                                      .foodCategoryImageUrl
                                                  : imageUnavailable))),
                                ),
                              ),
                              Positioned(
                                  // top: 95,
                                  bottom: 0,
                                  left: Dimensions.width5,
                                  right: Dimensions.width5,
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                        bottom: 0, top: Dimensions.height5),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(
                                            Dimensions.radius10),
                                        color: Colors.black12.withOpacity(0.4),
                                      ),
                                      child: ListTile(
                                        title: Center(
                                          child: Text(
                                            categoryList[index]
                                                .foodCategoryTitle,
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: Dimensions.font20,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  )),
                            ],
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        });
  }

  // FutureBuilder<FoodCategoryResponse?> getFoodCategory() {
  //   return FutureBuilder(
  //       future: FoodCategoryRepository().getAllFoodCategory(),
  //       builder: (context, snapshot) {
  //         if (snapshot.hasData) {
  //           List<FoodCategory>? categoryList = snapshot.data!.data!;
  //           print("The Category: -->${categoryList[0]}");
  //           return SingleChildScrollView(
  //             scrollDirection: Axis.horizontal,
  //             child: GestureDetector(
  //               onTap: () {
  //                 Get.toNamed(RouterHelper.getCategoryFood());
  //               },
  //               child: Container(
  //                 margin: EdgeInsets.only(
  //                     left: Dimensions.width20,
  //                     right: Dimensions.width20,
  //                     bottom: Dimensions.height10),
  //                 child: Padding(
  //                   padding:
  //                       const EdgeInsets.symmetric(vertical: 15, horizontal: 5),
  //                   child: Row(
  //                     children: [
  //                       for (int index = 0;
  //                           index < categoryList.length;
  //                           index++)
  //                         Padding(
  //                           padding: const EdgeInsets.symmetric(horizontal: 8),
  //                           child: Container(
  //                             width: Dimensions.width100,
  //                             height: Dimensions.height100,
  //                             padding: const EdgeInsets.all(8),
  //                             decoration: BoxDecoration(
  //                                 color: Colors.white,
  //                                 borderRadius: BorderRadius.circular(10),
  //                                 image: DecorationImage(
  //                                     fit: BoxFit.cover,
  //                                     image: NetworkImage(categoryList[index]
  //                                             .foodCategoryImageUrl
  //                                             .isNotEmpty
  //                                         ? categoryList[index]
  //                                             .foodCategoryImageUrl
  //                                         : imageUnavailable))),
  //                           ),
  //                         ),
  //                     ],
  //                   ),
  //                 ),
  //               ),
  //             ),
  //           );
  //         } else {
  //           return const Center(child: CircularProgressIndicator());
  //         }
  //       });
  // }

  // =========================== Catagories Section End ========================
}
