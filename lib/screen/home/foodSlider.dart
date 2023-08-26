// import 'package:flutter/material.dart';
// import 'package:foodex_app/app/router/routes.dart';
// import 'package:foodex_app/app/utils/dimension.dart';
// import 'package:foodex_app/model/export_model.dart';
// import 'package:foodex_app/repository/remote_repository/remote_food_repository.dart';
// import 'package:foodex_app/response/food_response.dart';
// import 'package:foodex_app/widgets/export_widgets.dart';
// import 'package:get/get.dart';

// class FoodSlider extends StatefulWidget {
//   const FoodSlider({super.key});

//   @override
//   State<FoodSlider> createState() => _FoodSliderState();
// }

// class _FoodSliderState extends State<FoodSlider> {
//   PageController pageController = PageController(viewportFraction: 0.85);

//   final _currPageValue = 0.0;
//   final double _scaleFactor = 0.8;
//   final double _height = Dimensions.pageViewContainer;

//   FutureBuilder<FoodResponse?> getSpecialFood() {
//     return FutureBuilder<FoodResponse?>(
//       future: FoodRepository().getAllFood(),
//       builder: (context, snapshot) {
//         if (snapshot.hasData) {
//           List<Food>? foodList = snapshot.data!.data!;
//           print("The Foods: -->${foodList[0].id}");

//           return Container(
//             height: Dimensions.pageView,
//             color: Theme.of(context).scaffoldBackgroundColor,
//             child: GestureDetector(
//               onTap: () {
//                 Get.toNamed(RouterHelper.getSpecialFood());
//                 // Navigator.push(
//                 //     context,
//                 //     MaterialPageRoute(
//                 //         builder: (_) => SpecialFoodDetails(
//                 //             receivedFoodId: foodList[index].id,
//                 //             receivedFoodPrice: foodList[index].price)));
//               },
//               child: PageView.builder(
//                   controller: pageController,
//                   itemCount: foodList.length,
//                   itemBuilder: (context, position) {
//                     return _buildPageItem(position, foodList);
//                   }),
//             ),
//           );
//         } else {
//           return const Center(child: CircularProgressIndicator());
//         }
//       },
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return SingleChildScrollView(child: getSpecialFood());
//   }

//   // ======================== SLIDER Widget SECTION ==============================
//   Widget _buildPageItem(int index, foodList) {
//     // ------------------- logic to for customize sliding ----------------------
//     Matrix4 matrix = Matrix4.identity();
//     if (index == _currPageValue.floor()) {
//       var currScale = 1 - (_currPageValue - index) * (1 - _scaleFactor);
//       var currTrans = _height * (1 - currScale) / 2;
//       matrix = Matrix4.diagonal3Values(1, currScale, 1)
//         ..setTranslationRaw(0, currTrans, 0);
//     } else if (index == _currPageValue.floor() + 1) {
//       var currScale =
//           _scaleFactor + (_currPageValue - index + 1) * (1 - _scaleFactor);
//       var currTrans = _height * (1 - currScale) / 2;
//       matrix = Matrix4.diagonal3Values(1, currScale, 1);
//       matrix = Matrix4.diagonal3Values(1, currScale, 1)
//         ..setTranslationRaw(0, currTrans, 0);
//     } else if (index == _currPageValue.floor() - 1) {
//       var currScale = 1 - (_currPageValue - index) * (1 - _scaleFactor);
//       var currTrans = _height * (1 - currScale) / 2;
//       matrix = Matrix4.diagonal3Values(1, currScale, 1);
//       matrix = Matrix4.diagonal3Values(1, currScale, 1)
//         ..setTranslationRaw(0, currTrans, 0);
//     } else {
//       var currScale = 0.8;
//       matrix = Matrix4.diagonal3Values(1, currScale, 1)
//         ..setTranslationRaw(0, _height * (1 - _scaleFactor) / 2, 1);
//     }

//     // ----------------------------- Slider ------------------------------------
//     return Transform(
//       transform: matrix,
//       child: Stack(
//         children: [
//           // ------------------------ Image Section ----------------------------
//           Container(
//             height: Dimensions.pageViewContainer,
//             margin: EdgeInsets.only(
//                 left: Dimensions.width10, right: Dimensions.width10),
//             decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(Dimensions.radius30),
//                 color: Theme.of(context).scaffoldBackgroundColor,
//                 image: const DecorationImage(
//                     fit: BoxFit.cover,
//                     image: AssetImage("assets/images/momo.jpg"))),
//           ),

//           // ------------------------- Text and Icon Container Section -------------------
//           Align(
//             alignment: Alignment.bottomCenter,
//             child: Container(
//               height: Dimensions.pageViewTextContainer,
//               margin: EdgeInsets.only(
//                   left: Dimensions.width30,
//                   right: Dimensions.width30,
//                   bottom: Dimensions.height30),
//               decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(Dimensions.radius20),
//                   color: Theme.of(context).scaffoldBackgroundColor,
//                   boxShadow: [
//                     BoxShadow(
//                         color: Colors.grey.withOpacity(0.50),
//                         blurRadius: 5.0,
//                         offset: const Offset(0, 5)),
//                     // BoxShadow(
//                     //     color: Colors.white,
//                     //     // blurRadius: 5.0,
//                     //     offset: Offset(-5, 0)),
//                     // BoxShadow(
//                     //     color: Colors.white,
//                     //     // blurRadius: 5.0,
//                     //     offset: Offset(5, 0)),
//                   ]),
//               child: Container(
//                   // color: Colors.black,
//                   padding: EdgeInsets.only(
//                       top: Dimensions.height15, left: 15, right: 15),
//                   child: FoodDetail(
//                     text: foodList[index].title,
//                   )),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//   // ============================ Slider Section End ===========================
// }
