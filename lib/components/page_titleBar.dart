import 'package:flutter/material.dart';
import 'package:foodex_app/app/utils/dimension.dart';

class PageTitleBar extends StatelessWidget {
  const PageTitleBar({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: Dimensions.height225),
      child: Container(
        width: double.infinity,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
            color: Theme.of(context).scaffoldBackgroundColor,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(Dimensions.radius50),
              topRight: Radius.circular(Dimensions.radius50),
            )),
        child: Padding(
          padding: EdgeInsets.only(top: Dimensions.height15),
          child: Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'OpenSans',
              fontSize: Dimensions.font30,
              letterSpacing: Dimensions.space2,
              fontWeight: FontWeight.bold,
              // color: AppColor.kContentColorLightTheme,
            ),
          ),
        ),
      ),
    );
  }
}
