import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:foodex_app/app/theme/constants.dart';
import 'package:foodex_app/app/utils/dimension.dart';
import 'package:foodex_app/model/export_model.dart';
import 'package:foodex_app/repository/remote_repository/export_remote_repo.dart';
import 'package:foodex_app/response/user_response.dart';
import 'package:foodex_app/screen/login_register/loginScreen.dart';
import 'package:foodex_app/screen/profile/screen/update_profile.dart';
import 'package:foodex_app/screen/profile/widget/info_widegt.dart';
import 'package:foodex_app/widgets/export_widgets.dart';
import 'package:foodex_app/widgets/snack_bar.dart';

class ProfileInfoScreen extends StatefulWidget {
  const ProfileInfoScreen({super.key});

  @override
  State<ProfileInfoScreen> createState() => _ProfileInfoScreenState();
}

class _ProfileInfoScreenState extends State<ProfileInfoScreen> {
  var emptyDOB = "Add your DOB";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 10, right: 10),
          child: Container(
            padding: EdgeInsets.only(top: Dimensions.height30 / 2),

            // color: Colors.green,
            child: Column(
                // crossAxisAlignment: CrossAxisAlignment.center,
                // mainAxisSize: MainAxisSize.min,
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
                          'Profile Info',
                          style: TextStyle(
                            // color: Colors.white,
                            fontSize: Dimensions.font26,
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
                    height: Dimensions.height10,
                  ),
                  getProfileInfo(),
                  SizedBox(
                    height: Dimensions.height20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: Dimensions.width150,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const UpdateProfileScreen()));
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: AppColor.kSecondaryColor,
                              side: BorderSide.none,
                              shape: const StadiumBorder()),
                          child: const Text('Edit Profile',
                              style: TextStyle(color: Colors.white)),
                        ),
                      ),
                      SizedBox(
                        width: Dimensions.width20,
                      ),
                      SizedBox(
                        width: Dimensions.width150,
                        child: ElevatedButton(
                          onPressed: () {
                            showAlertDialog(context);
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: AppColor.kErrorColor,
                              side: BorderSide.none,
                              shape: const StadiumBorder()),
                          child: const Text(
                            'Delete Profile',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  )
                ]),
          ),
        ),
      ),
    );
  }

  FutureBuilder<UserProfileResponse?> getProfileInfo() {
    return FutureBuilder<UserProfileResponse?>(
      future: UserRepository().getUserProfile(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          User? profileInfo = snapshot.data!.data!;
          return Column(
            children: [
              SizedBox(
                width: Dimensions.width30 * 4,
                height: Dimensions.height40 * 3,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(Dimensions.radius50 * 2),
                  child: Image.network(
                    profileInfo.avatar!,
                    fit: BoxFit.cover,
                    width: double.maxFinite,
                  ),
                ),
              ),
              ProfileInfoWidget(
                icon: Icons.person,
                title: 'Name',
                hintText: profileInfo.fullName!,
              ),
              const Divider(),
              ProfileInfoWidget(
                icon: Icons.mail,
                title: 'Email',
                hintText: profileInfo.email!,
              ),
              const Divider(),
              ProfileInfoWidget(
                icon: Icons.phone,
                title: 'Phone Number',
                hintText: profileInfo.phone!,
              ),
              const Divider(),
              ProfileInfoWidget(
                icon: Icons.date_range,
                title: 'Date of Birth',
                hintText:
                    profileInfo.dob!.isNotEmpty ? profileInfo.dob! : emptyDOB,
              ),
              const Divider(),
            ],
          );
        } else if (snapshot.hasError) {
          return Text('${snapshot.error}');
        }
        return const CircularProgressIndicator();
      },
    );
  }

  void showAlertDialog(BuildContext context) {
    AwesomeDialog(
      context: context,
      dialogType: DialogType.WARNING,
      animType: AnimType.TOPSLIDE,
      showCloseIcon: true,
      title: "Delete Profile",
      desc: "Your account will be delete permanently!!",
      autoHide: const Duration(seconds: 3),
      btnCancelOnPress: () {
        Navigator.of(context).pop();
      },
      btnOkOnPress: () async {
        await UserRepository().deleteUserProfile();
        showSnackbar(context, "Account Delete Successfully", Colors.green);
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (_) => const LoginScreen(),
          ),
        );
      },
    ).show();
  }
}
