import 'package:flutter/material.dart';
import 'package:foodex_app/app/theme/constants.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

class WishListScreen extends StatefulWidget {
  const WishListScreen({super.key});

  @override
  State<WishListScreen> createState() => _WishListState();
}

class _WishListState extends State<WishListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        title: const Text("Wish List"),
        centerTitle: true,
        // backgroundColor: AppColor.kPrimaryColor,
      ),
      body: SafeArea(
        child: GridView.count(
          padding: const EdgeInsets.all(8),
          childAspectRatio: 0.6,
          crossAxisSpacing: 8,
          mainAxisSpacing: 8,
          crossAxisCount: 2,
          children: [
            for (int i = 1; i < 10; i++) ...{
              Container(
                height: 400,
                width: 100,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  // border: Border.all(color: Colors.black),
                  borderRadius: BorderRadius.circular(20),
                  color: Theme.of(context).scaffoldBackgroundColor,
                ),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image.network(
                          "https://res.cloudinary.com/dymp3ozdm/image/upload/v1677392344/Foodex/63fa9261a75f1eb559234ed41677392339993.jpg",
                          width: 250,
                          height: 200,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 10.0,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text(
                              "Pizza",
                              style: TextStyle(fontSize: 20),
                            ),
                            Text(
                              "With Most beautiful and tasty",
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 16,
                              ),
                            )
                          ],
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Rs. 100 ",
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                          Container(
                            // padding: const EdgeInsets.symmetric(
                            //     horizontal: 10, vertical: 1),
                            decoration: BoxDecoration(
                                // color: AppColor.kErrorColor.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(20)),
                            child: const Icon(
                              LineAwesomeIcons.heart,
                              color: AppColor.kErrorColor,
                            ),
                          )
                        ],
                      )
                    ]),
              ),
            }
          ],
        ),
      ),
    );
  }
}
