import 'package:flutter/material.dart';

import '../app/utils/dimension.dart';

class BigText extends StatelessWidget {
  Color? color;
  final String text;
  double size;
  TextOverflow overflow;
  FontWeight? fontWeight;
  BigText({
    Key? key,
    this.color,
    required this.text,
    this.size = 0,
    this.overflow = TextOverflow.ellipsis,
    this.fontWeight = FontWeight.bold,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: 1,
      overflow: overflow,
      style: TextStyle(
        fontFamily: 'OpenSans',
        color: color,
        fontSize: size == 0 ? Dimensions.font20 : size,
        fontWeight:
            fontWeight == FontWeight.bold ? FontWeight.bold : fontWeight,
      ),
    );
  }
}
