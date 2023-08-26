// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:foodex_app/app/utils/dimension.dart';

class SmallText extends StatelessWidget {
  Color? color;
  final String text;
  double size;
  SmallText({
    Key? key,
    this.color,
    required this.text,
    this.size = 0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: 1,
      style: TextStyle(
        fontFamily: 'OpenSans',
        color: color,
        fontSize: size == 0 ? Dimensions.font12 : size,
        fontWeight: FontWeight.w400,
      ),
    );
  }
}
