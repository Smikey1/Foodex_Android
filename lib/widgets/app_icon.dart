// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:foodex_app/app/utils/dimension.dart';

class AppIcon extends StatelessWidget {
  final IconData icon;
  final Color backgroundColor;
  final Color iconColor;
  final double size;
  final double iconSize;
  const AppIcon(
      {Key? key,
      required this.icon,
      this.backgroundColor = Colors.white,
      this.iconColor = const Color(0xFF756d54),
      this.size = 30,
      this.iconSize = 0})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(size / 2),
          color:
              backgroundColor == Colors.white ? Colors.white : backgroundColor),
      child: Icon(icon,
          color: iconColor == Color(0xFF756d54) ? Color(0xFF756d54) : iconColor ,
          // size: iconSize,
          size: iconSize == 0 ? Dimensions.iconSize20 : iconSize),
    );
  }
}
