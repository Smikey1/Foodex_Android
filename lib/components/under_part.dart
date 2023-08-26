import 'package:flutter/material.dart';
import 'package:foodex_app/app/theme/constants.dart';
import 'package:foodex_app/app/utils/dimension.dart';

class UnderPart extends StatelessWidget {
  const UnderPart(
      {Key? key,
      required this.title,
      required this.navigatorText,
      required this.onTap})
      : super(key: key);
  final String title;
  final String navigatorText;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          title,
          style: TextStyle(
            fontFamily: 'OpenSans',
            fontSize: Dimensions.font14,
            // color: Colors.black,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(
          width: Dimensions.width10,
        ),
        InkWell(
          onTap: () {
            onTap();
          },
          child: Text(
            navigatorText,
            style: TextStyle(
                color: AppColor.kSecondaryColor,
                fontSize: Dimensions.font14,
                fontWeight: FontWeight.w700,
                fontFamily: 'OpenSans'),
          ),
        )
      ],
    );
  }
}
