import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:movies_app/widgets/language_toggle_switch.dart';
import 'package:movies_app/utils/app_assets.dart';
import 'package:movies_app/utils/app_colors.dart';
import 'package:movies_app/utils/app_routes.dart';
import 'package:movies_app/utils/app_styles.dart';
import 'package:movies_app/utils/size_utils.dart';
import 'package:movies_app/widgets/custom_elevated_button.dart';
import 'package:movies_app/widgets/custom_text_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
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
                  AppAssets.loginImage,
                  height: context.height * 0.3,),
                CustomTextField(
                  prefixIcon: Image.asset(
                    AppAssets.emailIcon,),
                  fillColor: AppColors.darkGrayColor,
                  fill: true,
                  hintText: 'email'.tr(),
                  hintStyle: AppStyles.reg16WhiteRoboto,
                  keyboardType: TextInputType.emailAddress,
                ),
                SizedBox(height: context.height * 0.03,),
                CustomTextField(
                  prefixIcon: Image.asset(
                    AppAssets.passwordIcon,
                  ),
                  suffixIcon: Icon(
                    Icons.visibility_off,
                  ),
                  fillColor: AppColors.darkGrayColor,
                  fill: true,
                  obscureText: true,
                  hintText: 'password'.tr(),
                  hintStyle: AppStyles.reg16WhiteRoboto,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () {
                        //todo: Navigate forget password
                        Navigator.pushNamed(
                          context,
                          AppRoutes.forgetPasswordRouteName,
                        );
                      },
                      child: Text(
                        'forgot_password'.tr(),
                        style: AppStyles.reg14YellowRoboto,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: context.height * 0.025,),
                CustomElevatedButton(
                  verticalPadding: context.height * 0.017,
                  backgroundColor: AppColors.yellowColor,
                  child: Text(
                    'login'.tr(),
                    style: AppStyles.reg20BlackRoboto,
                  ),
                  onPressed: () {
                    //todo: Login
                  },
                ),
                SizedBox(height: context.height * 0.01,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'dont_have_account'.tr(),
                      style: AppStyles.reg14WhiteRoboto,
                    ),
                    TextButton(
                      onPressed: () {
                        //todo: Navigate Register
                        Navigator.pushNamed(context,
                          AppRoutes.registerRouteName,
                        );
                      },
                      child: Text(
                        'create'.tr(),
                        style: AppStyles.reg14YellowRoboto,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: context.height * 0.015,),
                Row(
                  children: [
                    Expanded(
                      child: Divider(
                        color: AppColors.yellowColor,
                        thickness: 2,
                        indent: context.width * 0.18,
                        endIndent: context.width * 0.04,
                      ),
                    ),
                    Text(
                      'or'.tr(),
                      style: AppStyles.reg15YellowRoboto,
                    ),
                    Expanded(
                      child: Divider(
                        color: AppColors.yellowColor,
                        thickness: 2,
                        indent: context.width * 0.04,
                        endIndent: context.width * 0.18,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: context.height * 0.04,),
                CustomElevatedButton(
                  verticalPadding: context.height * 0.017,
                  backgroundColor: AppColors.yellowColor,
                  child: Row(
                    spacing: context.width * 0.03,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        AppAssets.googleIcon,
                      ),
                      Text(
                        'login_google'.tr(),
                        style: AppStyles.reg16BlackRoboto,
                      ),
                    ],
                  ),
                  onPressed: () {
                    //todo: Login with google
                  },
                ),
                SizedBox(height: context.height * 0.04,),
                LanguageToggleSwitch(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}