import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:foodex_app/app/utils/dimension.dart';

import '../app/theme/constants.dart';

class PasswordField extends StatefulWidget {
  const PasswordField(
      {Key? key,
      this.hintText,
      this.onChanged,
      this.validator,
      this.inputFormatter,
      this.errorText,
      this.controller})
      : super(key: key);

  final String? hintText;
  final Function(String?)? onChanged;
  final String? Function(String?)? validator;
  final List<TextInputFormatter>? inputFormatter;
  final String? errorText;
  final controller;

  @override
  State<PasswordField> createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {
  final TextEditingController controller = TextEditingController();
  bool isHidden = true;
  bool success = false;

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
        obscureText: isHidden,
        controller: widget.controller,
        keyboardType: TextInputType.visiblePassword,
        validator: (value) {
          if (value == null || value.trim().isEmpty) {
            return 'Enter valid password';
          }
          if (value.trim().length < 8) {
            return 'Password must be at least 8 characters in length';
          }
          // Return null if the entered password is valid
          return null;
        },
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(vertical: Dimensions.height22),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: AppColor.bgFillColor, width: 2),
            borderRadius: BorderRadius.circular(Dimensions.radius30),
          ),
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
              borderRadius:
                  BorderRadius.all(Radius.circular(Dimensions.radius30))),
          prefixIcon: Padding(
            padding: EdgeInsets.only(left: Dimensions.height8),
            child: Icon(
              size: Dimensions.iconSize24,
              Icons.lock,
              color: Colors.black,
            ),
          ),
          hintText: 'password',
          hintStyle: const TextStyle(
              fontFamily: 'OpenSans', color: AppColor.textColor),
          suffixIcon: Padding(
            padding: EdgeInsets.only(right: Dimensions.height8),
            child: IconButton(
              icon: isHidden
                  ? Icon(
                      Icons.visibility_off,
                      size: Dimensions.iconSize24,
                      color: AppColor.textColor,
                    )
                  : Icon(Icons.visibility,
                      size: Dimensions.iconSize24, color: AppColor.textColor),
              onPressed: togglePasswordVisibility,
              // color: Colors.black,
            ),
          ),
          border: InputBorder.none,
        ),
        style:
            TextStyle(fontSize: Dimensions.font17, color: AppColor.textColor),
      ),
    );
  }

  void togglePasswordVisibility() => setState(() => isHidden = !isHidden);
}
