import 'package:flutter/material.dart';
import 'package:foodex_app/app/theme/constants.dart';
import 'package:foodex_app/app/utils/dimension.dart';

class WearOsPressButton extends StatelessWidget {
  const WearOsPressButton({Key? key, this.press, this.textColor, required this.text})
      : super(key: key);
  final String text;
  final Function()? press;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5),
      width: size.width * 0.9,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: newElevatedButton(),
      ),
    );
  }

  Widget newElevatedButton() {
    return ElevatedButton(
      onPressed: press,
      style: ElevatedButton.styleFrom(
          backgroundColor: AppColor.kPrimaryColor,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          textStyle: TextStyle(
              letterSpacing: 1,
              color: textColor,
              // fontSize: Dimensions.font12,
              fontWeight: FontWeight.bold,
              fontFamily: 'OpenSans')),
      child: Text(
        text,
        style: TextStyle(color: textColor, fontSize: 10),
      ),
    );
  }
}
