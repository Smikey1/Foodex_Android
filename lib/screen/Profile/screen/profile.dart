import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:foodex_app/app/theme/constants.dart';
import 'package:foodex_app/app/utils/dimension.dart';
import 'package:foodex_app/model/export_model.dart';
import 'package:foodex_app/repository/remote_repository/remote_user_repository.dart';
import 'package:foodex_app/response/user_response.dart';
import 'package:foodex_app/screen/profile/screen/change_password.dart';
import 'package:foodex_app/screen/profile/screen/profile_info.dart';
import 'package:foodex_app/screen/export_screen.dart';
import 'package:foodex_app/screen/profile/screen/update_profile.dart';
import 'package:foodex_app/widgets/export_widgets.dart';
import 'package:foodex_app/widgets/snack_bar.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileScreen extends StatefulWidget {
  // final String userId;
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    var isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;
    return Scaffold(
        body: Container(
      padding: EdgeInsets.all(Dimensions.height10),
      child: Column(children: [
        Container(
          padding: EdgeInsets.only(top: Dimensions.height30),
          color: Theme.of(context).scaffoldBackgroundColor,
          child: Center(
            child: Text(
              'My Profile',
              style: TextStyle(
                // color: Colors.white,
                fontSize: Dimensions.font26,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        const Divider(),
        Expanded(
          child: SingleChildScrollView(
              child: Column(
            children: [
              getUserProfile(isDark),
              // SizedBox(height: Dimensions.height20),
              SizedBox(
                width: Dimensions.width100 * 2,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const UpdateProfileScreen()));
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: AppColor.kSecondaryColor,
                      side: BorderSide.none,
                      shape: const StadiumBorder()),
                  child: const Text('Edit Profile'),
                ),
              ),
              SizedBox(height: Dimensions.height20),
              const Divider(),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ProfileInfoScreen()));
                },
                child: const ProfileMenuWidget(
                  title: "Profile",
                  icon: LineAwesomeIcons.user_circle,
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ChangePasswordScreen()));
                },
                child: const ProfileMenuWidget(
                  title: "Change Password",
                  // bgColor: AppColor.bgFillColor,
                  icon: LineAwesomeIcons.lock,
                  endIcon: true,
                ),
              ),
              const ProfileMenuWidget(
                title: "Address",
                icon: LineAwesomeIcons.map_marker,
              ),
              const ProfileMenuWidget(
                title: "favorite",
                bgColor: AppColor.kErrorColor,
                iconColor: AppColor.kErrorColor,
                icon: LineAwesomeIcons.heart,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const OrderScreen()));
                },
                child: const ProfileMenuWidget(
                  title: "Order History",
                  // iconColor: AppColor.kErrorColor,
                  icon: LineAwesomeIcons.history,
                ),
              ),
              ProfileMenuWidget(
                title: "Dark Mode",
                iconColor: isDark ? Colors.white : Colors.black,
                icon: isDark ? LineAwesomeIcons.sun : LineAwesomeIcons.moon,
                endIcon: false,
              ),
              const Divider(),
              GestureDetector(
                onTap: () async {
                  showAlertDialog(context);
                },
                child: const ProfileMenuWidget(
                  title: "Logout",
                  bgColor: AppColor.kErrorColor,
                  icon: LineAwesomeIcons.alternate_sign_out,
                  iconColor: AppColor.kErrorColor,
                  textColor: Colors.red,
                  endIcon: false,
                ),
              ),
            ],
          )),
        ),
      ]),
    ));
  }

  FutureBuilder<UserProfileResponse?> getUserProfile(isDark) {
    return FutureBuilder<UserProfileResponse?>(
        future: UserRepository().getUserProfile(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            User? userData = snapshot.data!.data!;

            return Column(
              children: [
                Stack(
                  children: [
                    SizedBox(
                      width: Dimensions.width30 * 4,
                      height: Dimensions.height40 * 3,
                      child: ClipRRect(
                        borderRadius:
                            BorderRadius.circular(Dimensions.radius50 * 2),
                        child: Image.network(
                          userData.avatar!,
                          fit: BoxFit.cover,
                          width: double.maxFinite,
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Container(
                        height: Dimensions.height35,
                        width: Dimensions.width35,
                        decoration: BoxDecoration(
                            color: AppColor.kSecondaryColor,
                            borderRadius:
                                BorderRadius.circular(Dimensions.radius50 * 2)),
                        child: Icon(
                          LineAwesomeIcons.alternate_pencil,
                          color: Colors.black,
                          size: Dimensions.iconSize20,
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(height: Dimensions.height20),
                BigText(
                  text: userData.fullName!,
                  size: Dimensions.font20,
                ),
                SmallText(
                  text: userData.email!,
                  size: Dimensions.font15,
                ),
                SizedBox(height: Dimensions.height20),
              ],
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        });
  }

  void showAlertDialog(BuildContext context) {
    AwesomeDialog(
      context: context,
      dialogType: DialogType.WARNING,
      animType: AnimType.TOPSLIDE,
      showCloseIcon: true,
      title: "Log Out",
      desc: "Are you sure you want to log out?",
      autoHide: const Duration(seconds: 3),
      btnCancelOnPress: () {
        Navigator.of(context).pop();
        // Navigator.of(context).pushReplacement(
        //   MaterialPageRoute(
        //     builder: (_) => const ProfileScreen(),
        //   ),
        // );
      },
      btnOkOnPress: () async {
        SharedPreferences pref = await SharedPreferences.getInstance();
        showSnackbar(context, "Logout Successfully!", Colors.orange);
        pref.clear();
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (_) => const LoginScreen(),
          ),
        );
      },
    ).show();
  }
}
