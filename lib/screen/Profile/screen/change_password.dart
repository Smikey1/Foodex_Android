import 'package:flutter/material.dart';
import 'package:foodex_app/app/utils/dimension.dart';
import 'package:foodex_app/repository/remote_repository/export_remote_repo.dart';
import 'package:foodex_app/screen/login_register/loginScreen.dart';
import 'package:foodex_app/screen/profile/widget/password_field.dart';
import 'package:foodex_app/widgets/export_widgets.dart';
import 'package:foodex_app/widgets/snack_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _oldPasswordController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 10, right: 10),
          child: Container(
            padding: EdgeInsets.only(top: Dimensions.height30 / 2),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  // crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: AppIcon(
                          backgroundColor:
                              Theme.of(context).scaffoldBackgroundColor,
                          icon: Icons.arrow_back_ios,
                          iconColor: Theme.of(context).colorScheme.onPrimary,
                          // size: Dimensions.iconSize20,
                        )),
                    Container(
                      // padding: EdgeInsets.only(top: Dimensions.height30),
                      color: Theme.of(context).scaffoldBackgroundColor,
                      child: Text(
                        'Change Password',
                        style: TextStyle(
                          // color: Colors.white,
                          fontSize: Dimensions.font20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    // const SizedBox(
                    //   width: ,
                    // ),
                    Container(
                      // padding: EdgeInsets.only(top: Dimensions.height30),
                      color: Theme.of(context).scaffoldBackgroundColor,
                      child: Center(
                        child: Text(
                          'Hell',
                          style: TextStyle(
                            color: Theme.of(context).scaffoldBackgroundColor,
                            fontSize: Dimensions.font26,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const Divider(),
                SizedBox(
                  height: Dimensions.height20,
                ),
                Container(
                  width: 100,
                  height: 100,
                  padding: EdgeInsets.only(left: Dimensions.width20),
                  alignment: Alignment.centerLeft,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(
                            "https://assets8.lottiefiles.com/packages/lf20_qj1esxnx.json")),
                  ),
                ),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      ProfilePasswordField(
                        controller: _oldPasswordController,
                        hintText: 'Enter your old password',
                        onChanged: (value) {},
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Field must be filled';
                          }
                          if (value.trim().length < 8) {
                            return 'Password must be at least 8 characters in length';
                          }
                          // Return null if the entered password is valid
                          return null;
                        },
                      ),
                      SizedBox(
                        height: Dimensions.height20,
                      ),
                      ProfilePasswordField(
                        controller: _newPasswordController,
                        hintText: 'Enter your new password',
                        onChanged: (value) {},
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Field must be filled';
                          }
                          if (value.trim().length < 8) {
                            return 'Password must be at least 8 characters in length';
                          }
                          // Return null if the entered password is valid
                          return null;
                        },
                      ),
                      SizedBox(
                        height: Dimensions.height20,
                      ),
                      ProfilePasswordField(
                        controller: _confirmPasswordController,
                        hintText: 'Re-Enter the new password',
                        onChanged: (value) {},
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Field must be filled';
                          }
                          if (value.trim().length < 8) {
                            return 'Password must be at least 8 characters in length';
                          }
                          if (value != _newPasswordController.text) {
                            return 'Password does not match';
                          }
                          // Return null if the entered password is valid
                          return null;
                        },
                      ),
                      SizedBox(
                        height: Dimensions.height20,
                      ),
                      PressButton(
                          text: 'Change Password',
                          press: () async {
                            if (_formKey.currentState!.validate()) {
                              if (_confirmPasswordController.text ==
                                  _newPasswordController.text) {
                                final result = await UserRepository()
                                    .changePassword(_oldPasswordController.text,
                                        _newPasswordController.text);
                                if (result) {
                                  // Success Login
                                  showSnackbar(
                                      context,
                                      "Password Changed Successfully!",
                                      Colors.green);
                                  doLogout();
                                } else {
                                  // Login Failed
                                  showSnackbar(context, "Invalid Old Password!",
                                      Colors.red);
                                }
                              }
                            }
                          })
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    ));
  }

  void doLogout() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    showSnackbar(context, "Logout Successfully!", Colors.orange);
    pref.clear();
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (_) => const LoginScreen(),
      ),
    );
  }
}
