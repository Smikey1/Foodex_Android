import 'package:flutter/material.dart';
import 'package:foodex_app/app/constraints/api_url.dart';
import 'package:foodex_app/app/theme/constants.dart';
import 'package:foodex_app/app/utils/dimension.dart';
import 'package:foodex_app/model/export_model.dart';
import 'package:foodex_app/repository/remote_repository/export_remote_repo.dart';
import 'package:foodex_app/response/user_response.dart';
import 'package:foodex_app/widgets/export_widgets.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

class UserAddress extends StatefulWidget {
  const UserAddress({super.key});

  @override
  State<UserAddress> createState() => _UserAddressState();
}

class _UserAddressState extends State<UserAddress> {
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context).scaffoldBackgroundColor,
      elevation: Dimensions.height10 - 7,
      child: Padding(
        padding: EdgeInsets.all(Dimensions.height10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Align(
                    alignment: Alignment.centerLeft,
                    child: BigText(
                      text: "Deliver to",
                      fontWeight: FontWeight.bold,
                      size: Dimensions.font15,
                    )),
                AppIcon(
                  icon: LineAwesomeIcons.edit,
                  size: Dimensions.iconSize20,
                  iconColor: AppColor.kErrorColor,
                  backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                )
              ],
            ),
            SizedBox(
              height: Dimensions.height10,
            ),
            Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
              AppIcon(
                backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                icon: LineAwesomeIcons.map_marker,
                iconColor: AppColor.kErrorColor,
                size: Dimensions.height25,
                iconSize: Dimensions.iconSize20 + 10,
              ),
              SizedBox(
                width: Dimensions.height10,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.7,
                child: Text(
                  "$getCurrentLocation",
                  style: TextStyle(
                    fontFamily: 'OpenSans',
                    //  color: AppColor.textColor,
                    fontSize: Dimensions.font15 - 1,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ]),
            SizedBox(
              height: Dimensions.height25,
            ),
            Align(
                alignment: Alignment.centerLeft,
                child: BigText(
                  text: "Contact Info",
                  fontWeight: FontWeight.bold,
                  size: Dimensions.font15,
                )),
            SizedBox(
              height: Dimensions.height10,
            ),
            Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
              AppIcon(
                icon: LineAwesomeIcons.phone,
                backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                iconColor: AppColor.kErrorColor,
                size: Dimensions.height25,
                iconSize: Dimensions.iconSize20 + 10,
              ),
              SizedBox(
                width: Dimensions.width10,
              ),
              getUserPhone(),
              SizedBox(
                height: Dimensions.height20 + 10,
              ),
            ])
          ],
        ),
      ),
    );
  }

  FutureBuilder<UserProfileResponse?> getUserPhone() {
    return FutureBuilder<UserProfileResponse?>(
        future: UserRepository().getUserProfile(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            User? userData = snapshot.data!.data!;
            return SmallText(
              text: userData.phone!,
              size: Dimensions.font15,
            );
          } else {
            return const Align(
                alignment: Alignment.centerLeft, child: Text("Loading"));
          }
        });
  }
}
