import 'package:flutter/material.dart';
import 'package:foodex_app/app/theme/constants.dart';

class WearOsUserInputField extends StatefulWidget {
  const WearOsUserInputField({
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
  State<WearOsUserInputField> createState() => _WearOsUserInputFieldState();
}

class _WearOsUserInputFieldState extends State<WearOsUserInputField> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width * 0.9,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextFormField(
        cursorColor: Colors.black12,
        validator: widget.validator,
        controller: widget.controller,
        decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(vertical: 10),
            hintText: widget.hintText,
            hintStyle: const TextStyle(
                fontFamily: 'OpenSans', color: AppColor.textColor),
            enabledBorder: OutlineInputBorder(
                borderSide:
                    const BorderSide(color: AppColor.bgFillColor, width: 1),
                borderRadius: BorderRadius.circular(10)),
            filled: true,
            fillColor: AppColor.bgFillColor,
            focusedBorder: OutlineInputBorder(
                borderSide:
                    const BorderSide(color: AppColor.kPrimaryColor, width: 1),
                borderRadius: BorderRadius.circular(10)),
            errorText: widget.validator != null ? null : widget.errorText,
            errorStyle: const TextStyle(fontSize: 5),
            errorBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.red),
                borderRadius: BorderRadius.all(Radius.circular(10))),
            focusedErrorBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.red),
                borderRadius: BorderRadius.circular(10)),
            prefixIcon: null == widget.prefixIcon
                ? null
                : Padding(
                    padding: const EdgeInsets.only(left: 2),
                    child: Icon(
                        size: 14, widget.prefixIcon, color: AppColor.textColor
                        // size:Dimensions.icon20,
                        ),
                  ),
            border: InputBorder.none),
        style: const TextStyle(fontSize: 14, color: AppColor.textColor),
      ),
    );
  }
}
