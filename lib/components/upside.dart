import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodex_app/app/theme/constants.dart';

class Upside extends StatelessWidget {
  const Upside({Key? key, required this.imgUrl}) : super(key: key);
  final String imgUrl;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Stack(
      children: [
        Container(
          width: size.width,
          // height: size.height,
          color: AppColor.kPrimaryColor,
          child: Padding(
              padding: const EdgeInsets.only(),
              child: Image(
                image: NetworkImage(imgUrl),
                fit: BoxFit.cover,
              )),
        ),
        // iconBackButton(context),
      ],
    );
  }
}

// iconBackButton(BuildContext context) {
//   return IconButton(
//     color: Colors.black,
//     iconSize: 28,
//     icon: const Icon(CupertinoIcons.arrow_left),
//     onPressed: () {
//       Navigator.pop(context);
//     },
//   );
// }
