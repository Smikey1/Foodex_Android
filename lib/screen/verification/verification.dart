import 'dart:async';

import 'package:flutter/material.dart';
import 'package:foodex_app/app/theme/constants.dart';
import 'package:flutter_verification_code/flutter_verification_code.dart';
import 'package:foodex_app/dashboard_button.dart';
import 'package:foodex_app/home_button.dart';

class VerificationScreen extends StatefulWidget {
  const VerificationScreen({Key? key}) : super(key: key);

  @override
  State<VerificationScreen> createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> {
  bool _isResendAgain = false;
  bool _isVerified = false;
  bool _isLoading = false;

  String _code = '';

  late Timer _timer;
  int _start = 60;
  final int _currentIndex = 0;

// Resend otp code to user

  void resend() {
    setState(() {
      _isResendAgain = true;
    });

    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(oneSec, (timer) {
      setState(() {
        if (_start == 0) {
          _start = 60;
          _isResendAgain = false;
          timer.cancel();
        } else {
          _start--;
        }
      });
    });
  }

  verify() {
    setState(() {
      _isLoading = true;
      Navigator.of(context).push(MaterialPageRoute(
        builder: (_) => const DashboardButton(),
      ));
    });

    const oneSec = Duration(milliseconds: 1000);
    _timer = Timer.periodic(oneSec, (timer) {
      setState(() {
        _isLoading = false;
        _isVerified = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.kPrimaryColor,
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          height: MediaQuery.of(context).size.height,
          width: double.infinity,
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 200,
                  height: 200,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.grey.shade200,
                  ),
                  child: Transform.rotate(
                    angle: 38,
                    child: const Image(
                        image: AssetImage('assets/images/email.png')),
                  ),
                ),
                const SizedBox(
                  height: 80,
                ),
                const Text(
                  "Verification",
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 30,
                ),
                Text(
                  "Please enter the digit code sent to \n +977-9807969978",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 16, color: Colors.grey.shade500, height: 1.5),
                ),
                const SizedBox(height: 30),
                VerificationCode(
                  length: 6,
                  textStyle: const TextStyle(fontSize: 20, color: Colors.black),
                  underlineColor: Colors.black,
                  keyboardType: TextInputType.number,
                  underlineUnfocusedColor: Colors.black,
                  onCompleted: (value) {
                    setState(() {
                      _code = value;
                    });
                  },
                  onEditing: (value) {},
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Don't recieve the OTP?",
                      style:
                          TextStyle(fontSize: 14, color: Colors.grey.shade500),
                    ),
                    TextButton(
                        onPressed: () {
                          if (_isResendAgain) return;
                          resend();
                        },
                        child: Text(
                          _isResendAgain ? "Try again in $_start" : 'Resend',
                          style:
                              const TextStyle(color: AppColor.kSecondaryColor),
                        ))
                  ],
                ),
                const SizedBox(
                  height: 50,
                ),
                MaterialButton(
                  disabledColor: AppColor.kPrimaryColor,
                  onPressed: _code.length < 6
                      ? null
                      : () {
                          verify();
                        },
                  color: AppColor.kPrimaryColor,
                  minWidth: double.infinity,
                  height: 50,
                  child: _isLoading
                      ? const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(
                            backgroundColor: Colors.black,
                            strokeWidth: 3,
                            color: Colors.white,
                          ))
                      : _isVerified
                          ? const Icon(
                              Icons.check_circle,
                              color: AppColor.kSecondaryColor,
                              size: 30,
                            )
                          : const Text(
                              "Verify",
                              style: TextStyle(
                                color: Colors.black,
                              ),
                            ),
                )
              ]),
        ),
      ),
    );
  }
}
