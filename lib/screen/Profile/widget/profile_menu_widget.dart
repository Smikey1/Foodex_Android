// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:foodex_app/app/utils/dimension.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

import 'package:foodex_app/app/theme/constants.dart';
import 'package:foodex_app/widgets/export_widgets.dart';

class ProfileMenuWidget extends StatelessWidget {
  const ProfileMenuWidget({
    Key? key,
    required this.title,
    required this.icon,
    this.iconColor = AppColor.kPrimaryColor,
    this.bgColor = AppColor.kPrimaryColor,
    this.endIcon = true,
    this.textColor,
  }) : super(key: key);
  final String title;
  final IconData icon;
  final Color iconColor;
  final Color bgColor;
  final bool endIcon;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Container(
        width: Dimensions.width20 * 2,
        height: Dimensions.height20 * 2,
        decoration: BoxDecoration(
            color: bgColor == bgColor.withOpacity(0.1)
                ? bgColor.withOpacity(0.1)
                : bgColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(Dimensions.radius10)),
        child: Icon(
          icon,
          color: iconColor == AppColor.kPrimaryColor
              ? AppColor.kPrimaryColor
              : iconColor,
          size: Dimensions.iconSize20,
        ),
      ),
      title: SmallText(
        text: title,
        size: Dimensions.font15,
        color: textColor ?? Theme.of(context).colorScheme.onPrimary,
      ),
      trailing: endIcon
          ? Container(
              height: Dimensions.height30,
              width: Dimensions.width30,
              decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(Dimensions.radius50 * 2)),
              child: Icon(
                LineAwesomeIcons.angle_right,
                color: Colors.grey,
                size: Dimensions.iconSize20,
              ),
            )
          : null,
    );
  }
}
