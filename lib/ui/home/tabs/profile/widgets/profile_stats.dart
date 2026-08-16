import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:movies_app/utils/app_assets.dart';
import 'package:movies_app/utils/app_colors.dart';
import 'package:movies_app/utils/app_styles.dart';
import 'package:movies_app/utils/size_utils.dart';

class ProfileStats extends StatelessWidget {
  const ProfileStats({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: context.width * 0.045,
        right: context.width * 0.045,
        top: context.height * 0.025,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            children: [
              Container(
                width: context.width * 0.20,
                height: context.width * 0.20,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.darkGrayColor,
                ),
                child: Padding(
                  padding: EdgeInsets.all(
                    context.width * 0.015,
                  ),
                  child: Image.asset(
                    AppAssets.profileIcon,
                  ),
                ),
              ),
              SizedBox(
                height: context.height * 0.008,
              ),
              Text(
                'John Safwat',
                style: AppStyles.bold20WhiteRoboto.copyWith(
                  fontSize: 14,
                ),
              ),
            ],
          ),
          Spacer(),
          Column(
            children: [
              Text(
                '12',
                style: AppStyles.bold24WhiteRoboto,
              ),
              Text(
                'Wish List'.tr(),
                style: AppStyles.bold20WhiteRoboto.copyWith(
                  fontSize: 14,
                ),
              ),
            ],
          ),

          SizedBox(
            width: context.width * 0.10,
          ),
          Column(
            children: [
              Text(
                '10',
                style: AppStyles.bold24WhiteRoboto,
              ),
              Text(
                'History'.tr(),
                style: AppStyles.bold20WhiteRoboto.copyWith(
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}