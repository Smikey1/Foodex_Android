import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:foodex_app/app/theme/constants.dart';

class WearOsPasswordField extends StatefulWidget {
  const WearOsPasswordField(
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
  State<WearOsPasswordField> createState() => _WearOsPasswordFieldState();
}

class _WearOsPasswordFieldState extends State<WearOsPasswordField> {
  final TextEditingController controller = TextEditingController();
  bool isHidden = true;
  bool success = false;

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
          contentPadding: const EdgeInsets.symmetric(vertical: 10),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: AppColor.bgFillColor, width: 1),
            borderRadius: BorderRadius.circular(10),
          ),
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
          focusedErrorBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.red),
              borderRadius: BorderRadius.all(Radius.circular(10))),
          prefixIcon: const Padding(
            padding: EdgeInsets.only(left: 2),
            child: Icon(
              size: 14,
              Icons.lock,
              color: Colors.black,
            ),
          ),
          hintText: 'password',
          hintStyle: const TextStyle(
              fontFamily: 'OpenSans', color: AppColor.textColor),
          suffixIcon: Padding(
            padding: const EdgeInsets.only(right: 2),
            child: IconButton(
              icon: isHidden
                  ? const Icon(
                      Icons.visibility_off,
                      size: 14,
                      color: AppColor.textColor,
                    )
                  : const Icon(Icons.visibility,
                      size: 14, color: AppColor.textColor),
              onPressed: togglePasswordVisibility,
              // color: Colors.black,
            ),
          ),
          border: InputBorder.none,
        ),
        style: const TextStyle(fontSize: 14, color: AppColor.textColor),
      ),
    );
  }

  void togglePasswordVisibility() => setState(() => isHidden = !isHidden);
}
