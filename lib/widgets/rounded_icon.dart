import 'package:flutter/material.dart';
import 'package:foodex_app/app/utils/dimension.dart';

class RoundIcon extends StatelessWidget {
  const RoundIcon({Key? key, required this.imageUrl}) : super(key: key);
  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        width: Dimensions.width30,
        height: Dimensions.height30,
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Theme.of(context).scaffoldBackgroundColor,
            boxShadow: const [
              BoxShadow(
                  color: Colors.black26, offset: Offset(0, 2), blurRadius: 0.6)
            ],
            image: DecorationImage(image: NetworkImage(imageUrl))),
      ),
    );
  }
}
