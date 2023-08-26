import 'package:flutter/material.dart';
import 'package:foodex_app/components/export_component.dart';
import 'package:foodex_app/model/export_model.dart';
import 'package:foodex_app/repository/remote_repository/remote_user_repository.dart';
import 'package:foodex_app/app/utils/dimension.dart';
import 'package:foodex_app/widgets/export_widgets.dart';
import 'package:foodex_app/widgets/snack_bar.dart';

import '../export_screen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  // ----------------------- Global key & Controller ---------------------------
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController(text: 'karma@gmail.com');
  final _phoneController = TextEditingController(text: '9808792437');
  final _passwordController = TextEditingController(text: 'password123');
  final _fullNameController = TextEditingController(text: 'Karma Gurung');
  final _dobController = TextEditingController();
  final _avatarController = TextEditingController();

  // ------------------------- User data save Function in Object Box-------------------------
  // _saveUser() async {
  //   User user = User(_emailController.text, int.parse(_phoneController.text),
  //       _passwordController.text);

  //   int status = await UserRepositoryImplementation().addUser(user);
  //   _showMessage(status);
  // }

  // ------------------ Motion toast for success or fail -----------------------
  // _showMessage(int status) {
  //   if (status > 0) {
  //     MotionToast.success(
  //       description: const Text('Successfully Register'),
  //       onClose: () {
  //         Navigator.of(context).push(
  //           MaterialPageRoute(
  //             builder: (_) => const VerificationScreen(),
  //           ),
  //         );
  //       },
  //     ).show(context);
  //   } else {
  //     MotionToast.error(description: const Text('Fail to register'))
  //         .show(context);
  //   }
  // }

  // ------------------------ Register using API ------------------------------
  _registerUser(User user) async {
    final isNewUserRegistered = await UserRepository().registerUser(user);
    if (isNewUserRegistered == true) {
      // register
      showSnackbar(context, "Register Successfully!", Colors.green);
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => const LoginScreen()));
    } else {
      // register
      showSnackbar(context, "Invalid Credentials!", Colors.red);
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
          body: Container(
        width: size.width,
        height: size.height,
        color: Theme.of(context).colorScheme.background,
        child: SingleChildScrollView(
          child: Stack(children: [
            const Upside(
                imgUrl:
                    "https://res.cloudinary.com/dymp3ozdm/image/upload/v1675927077/foodex/Logo/login_logo_iqivu4.png"),
            const PageTitleBar(
              title: 'Sign Up',
            ),
            Padding(
              padding: EdgeInsets.only(top: Dimensions.height300),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Please register to get started",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        // color: Colors.black,
                        fontFamily: 'OpenSans',
                        fontSize: Dimensions.font17,
                        fontWeight: FontWeight.normal),
                  ),
                  SizedBox(
                    height: Dimensions.height15,
                  ),
                  Form(
                      autovalidateMode: AutovalidateMode.always,
                      key: _formKey,
                      child: Column(
                        children: [
                          UserInputField(
                            controller: _fullNameController,
                            hintText: 'Enter your Full Name',
                            prefixIcon: Icons.email,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Enter your Full Name';
                              }
                              return null;
                            },
                          ),
                          SizedBox(
                            height: Dimensions.height15,
                          ),
                          UserInputField(
                            controller: _emailController,
                            hintText: 'Enter your Email',
                            prefixIcon: Icons.email,
                            validator: (value) {
                              if (value!.isEmpty ||
                                  !RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w]{2,4}')
                                      .hasMatch(value)) {
                                return 'Enter your email';
                              }
                              return null;
                            },
                          ),
                          SizedBox(
                            height: Dimensions.height15,
                          ),
                          UserInputField(
                            controller: _phoneController,
                            hintText: 'Enter your Phone number',
                            prefixIcon: Icons.phone,
                            validator: (value) {
                              if (value!.isEmpty ||
                                  !RegExp(r'^[0-9]{10}$').hasMatch(value)) {
                                return 'Enter your phone number';
                              }
                              return null;
                            },
                          ),
                          SizedBox(
                            height: Dimensions.height15,
                          ),
                          PasswordField(
                            controller: _passwordController,
                          ),
                          // switchListTile(),
                          SizedBox(
                            height: Dimensions.height8,
                          ),
                          PressButton(
                            text: 'Sign up',
                            press: () {
                              if (_formKey.currentState!.validate()) {
                                // _saveUser();
                                final User user = User(
                                  _fullNameController.text,
                                  _emailController.text,
                                  _dobController.text,
                                  _phoneController.text,
                                  _passwordController.text,
                                  _avatarController.text,
                                );
                                _registerUser(user);
                              }
                            },
                          ),
                          SizedBox(height: Dimensions.height10),
                          Text(
                            "Or",
                            style: TextStyle(
                                // color: Colors.black,
                                fontFamily: 'OpenSans',
                                fontSize: Dimensions.font15,
                                fontWeight: FontWeight.w600),
                          ),
                          SizedBox(height: Dimensions.height10),
                          iconButton(context),
                          SizedBox(
                            height: Dimensions.height20,
                          ),
                          UnderPart(
                              title: "Already have account?",
                              navigatorText: "Log in",
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const LoginScreen()));
                              }),
                          SizedBox(
                            height: Dimensions.height40,
                          ),
                        ],
                      ))
                ],
              ),
            )
          ]),
        ),
      )),
    );
  }
}

// iconButton(BuildContext context) {
//   return Row(
//     mainAxisAlignment: MainAxisAlignment.center,
//     children: const [
//       RoundIcon(imageUrl: "assets/icons/facebook.png"),
//       SizedBox(
//         width: 20,
//       ),
//       RoundIcon(imageUrl: "assets/icons/google.png"),
//       SizedBox(
//         width: 20,
//       ),
//     ],
//   );
// }
