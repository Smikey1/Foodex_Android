import 'package:flutter/material.dart';
import 'package:foodex_app/app/theme/constants.dart';
import 'package:foodex_app/app/utils/dimension.dart';
import 'package:foodex_app/widgets/export_widgets.dart';

class ProfileInfoWidget extends StatefulWidget {
  const ProfileInfoWidget({
    Key? key,
    required this.title,
    required this.icon,
    this.iconColor = AppColor.kPrimaryColor,
    this.hintText,
  }) : super(key: key);
  final IconData icon;
  final Color iconColor;
  final String? title;
  final String? hintText;

  @override
  State<ProfileInfoWidget> createState() => _ProfileInfoWidgetState();
}

class _ProfileInfoWidgetState extends State<ProfileInfoWidget> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Container(
        width: Dimensions.width20 * 2,
        height: Dimensions.height20 * 2,
        decoration: BoxDecoration(
            // color: Colors.greenAccent,
            borderRadius: BorderRadius.circular(Dimensions.radius10)),
        child: Icon(widget.icon,
            color: widget.iconColor == AppColor.kPrimaryColor
                ? AppColor.kPrimaryColor
                : widget.iconColor,
            size: Dimensions.iconSize24 + 2),
      ),
      title: SmallText(
        text: widget.title!,
        size: Dimensions.font14,
        color: Theme.of(context).colorScheme.onPrimary,
      ),
      subtitle: BigText(
        text: widget.hintText!,
        size: Dimensions.font17 + 1,
        fontWeight: FontWeight.w500,
        color: Theme.of(context).colorScheme.onPrimary,
      ),
    );
  }
}
