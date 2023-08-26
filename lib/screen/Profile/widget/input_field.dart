import 'package:flutter/material.dart';
import 'package:foodex_app/app/theme/constants.dart';
import 'package:foodex_app/app/utils/dimension.dart';

class InputField extends StatefulWidget {
  const InputField({
    Key? key,
    this.text,
    this.hintText,
    // this.icon = Icons.person,
    this.prefixIcon,
    this.validator,
    this.errorText,
    this.controller,
    this.readOnly = false,
    this.onTap
  }) : super(key: key);
  final String? text;
  final String? hintText;
  final IconData? prefixIcon;
  final String? Function(String?)? validator;
  final String? errorText;
  final controller;
  final bool readOnly;
  final onTap;

  @override
  State<InputField> createState() => _InputFieldState();
}

class _InputFieldState extends State<InputField> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width * 0.8,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(Dimensions.radius30),
      ),
      child: TextFormField(
        cursorColor: Theme.of(context).colorScheme.onPrimary,
        validator: widget.validator,
        controller: widget.controller,
        readOnly: widget.readOnly,
        decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(vertical: Dimensions.height22),
            hintText: widget.hintText,
            hintStyle: TextStyle(
                fontFamily: 'OpenSans',
                color: Theme.of(context).colorScheme.onPrimary),
            enabledBorder: OutlineInputBorder(
                borderSide:
                    const BorderSide(color: AppColor.kPrimaryColor, width: 2),
                borderRadius: BorderRadius.circular(Dimensions.radius30)),
            filled: true,
            fillColor: Theme.of(context).scaffoldBackgroundColor,
            focusedBorder: OutlineInputBorder(
                borderSide:
                    const BorderSide(color: AppColor.kSecondaryColor, width: 2),
                borderRadius: BorderRadius.circular(Dimensions.radius30)),
            errorText: widget.validator != null ? null : widget.errorText,
            errorStyle: TextStyle(fontSize: Dimensions.font14),
            prefixIcon: null == widget.prefixIcon
                ? null
                : Padding(
                    padding: EdgeInsets.only(left: Dimensions.height8),
                    child: Icon(
                      size: Dimensions.iconSize24,
                      widget.prefixIcon,
                      color: Theme.of(context).colorScheme.onPrimary,
                      // size:Dimensions.icon20,
                    ),
                  ),
            border: InputBorder.none),
        style: TextStyle(
            fontSize: Dimensions.font17,
            color: Theme.of(context).colorScheme.onPrimary),
        onTap: widget.onTap,
      ),
    );
  }
}
