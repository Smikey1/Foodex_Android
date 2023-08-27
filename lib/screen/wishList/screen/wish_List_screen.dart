import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:foodex_app/app/constraints/permissions.dart';
import 'package:foodex_app/app/utils/dimension.dart';
import 'package:foodex_app/data/remote_data_source/api/export_remote_data.dart';
import 'package:foodex_app/model/export_model.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

class MyWishlistScreen extends StatefulWidget {
  const MyWishlistScreen({super.key});

  @override
  State<MyWishlistScreen> createState() => _MyWishlistScreenState();
}

class _MyWishlistScreenState extends State<MyWishlistScreen> {
  bool isFromHomePage = true;
  bool isAddedToCart = false;

  Future<bool> addToWishlist(String productId) async {
    final isAdded = await UserAPI().addToWishlist(productId);
    return isAdded;
  }

  FutureBuilder<List<Food>?> getAllWishlistProduct() {
    return FutureBuilder<List<Food>?>(
      future: UserAPI().getUserWishlistProduct(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(
            child: NoItemInWishlist(),
          );
        } else {
          List<dynamic> productList = snapshot.data!;
          return ListView.builder(
            itemCount: productList.length,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                margin: EdgeInsets.all(Dimensions.height10),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.inversePrimary,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: ListTile(
                    contentPadding: const EdgeInsets.only(left: 7),
                    leading: Container(
                      width: Dimensions.height30 * 2,
                      height: Dimensions.height30 * 3,
                      decoration: BoxDecoration(
                        color: Theme.of(context).highlightColor,
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(
                              productList[index].image[0].isNotEmpty
                                  ? productList[index].image[0]
                                  : imageUnavailable),
                        ),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10)),
                      ),
                    ),
                    title: Text(
                      productList[index].name,
                      style: TextStyle(
                        fontFamily: "Satoshi Medium",
                        fontSize: Dimensions.font17,
                      ),
                    ),
                    subtitle: Text(
                      productList[index].description,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                        fontFamily: "Satoshi Medium",
                        fontSize: Dimensions.font12,
                      ),
                    ),
                    trailing: IconButton(
                      onPressed: () async {
                        if (isFromHomePage) {
                          bool data =
                              await addToWishlist(productList[index].productId);
                          if (data == true) {
                            print(
                                "${productList[index].name} removed from fav");
                          }
                        }
                        setState(() {});
                      },
                      icon: isFromHomePage == true
                          ? const Icon(Icons.favorite)
                          : const Icon(LineAwesomeIcons.heart),
                      iconSize: Dimensions.height20,
                    )),
              );
            },
          );
        }
      },
    );
  }

  @override
  void initState() {
    getAllWishlistProduct();
    super.initState();
  }

  @override
  void dispose() {
    getAllWishlistProduct();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: buildAppBar(context),
        body: Column(
          children: [Expanded(child: getAllWishlistProduct())],
        ));
  }
}

AppBar buildAppBar(BuildContext context) {
  return AppBar(
    elevation: 0,
    backgroundColor: Theme.of(context).colorScheme.inversePrimary,
    title: Text(
      "My Wishlist",
      style: TextStyle(
        color: Theme.of(context).colorScheme.primary,
        fontFamily: "Satoshi Regular",
        fontSize: Dimensions.font17,
      ),
    ),
    centerTitle: true,
    leading: IconButton(
      icon: SvgPicture.asset(
        'assets/icons/back.svg',
        color: Theme.of(context).colorScheme.primary,
      ),
      onPressed: () => Navigator.pop(context),
    ),
    actions: <Widget>[
      IconButton(
        icon: SvgPicture.asset(
          "assets/icons/cart.svg",
          color: Theme.of(context).colorScheme.primary,
        ),
        onPressed: () {
          // Navigator.of(context).pushReplacement(
          //   MaterialPageRoute(
          //     builder: (_) => const CartNavScreen(),
          //   ),
          // );
        },
      ),
      SizedBox(width: Dimensions.height20)
    ],
  );
}

class NoItemInWishlist extends StatelessWidget {
  const NoItemInWishlist({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(Dimensions.height10),
        child: Container(
          padding: EdgeInsets.all(Dimensions.height10),
          child: Column(children: [
            Icon(
              LineAwesomeIcons.heart,
              size: Dimensions.font30 * 2,
            ),
            SizedBox(
              height: Dimensions.height15,
            ),
            Text(
              "YOU DO NOT HAVE A WISHLIST",
              style: TextStyle(
                color: Theme.of(context).colorScheme.primary,
                fontFamily: "Satoshi Black",
                fontSize: Dimensions.font17,
              ),
            ),
            SizedBox(
              height: Dimensions.height15,
            ),
            Align(
              alignment: Alignment.center,
              child: Text(
                "Once you create a wishlist, you will be able to share it with friends and access it via fodjeans.com",
                style: TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                  fontFamily: "Satoshi Regular",
                  fontSize: Dimensions.font14,
                ),
              ),
            ),
            SizedBox(
              height: Dimensions.height10,
            ),
            Text(
              "Browse product selection to start your wishlist",
              style: TextStyle(
                color: Theme.of(context).colorScheme.primary,
                fontFamily: "Satoshi Regular",
                fontSize: Dimensions.font14,
              ),
            ),
            SizedBox(
              height: Dimensions.height10,
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                  onPressed: () {
                    // Navigator.of(context).pushReplacement(MaterialPageRoute(
                    //   builder: (context) => const ShopScreen(),
                    // ));
                  },
                  child: Text(
                    "Start Wishlist",
                    style: TextStyle(
                      fontFamily: "Satoshi Regular",
                      fontSize: Dimensions.font15,
                    ),
                  )),
            )
          ]),
        ),
      ),
    );
  }
}
