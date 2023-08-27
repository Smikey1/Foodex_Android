import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:foodex_app/app/theme/constants.dart';
import 'package:foodex_app/app/utils/dimension.dart';
import 'package:foodex_app/app/utils/notification.dart';
import 'package:foodex_app/components/export_component.dart';
import 'package:foodex_app/home_button.dart';
import 'package:foodex_app/repository/local_repository/local_user_repo.dart';
import 'package:foodex_app/repository/remote_repository/remote_user_repository.dart';
import 'package:foodex_app/widgets/export_widgets.dart';
import 'package:foodex_app/widgets/snack_bar.dart';
import 'package:local_auth/local_auth.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../export_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool authenticated = false;
  //FingerPrint setup
  final LocalAuthentication auth = LocalAuthentication();
  bool? _canCheckBiometric;

  List<BiometricType>? _availableBiometrics;
  String authorized = "Not authorized";

  Future<void> _checkBiometric() async {
    bool? canCheckBiometric;
    try {
      canCheckBiometric = await auth.canCheckBiometrics;
      bool canAuthenticateWithBiometrics = await auth.canCheckBiometrics;
      bool canAuthenticate =
          canAuthenticateWithBiometrics || await auth.isDeviceSupported();
    } on PlatformException catch (e) {
      print(e);
    }
    if (!mounted) return;

    setState(() {
      _canCheckBiometric = canCheckBiometric;
    });
  }

  Future<void> _getAvailableBiometrics() async {
    List<BiometricType>? availableBiometric;

    final List<BiometricType> availableBiometrics =
        await auth.getAvailableBiometrics();
    try {
      availableBiometric = await auth.getAvailableBiometrics();
    } on PlatformException catch (e) {
      print(e);
    }
    setState(() {
      _availableBiometrics = availableBiometric;
    });
  }

  // for authentication purpose
  Future<void> _authenticate() async {
    bool authenticated = false;
    try {
      authenticated = await auth.authenticate(
        localizedReason: "Scan your finger to authenticate",
        options: const AuthenticationOptions(
          useErrorDialogs: true,
          stickyAuth: false,
        ),
      );
    } on PlatformException catch (e) {
      print(e);
    }
    if (!mounted) return;
    setState(() async {
      authorized =
          authenticated ? "Authorization Successful" : "Failed to authenticate";

      if (authenticated) {
        SharedPreferences pref = await SharedPreferences.getInstance();
        String? val = pref.getString("token");
        // // ignore: use_build_context_synchronously
        // Navigator.pushReplacementNamed(context, HomePage.route);

        if (val != null) {
          // ignore: use_build_context_synchronously
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (_) => const DashboardButton(),
            ),
          );
          AwesomeNotifications().createNotification(
            content: NotificationContent(
              id: 1,
              channelKey: 'basic_channel',
              title: "Logged In",
              body: "You are now logged in to your account!",
            ),
          );
        } else if (val == null) {
          // ignore: use_build_context_synchronously
          return MotionToast.error(
            description: const Text(
                "Sorry No Token Found, Login Using your Credentials!"),
          ).show(context);
        }
      }
      print(authorized);
    });
  }

  //------------- Notification
  @override
  void initState() {
    super.initState();
    AwesomeNotifications().isNotificationAllowed().then((isAllowed) {
      if (!isAllowed) {
        AwesomeNotifications().requestPermissionToSendNotifications();
      }
    });
  }

  // _checkNotification() {
  //   AwesomeNotifications().isNotificationAllowed().then((isAllowed) {
  //     if (!isAllowed) {
  //       AwesomeNotifications().requestPermissionToSendNotifications();
  //     }
  //   });
  // }

  // ----------------------- Global key & Controller ---------------------------
  final _formKey = GlobalKey<FormState>();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();

  // ------------------------- Login Function with Object Box ------------------
  _loginUserWithObjectBox() async {
    String phoneNumber = _phoneController.text;
    String password = _passwordController.text;

    bool? isLogin =
        await UserRepositoryImplementation().loginUser(phoneNumber, password);
    _showMessage(isLogin!);
  }

  // ------------------ Motion toast for success or fail -----------------------
  _showMessage(bool checkLogin) {
    checkLogin == true
        ? MotionToast.success(
            description: const Text('Successfully Login'),
            onClose: () {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (_) => const DashboardButton(),
                ),
              );
            },
          ).show(context)
        : MotionToast.error(description: const Text('Fail to Login'))
            .show(context);
  }

  // -------------------------- Login using API --------------------------------
  _loginUserWithAPI(String phoneNumber, String password) async {
    final isNewUserLogin =
        await UserRepository().loginUser(phoneNumber, password);
    // _showMessage(isNewUserLogin!);

    if (isNewUserLogin == true) {
      MyNotification.showNotification(
          notificationTitle: "Login Success",
          notificationMessage: "Login Successfully");
      // Success Login
      showSnackbar(context, "Login Success!", Colors.green);

      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => const DashboardButton()));
    } else {
      // Login Failed
      showSnackbar(context, "Invalid Credentials!", Colors.red);
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        body: SafeArea(
            child: Container(
                width: size.width,
                height: size.height,
                color: Theme.of(context).scaffoldBackgroundColor,
                child: SingleChildScrollView(
                    child: Stack(children: [
                  const Upside(
                      imgUrl:
                          "https://res.cloudinary.com/dymp3ozdm/image/upload/v1675927077/foodex/Logo/login_logo_iqivu4.png"),
                  const PageTitleBar(
                    title: 'Welcome',
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: Dimensions.height300),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "Please Login with your account to continue",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              // color: Colors.black,
                              fontFamily: 'OpenSans',
                              fontSize: Dimensions.font17,
                              fontWeight: FontWeight.normal),
                        ),
                        SizedBox(
                          height: Dimensions.height20,
                        ),
                        Form(
                            autovalidateMode: AutovalidateMode.always,
                            key: _formKey,
                            child: Column(
                              children: [
                                // --------------- Phone number Field --------------
                                UserInputField(
                                  key: const ValueKey("phoneNumberKey"),
                                  controller: _phoneController,
                                  hintText: 'Enter Phone number',
                                  prefixIcon: Icons.person,
                                  validator: (value) {
                                    if (value!.isEmpty ||
                                        !RegExp(r'^[0-9]{10}$')
                                            .hasMatch(value)) {
                                      return 'Enter valid phone number';
                                    }
                                    return null;
                                  },
                                ),
                                SizedBox(
                                  height: Dimensions.height20,
                                ),
                                // ------------------- Password Field --------------
                                PasswordField(
                                  key: const ValueKey("passwordKey"),
                                  controller: _passwordController,
                                ),
                                SizedBox(
                                  height: Dimensions.height20,
                                ),
                                // ------------------ Forget Password --------------
                                Padding(
                                  padding: EdgeInsets.only(
                                      right: Dimensions.height45),
                                  child: Align(
                                    alignment: Alignment.centerRight,
                                    child: Text(
                                      'Forgot password?',
                                      style: TextStyle(
                                          color: AppColor.kSecondaryColor,
                                          fontFamily: 'OpenSans',
                                          fontWeight: FontWeight.w600,
                                          fontSize: Dimensions.font15),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: Dimensions.height20,
                                ),

                                // -------------------- Login Button ---------------
                                PressButton(
                                  // key: const ValueKey("btnLogin"),
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
                                // ---------------- Google & Facebook Icon ---------
                                TextButton(
                                    onPressed: () {
                                      _authenticate();
                                    },
                                    child: Text(
                                      "Login Fingerprint",
                                      style: TextStyle(
                                          fontSize: Dimensions.font17),
                                    )),
                                // iconButton(context),
                                // -------------------------------------------------
                                SizedBox(
                                  height: Dimensions.height20,
                                ),
                                // ----------------- New User (sign up) ------------
                                UnderPart(
                                    title: "Don't have an account?",
                                    navigatorText: "Sign Up",
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const SignUpScreen()));
                                    }),
                                SizedBox(
                                  height: Dimensions.height30,
                                ),
                              ],
                            ))
                      ],
                    ),
                  ),
                ])))));
  }
}

// ------------------ Facebook and Google Icon Button --------------------------
iconButton(BuildContext context) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      const RoundIcon(
        imageUrl:
            "https://res.cloudinary.com/dymp3ozdm/image/upload/v1675927443/foodex/Logo/facebook_if8pl7.png",
      ),
      SizedBox(
        width: Dimensions.width10,
      ),
      const RoundIcon(
          imageUrl:
              "https://res.cloudinary.com/dymp3ozdm/image/upload/v1675927649/foodex/Logo/google1_wmwaem.png"),
      // SizedBox(
      //   width: 20,
      // ),
    ],
  );
}
