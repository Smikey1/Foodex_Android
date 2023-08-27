// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class ProfileSkelton extends StatelessWidget {
  const ProfileSkelton({
    Key? key,
    this.width,
    this.height,
  }) : super(key: key);
  final double? height, width;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.grey.shade300,
        borderRadius: BorderRadius.circular(100),
      ),
      
    );
  }
}
