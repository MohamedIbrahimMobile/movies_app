import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:movies_app/utils/app_assets.dart';
import 'package:movies_app/utils/app_colors.dart';
import 'package:movies_app/utils/app_routes.dart';
import 'package:movies_app/utils/app_styles.dart';
import 'package:movies_app/utils/size_utils.dart';
import 'package:movies_app/widgets/custom_elevated_button.dart';
import 'package:movies_app/widgets/custom_text_field.dart';
import 'package:movies_app/widgets/language_toggle_switch.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'register'.tr(),
          style: AppStyles.reg16YellowRoboto,
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          keyboardDismissBehavior:
          ScrollViewKeyboardDismissBehavior.onDrag,
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: context.width * 0.04,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Image.asset(
                      AppAssets.avatarImage1,
                    ),
                    Image.asset(
                      AppAssets.avatarImage2,
                    ),
                    Image.asset(
                      AppAssets.avatarImage3,
                    ),
                  ],
                ),
                SizedBox(height: context.height * 0.015,),
                Text(
                  'avatar'.tr(),
                  textAlign: TextAlign.center,
                  style: AppStyles.reg16WhiteRoboto,
                ),
                SizedBox(height: context.height * 0.02,),
                CustomTextField(
                  prefixIcon: Image.asset(
                    AppAssets.nameIcon,
                  ),
                  hintText: 'name'.tr(),
                  hintStyle: AppStyles.reg16WhiteRoboto,
                ),
                SizedBox(height: context.height * 0.02,),
                CustomTextField(
                  prefixIcon: Image.asset(
                    AppAssets.emailIcon,
                  ),
                  hintText: 'email'.tr(),
                  hintStyle: AppStyles.reg16WhiteRoboto,
                  keyboardType: TextInputType.emailAddress,
                ),
                SizedBox(height: context.height * 0.02,),
                CustomTextField(
                  prefixIcon: Image.asset(
                    AppAssets.passwordIcon,
                  ),
                  suffixIcon: Icon(
                    Icons.visibility_off_sharp,
                  ),
                  hintText: 'password'.tr(),
                  hintStyle: AppStyles.reg16WhiteRoboto,
                  obscureText: true,
                ),
                SizedBox(height: context.height * 0.02,),
                CustomTextField(
                  prefixIcon: Image.asset(
                    AppAssets.passwordIcon,
                  ),
                  suffixIcon: Icon(
                    Icons.visibility_off_sharp,
                  ),
                  hintText: 'confirm_password'.tr(),
                  hintStyle: AppStyles.reg16WhiteRoboto,
                  obscureText: true,
                ),
                SizedBox(height: context.height * 0.02,),
                CustomTextField(
                  prefixIcon: Image.asset(
                    AppAssets.phoneIcon,
                  ),
                  hintText: 'phone_number'.tr(),
                  hintStyle: AppStyles.reg16WhiteRoboto,
                  keyboardType: TextInputType.phone,
                ),
                SizedBox(height: context.height * 0.02,),
                CustomElevatedButton(
                  backgroundColor: AppColors.yellowColor,
                  verticalPadding: context.height * 0.01,
                  onPressed: () {
                    Navigator.popAndPushNamed(
                      context,
                      AppRoutes.homeRouteName,
                    );
                  },
                  child: Text(
                    'create_account'.tr(),
                    style: AppStyles.reg20BlackRoboto,
                  ),
                ),
                SizedBox(height: context.height * 0.01,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'already_have_account'.tr(),
                      style: AppStyles.reg14WhiteRoboto,
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.popAndPushNamed(
                          context,
                          AppRoutes.loginRouteName,
                        );
                      },
                      child: Text(
                        'login'.tr(),
                        style: AppStyles.black14YellowRoboto,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: context.height * 0.01,),
                LanguageToggleSwitch(),
                SizedBox(height: context.height * 0.02,),
              ],
            ),
          ),
        ),
      ),
    );
  }
}