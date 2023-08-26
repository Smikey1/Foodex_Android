// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:foodex_app/widgets/small_text.dart';

import '../app/utils/dimension.dart';

class IconTextWidget extends StatelessWidget {
  final IconData icon;
  final String Text;
  final Color iconColor;

  const IconTextWidget({
    Key? key,
    required this.icon,
    required this.Text,
    required this.iconColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          color: iconColor,
          size: Dimensions.iconSize20,
        ),
        // const SizedBox(
        //   width: 5,
        // ),
        SmallText(
          text: Text,
          size: Dimensions.font17,
        )
      ],
    );
  }
}
