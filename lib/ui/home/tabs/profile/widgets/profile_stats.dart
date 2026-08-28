import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:movies_app/utils/app_assets.dart';
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
        top: context.height * 0.030,
      ),
      child: Row(
        spacing: context.width * 0.15,
        children: [
          Column(
            spacing: context.height * 0.02,
            children: [
              CircleAvatar(
                radius: 45,
                child: Image.asset(
                  AppAssets.avatarImage2,
                  width: double.infinity,
                  height: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              Text(
                'John Safwat',
                style: AppStyles.bold20WhiteRoboto.copyWith(fontSize: 14),
              ),
            ],
          ),
          Column(
            children: [
              Text('12', style: AppStyles.bold24WhiteRoboto),
              SizedBox(height: context.height * 0.01),
              Text(
                'watchlist'.tr(),
                style: AppStyles.bold20WhiteRoboto.copyWith(fontSize: 16),
              ),
            ],
          ),
          Column(
            children: [
              Text('10', style: AppStyles.bold24WhiteRoboto),
              SizedBox(height: context.height * 0.01),
              Text(
                'history'.tr(),
                style: AppStyles.bold20WhiteRoboto.copyWith(fontSize: 16),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
