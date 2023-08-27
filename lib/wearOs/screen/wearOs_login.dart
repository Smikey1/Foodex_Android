import 'package:flutter/material.dart';
import 'package:foodex_app/repository/remote_repository/export_remote_repo.dart';
import 'package:foodex_app/wearOs/screen/wearOs_dashboard.dart';

import 'package:foodex_app/wearOs/widget/wearOs_button.dart';
import 'package:foodex_app/wearOs/widget/wearOs_input_field.dart';
import 'package:foodex_app/wearOs/widget/wearOs_password_field.dart';
import 'package:foodex_app/wearOs/widget/wearOs_snackbar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wear/wear.dart';

class WearOsLogin extends StatefulWidget {
  const WearOsLogin({super.key});

  @override
  State<WearOsLogin> createState() => _WearOsLoginState();
}

class _WearOsLoginState extends State<WearOsLogin> {
  final _formKey = GlobalKey<FormState>();
  final _phoneController = TextEditingController(text: '9808792437');
  final _passwordController = TextEditingController(text: 'password123');

  _setDataToSharedPre(int phoneNumber, String password) async {
    try {
      final SharedPreferences pref = await SharedPreferences.getInstance();
      await pref.setInt('my_username', phoneNumber);
      await pref.setString('my_password', password);
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  _loginUserWithAPI(String phoneNumber, String password) async {
    final isNewUserLogin =
        await UserRepository().loginUser(phoneNumber, password);
    // _showMessage(isNewUserLogin!);

    if (isNewUserLogin == true) {
      // Success Login
      // WearOsMyNotification.showNotification(
      //     notificationTitle: "Login Success",
      //     notificationMessage: "Login Successfully");
      wearOsShowSnackbar(
        context,
        "Login Success!",
        Colors.green,
      );
      _setDataToSharedPre(
          int.parse(_phoneController.text), _passwordController.text);
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => const WearOsDashboard()));
    } else {
      // Login Failed
      wearOsShowSnackbar(context, "Invalid Credentials!", Colors.red);
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return WatchShape(
      builder: (BuildContext context, WearShape shape, Widget? child) {
        return AmbientMode(builder: (context, mode, child) {
          return Scaffold(
              body: SafeArea(
            child: Container(
              width: size.width,
              height: size.height,
              color: Theme.of(context).scaffoldBackgroundColor,
              child: SingleChildScrollView(
                child: Stack(children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text(
                        "Welcome",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            // color: Colors.black,
                            fontFamily: 'OpenSans',
                            fontSize: 17,
                            fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      const Text(
                        "Please Login with your account to continue",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            // color: Colors.black,
                            fontFamily: 'OpenSans',
                            fontSize: 10,
                            fontWeight: FontWeight.normal),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Form(
                          autovalidateMode: AutovalidateMode.always,
                          key: _formKey,
                          child: Column(
                            children: [
                              // --------------- Phone number Field --------------
                              WearOsUserInputField(
                                controller: _phoneController,
                                hintText: 'Enter Phone number',
                                prefixIcon: Icons.person,
                                validator: (value) {
                                  if (value!.isEmpty ||
                                      !RegExp(r'^[0-9]{10}$').hasMatch(value)) {
                                    return 'Enter valid phone number';
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              // ------------------- Password Field --------------
                              WearOsPasswordField(
                                controller: _passwordController,
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              // -------------------- Login Button ---------------
                              WearOsPressButton(
                                text: 'login',
                                press: () {
                                  if (_formKey.currentState!.validate()) {
                                    // _loginUserWithObjectBox();
                                    _loginUserWithAPI(_phoneController.text,
                                        _passwordController.text);
                                  }
                                },
                              ),
                              // -------------------------------------------------
                              const SizedBox(height: 10),
                              // ----------------- New User (sign up) ------------
                            ],
                          ))
                    ],
                  )
                ]),
              ),
            ),
          ));
        });
      },
    );
  }
}
