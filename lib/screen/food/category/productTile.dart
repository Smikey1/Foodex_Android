// import 'package:flutter/material.dart';
// import 'package:foodex_app/model/export_model.dart';
// import 'package:foodex_app/repository/remote_repository/export_remote_repo.dart';
// import 'package:foodex_app/repository/remote_repository/remote_food_repository.dart';

// class ProductTile extends StatefulWidget {
//   final Food food;

//   const ProductTile(this.food, {super.key});

//   @override
//   State<ProductTile> createState() => _ProductTileState();
// }

// class _ProductTileState extends State<ProductTile> {
//   final _foodRepo = FoodRepository();
//   bool isFromHomePage = false;

//   // Future<bool> addToWishlist(String userId, String productId) async {
//   //   final isAdded = await UserRepository().addToWishlist(userId, productId);
//   //   return isAdded;
//   // }

//   // @override
//   // void initState() {
//   //   for (Food p1 in loggedInUserWishlist!) {
//   //     if (p1.productId == widget.product.productId) {
//   //       isFromHomePage = true;
//   //     }
//   //   }
//   //   super.initState();
//   // }

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 11),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Stack(
//             children: [
//               Container(
//                 height: 180,
//                 constraints: const BoxConstraints(maxWidth: double.infinity),
//                 width: double.infinity,
//                 clipBehavior: Clip.antiAlias,
//                 decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(10),
//                     boxShadow: const [
//                       BoxShadow(
//                           color: Color.fromARGB(255, 255, 255, 255),
//                           spreadRadius: 2,
//                           blurRadius: 10,
//                           offset: Offset(0, 1))
//                     ]),
//                 child: Image.network(
//                   widget.food.foodPhoto[0],
//                   fit: BoxFit.cover,
//                 ),
//               ),
//               Positioned(
//                 right: 0,
//                 child: CircleAvatar(
//                   backgroundColor: Colors.white,
//                   child: IconButton(
//                     color: Colors.red,
//                     icon: isFromHomePage == true
//                         ? const Icon(Icons.favorite_rounded)
//                         : const Icon(Icons.favorite_border),
//                     onPressed: () async {},
//                   ),
//                 ),
//               )
//             ],
//           ),
//           const SizedBox(height: 8),
//           Text(
//             widget.food.title,
//             maxLines: 1,
//             style: const TextStyle(
//                 fontFamily: 'avenir',
//                 fontWeight: FontWeight.w500,
//                 fontSize: 16,
//                 color: Colors.green),
//             overflow: TextOverflow.ellipsis,
//           ),
//           const SizedBox(height: 3),
//           Row(
//             children: [
//               // if (5 != null)
//               // if (product.rating != null)
//               Container(
//                 decoration: const BoxDecoration(
//                   color: Colors.white,
//                 ),
//                 padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 1),
//                 child: Row(
//                   // mainAxisSize: MainAxisSize.min,
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   crossAxisAlignment: CrossAxisAlignment.end,
//                   children: [
//                     Center(
//                       child: Text('Rs.${widget.food.price}',
//                           style: const TextStyle(
//                               fontSize: 16,
//                               fontFamily: 'avenir',
//                               fontWeight: FontWeight.w700,
//                               color: Colors.green)),
//                     ),
//                     const SizedBox(width: 50),
//                     const Icon(
//                       Icons.star,
//                       size: 24,
//                       color: Colors.yellow,
//                     ),
//                     const Text(
//                       "4.5",
//                       style: TextStyle(color: Colors.green),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           )
//         ],
//       ),
//     );
//   }
// }
