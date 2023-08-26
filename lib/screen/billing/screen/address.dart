import 'package:flutter/material.dart';
import 'package:foodex_app/app/theme/constants.dart';
import 'package:foodex_app/app/utils/dimension.dart';
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
      elevation: Dimensions.height10,
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
            Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
              AppIcon(
                  icon: Icons.location_on_outlined,
                  size: Dimensions.iconSize16 - 3),
              SizedBox(
                width: Dimensions.height10,
              ),
              SmallText(
                text: "Softwarica College, Kathmandu, Nepal",
                size: Dimensions.font15,
              ),
            ]),
            SizedBox(
              height: Dimensions.height25,
            ),
            Align(
                alignment: Alignment.centerLeft,
                child: BigText(
                  text: "Deliver at",
                  fontWeight: FontWeight.bold,
                  size: Dimensions.font15,
                )),
            SizedBox(
              height: Dimensions.height10,
            ),
            Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
              AppIcon(
                  icon: LineAwesomeIcons.clock,
                  size: Dimensions.iconSize16 - 3),
              SizedBox(
                width: Dimensions.width10,
              ),
              SmallText(
                text: "12:00 PM - 12:30 PM",
                size: Dimensions.font15,
              ),
              SizedBox(
                width: Dimensions.width10,
              ),
              SmallText(
                text: "Today, Feb 21",
                size: Dimensions.font15,
              ),
              SizedBox(
                height: Dimensions.height20,
              ),
            ])
          ],
        ),
      ),
    );
  }
}
