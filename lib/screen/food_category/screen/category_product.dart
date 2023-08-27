// import 'package:flutter/material.dart';
// import 'package:foodex_app/app/theme/constants.dart';
// import 'package:foodex_app/app/utils/dimension.dart';
// import 'package:foodex_app/model/export_model.dart';
// import 'package:foodex_app/repository/remote_repository/export_remote_repo.dart';
// import 'package:foodex_app/response/food_response.dart';
// import 'package:foodex_app/widgets/export_widgets.dart';
// import 'package:line_awesome_flutter/line_awesome_flutter.dart';

// class CategoryProduct extends StatefulWidget {
//   const CategoryProduct({super.key});

//   @override
//   State<CategoryProduct> createState() => _CategoryProductState();
// }

// class _CategoryProductState extends State<CategoryProduct> {
//   @override
//   Widget build(BuildContext context) {
//     return getAllFood();
//   }

//   FutureBuilder<FoodResponse?> getAllFood() {
//     return FutureBuilder<FoodResponse?>(
//         future: FoodRepository().getAllFood(),
//         builder: (context, snapshot) {
//           if (snapshot.hasData) {
//             List<Food>? foodList = snapshot.data!.data!;
//             print("The Foods: -->${foodList[0].id}");
//             return ListView.builder(
//                 itemCount: foodList.length,
//                 itemBuilder: (context, index) {
//                   return Card(
//                       child: Padding(
//                     padding: const EdgeInsets.all(5.0),
//                     child: Row(
//                       // mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Padding(
//                           padding: const EdgeInsets.all(3.0),
//                           child: SizedBox(
//                             width: Dimensions.width30 * 3,
//                             height: Dimensions.height30 * 3,
//                             child: ClipRRect(
//                               borderRadius: BorderRadius.circular(
//                                   Dimensions.radius50 * 2),
//                               child: Image.network(
//                                 foodList[index].foodPhoto[0],
//                                 fit: BoxFit.cover,
//                                 width: double.maxFinite,
//                               ),
//                             ),
//                           ),
//                         ),
//                         const SizedBox(
//                           width: 10,
//                         ),
//                         Column(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             SizedBox(
//                               width: 250,
//                               child: Row(
//                                 mainAxisAlignment:
//                                     MainAxisAlignment.spaceBetween,
//                                 children: [
//                                   BigText(text: foodList[index].title),
//                                   const IconTextWidget(
//                                       icon: LineAwesomeIcons.star_struck,
//                                       Text: "  4.5",
//                                       iconColor: AppColor.kSecondaryColor)
//                                 ],
//                               ),
//                             ),
//                             const SizedBox(
//                               height: 10,
//                             ),
//                             SizedBox(
//                               width: 200,
//                               child: Text(
//                                 maxLines: 2,
//                                 foodList[index].description,
//                                 style: const TextStyle(
//                                   fontSize: 16,
//                                 ),
//                               ),
//                             ),
//                             const SizedBox(
//                               height: 10,
//                             ),
//                             SizedBox(
//                               width: 250,
//                               child: Row(
//                                 mainAxisAlignment:
//                                     MainAxisAlignment.spaceBetween,
//                                 children: [
//                                   SmallText(
//                                     text: foodList[index].price,
//                                     size: 18,
//                                     color: AppColor.kPrimaryColor,
//                                   ),
//                                   const AppIcon(
//                                     icon: LineAwesomeIcons.heart,
//                                     iconColor: AppColor.kErrorColor,
//                                   )
//                                 ],
//                               ),
//                             ),
//                           ],
//                         ),
//                       ],
//                     ),
//                   ));
//                 });
//           } else {
//             return const Center(child: CircularProgressIndicator());
//           }
//         });
//   }
// }
