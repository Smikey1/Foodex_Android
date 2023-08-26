import 'package:flutter/material.dart';
import 'package:foodex_app/app/theme/constants.dart';
import 'package:foodex_app/app/utils/dimension.dart';

class UserInputField extends StatefulWidget {
  const UserInputField({
    Key? key,
    this.hintText,
    // this.icon = Icons.person,
    this.prefixIcon,
    this.validator,
    this.errorText,
    this.controller,
  }) : super(key: key);
  final String? hintText;
  final IconData? prefixIcon;
  final String? Function(String?)? validator;
  final String? errorText;
  final controller;

  @override
  State<UserInputField> createState() => _UserInputFieldState();
}

class _UserInputFieldState extends State<UserInputField> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width * 0.8,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(Dimensions.radius30),
      ),
      child: TextFormField(
        cursorColor: Colors.black12,
        validator: widget.validator,
        controller: widget.controller,
        decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(vertical: Dimensions.height22),
            hintText: widget.hintText,
            hintStyle: const TextStyle(
                fontFamily: 'OpenSans', color: AppColor.textColor),
            enabledBorder: OutlineInputBorder(
                borderSide:
                    const BorderSide(color: AppColor.bgFillColor, width: 2),
                borderRadius: BorderRadius.circular(Dimensions.radius30)),
            filled: true,
            fillColor: AppColor.bgFillColor,
            focusedBorder: OutlineInputBorder(
                borderSide:
                    const BorderSide(color: AppColor.kPrimaryColor, width: 2),
                borderRadius: BorderRadius.circular(Dimensions.radius30)),
            errorText: widget.validator != null ? null : widget.errorText,
            errorStyle: TextStyle(fontSize: Dimensions.font14),
            errorBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.red),
                borderRadius:
                    BorderRadius.all(Radius.circular(Dimensions.radius30))),
            focusedErrorBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.red),
                borderRadius: BorderRadius.circular(Dimensions.radius30)),
            prefixIcon: null == widget.prefixIcon
                ? null
                : Padding(
                    padding: EdgeInsets.only(left: Dimensions.height8),
                    child: Icon(
                        size: Dimensions.iconSize24,
                        widget.prefixIcon,
                        color: AppColor.textColor
                        // size:Dimensions.icon20,
                        ),
                  ),
            border: InputBorder.none),
            style: TextStyle(fontSize: Dimensions.font17, color: AppColor.textColor),
      ),
    );
  }
}
