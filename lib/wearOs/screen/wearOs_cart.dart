import 'package:flutter/material.dart';

class WearOsCartScreen extends StatefulWidget {
  const WearOsCartScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<WearOsCartScreen> createState() => WearOsCartScreenState();
}

class WearOsCartScreenState extends State<WearOsCartScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child:
                Container(child: const Text("You have 3 item in your cart"))));
  }
}
