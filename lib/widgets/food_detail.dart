// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:foodex_app/app/utils/dimension.dart';
import 'package:foodex_app/app/theme/constants.dart';
import 'package:foodex_app/widgets/export_widgets.dart';

class FoodDetail extends StatelessWidget {
  final String text;
  const FoodDetail({
    Key? key,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,

        // ---------------------- Food Title -----------------------
        children: [
          BigText(
            text: text,
            size: Dimensions.font26,
          ),
          SizedBox(height: Dimensions.height10),

          // -------------- Rating & comments Section ----------------
          Row(
            children: [
              Wrap(
                  children: List.generate(
                      5,
                      (index) => Icon(
                            Icons.star,
                            color: AppColor.kSecondaryColor,
                            size: Dimensions.iconSize24,
                          ))),
              SizedBox(
                width: Dimensions.width10,
              ),
              SmallText(text: '4.5', size: Dimensions.font14),
              SizedBox(
                width: Dimensions.width25,
              ),
              SmallText(
                text: '1275',
                size: Dimensions.font14,
              ),
              SizedBox(
                width: Dimensions.width5,
              ),
              // SmallText(text: 'comments'),
              Icon(
                Icons.comment,
                color: AppColor.kSecondaryColor,
                size: Dimensions.iconSize16,
              )
            ],
          ),
          SizedBox(
            height: Dimensions.height20,
          ),

          // ----------------- Bottom Icons Section ----------------
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              IconTextWidget(
                  icon: Icons.favorite,
                  Text: 'Favorite',
                  iconColor: AppColor.kErrorColor),
              IconTextWidget(
                icon: Icons.location_on,
                Text: '1.7km',
                iconColor: AppColor.kSecondaryColor,
              ),
              IconTextWidget(
                  icon: Icons.access_time_rounded,
                  Text: '32 min',
                  iconColor: AppColor.kSecondaryColor),
            ],
          ),
          // SizedBox(
          //   height: Dimensions.height10,
          // )
        ]);
  }
}
