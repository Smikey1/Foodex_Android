import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:foodex_app/app/theme/constants.dart';
import 'package:foodex_app/app/utils/dimension.dart';

class ProfilePasswordField extends StatefulWidget {
  const ProfilePasswordField(
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
  State<ProfilePasswordField> createState() => _ProfilePasswordFieldState();
}

class _ProfilePasswordFieldState extends State<ProfilePasswordField> {
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
        cursorColor: Theme.of(context).colorScheme.onPrimary,
        obscureText: isHidden,
        controller: widget.controller,
        keyboardType: TextInputType.visiblePassword,
        validator: widget.validator,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(vertical: Dimensions.height22),
          enabledBorder: OutlineInputBorder(
            borderSide:
                BorderSide(color: AppColor.kPrimaryColor, width: Dimensions.width2),
            borderRadius: BorderRadius.circular(Dimensions.radius30),
          ),
          filled: true,
          fillColor: Theme.of(context).scaffoldBackgroundColor,
          focusedBorder: OutlineInputBorder(
              borderSide:
                   BorderSide(color: AppColor.kSecondaryColor, width: Dimensions.width2),
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
              color: Theme.of(context).colorScheme.onPrimary,
            ),
          ),
          hintText: widget.hintText,
          hintStyle: TextStyle(
              fontFamily: 'OpenSans',
              color: Theme.of(context).colorScheme.onPrimary,
              fontSize: Dimensions.font17),
          suffixIcon: Padding(
            padding: EdgeInsets.only(right: Dimensions.height8),
            child: IconButton(
              icon: isHidden
                  ? Icon(
                      Icons.visibility_off,
                      size: Dimensions.iconSize24,
                      color: Theme.of(context).colorScheme.onPrimary,
                    )
                  : Icon(Icons.visibility,
                      size: Dimensions.iconSize24,
                      color: Theme.of(context).colorScheme.onPrimary),
              onPressed: togglePasswordVisibility,
              // color: Colors.black,
            ),
          ),
          border: InputBorder.none,
        ),
        style: TextStyle(
            fontSize: Dimensions.font17,
            color: Theme.of(context).colorScheme.onPrimary),
      ),
    );
  }

  void togglePasswordVisibility() => setState(() => isHidden = !isHidden);
}
