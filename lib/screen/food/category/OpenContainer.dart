import 'package:flutter/material.dart';
import 'package:animations/animations.dart';

import 'package:foodex_app/model/export_model.dart';

class OpenContainerWrapper extends StatelessWidget {
  const OpenContainerWrapper(
      {Key? key, required this.child, required this.food})
      : super(key: key);

  final Widget child;
  final Food food;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
      child: OpenContainer(
        closedShape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
        ),
        transitionType: ContainerTransitionType.fade,
        transitionDuration: const Duration(milliseconds: 900),
        closedBuilder: (BuildContext context, VoidCallback openContainer) {
          return InkWell(
            onTap: openContainer,
            child: child,
          );
        },
        openBuilder: (BuildContext context, VoidCallback _) {
          return Container(
            color: Colors.white,
            child: Center(
              child: Text(food.title),
            ),
          );
        },
      ),
    );
  }
}
