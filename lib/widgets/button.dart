import 'package:flutter/material.dart';
import 'package:foodex_app/app/theme/constants.dart';
import 'package:foodex_app/app/utils/dimension.dart';

class PressButton extends StatelessWidget {
  const PressButton({Key? key, this.press, this.textColor, required this.text})
      : super(key: key);
  final String text;
  final Function()? press;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.symmetric(vertical: Dimensions.height10),
      width: size.width * 0.8,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(Dimensions.radius30),
        child: newElevatedButton(),
      ),
    );
  }

  Widget newElevatedButton() {
    return ElevatedButton(
      onPressed: press,
      style: ElevatedButton.styleFrom(
          backgroundColor: AppColor.kPrimaryColor,
          padding: EdgeInsets.symmetric(
              horizontal: Dimensions.height40, vertical: Dimensions.height20),
          textStyle: TextStyle(
              letterSpacing: Dimensions.space2,
              color: textColor,
              // fontSize: Dimensions.font12,
              fontWeight: FontWeight.bold,
              fontFamily: 'OpenSans')),
      child: Text(
        text,
        style: TextStyle(color: Colors.white, fontSize: Dimensions.font20),
      ),
    );
  }
}
