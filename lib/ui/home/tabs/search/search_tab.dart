import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:movies_app/utils/app_assets.dart';
import 'package:movies_app/utils/app_colors.dart';
import 'package:movies_app/utils/app_styles.dart';
import 'package:movies_app/utils/size_utils.dart';

class SearchTab extends StatelessWidget {
  const SearchTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.transparent,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: context.width * 0.04,
            vertical: context.height * 0.02,
          ),
          child: Column(
            children: [
              Container(
                height: context.height * 0.06,
                decoration: BoxDecoration(
                  color: AppColors.darkGrayColor,
                  borderRadius: BorderRadius.circular(
                    context.width * 0.03,
                  ),
                ),
                child: TextField(
                  style: AppStyles.reg16WhiteRoboto,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    prefixIcon: Padding(
                      padding: EdgeInsets.all(
                        context.width * 0.035,
                      ),
                      child: Image.asset(
                        AppAssets.searchIcon,
                      ),
                    ),
                    hintText: 'search'.tr(),
                    hintStyle: AppStyles.reg14WhiteRoboto,
                    contentPadding: EdgeInsets.symmetric(
                      vertical: context.height * 0.018,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Center(
                  child: Image.asset(
                    AppAssets.watchListImage,
                    width: context.width * 0.30,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}