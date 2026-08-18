import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:movies_app/utils/app_assets.dart';
import 'package:movies_app/utils/app_colors.dart';
import 'package:movies_app/utils/app_styles.dart';
import 'package:movies_app/utils/size_utils.dart';
import 'package:movies_app/widgets/custom_elevated_button.dart';
import 'package:movies_app/widgets/custom_text_field.dart';

class ForgetPassword extends StatelessWidget {
  const ForgetPassword({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,

      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'forget_password_title'.tr(),
          style: AppStyles.reg16YellowRoboto,
        ),
      ),

      body: SafeArea(
        child: SingleChildScrollView(
          keyboardDismissBehavior:
          ScrollViewKeyboardDismissBehavior.onDrag,
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: context.width * 0.02,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Image.asset(
                  AppAssets.forgetPasswordImage,
                ),

                SizedBox(
                  height: context.height * 0.04,
                ),

                CustomTextField(
                  fillColor: AppColors.darkGrayColor,
                  fill: true,
                  prefixIcon: Image.asset(
                    AppAssets.emailIcon,
                  ),
                  hintText: 'email'.tr(),
                  hintStyle: AppStyles.reg16WhiteRoboto,
                  keyboardType: TextInputType.emailAddress,
                ),

                SizedBox(
                  height: context.height * 0.03,
                ),

                CustomElevatedButton(
                  verticalPadding: context.height * 0.013,
                  backgroundColor: AppColors.yellowColor,
                  child: Text(
                    'verify'.tr(),
                    style: AppStyles.reg20BlackRoboto,
                  ),
                  onPressed: () {},
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}