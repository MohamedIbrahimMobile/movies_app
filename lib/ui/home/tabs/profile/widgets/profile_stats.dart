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
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            children: [
              Container(
                width: context.width * 0.24,
                height: context.width * 0.22,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                ),
                child: ClipOval(
                  child: Image.asset(
                    AppAssets.avatarImage2,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(height: context.height * 0.02,),
              Text(
                'John Safwat',
                style: AppStyles.bold20WhiteRoboto.copyWith(
                  fontSize: 14,
                ),
              ),
            ],
          ),
          SizedBox(width: context.width * 0.15,),
          Column(
            children: [
              Text(
                '12',
                style: AppStyles.bold24WhiteRoboto,
              ),
               SizedBox(height: context.height * 0.01,),
              Text(
                'watchlist'.tr(),
                style: AppStyles.bold20WhiteRoboto.copyWith(
                  fontSize: 16,
                ),
              ),
            ],
          ),
          SizedBox(width: context.width * 0.18,),
          Column(
            children: [
              Text(
                '10',
                style: AppStyles.bold24WhiteRoboto,
              ),
               SizedBox(height: context.height * 0.01,),
              Text(
                'history'.tr(),
                style: AppStyles.bold20WhiteRoboto.copyWith(
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}