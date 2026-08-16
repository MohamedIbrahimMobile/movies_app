import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:movies_app/utils/app_assets.dart';
import 'package:movies_app/utils/app_colors.dart';
import 'package:movies_app/utils/app_styles.dart';
import 'package:movies_app/utils/size_utils.dart';
import 'package:movies_app/widgets/animated_toggle.dart';
import 'package:movies_app/widgets/custom_elevated_button.dart';
import 'package:movies_app/widgets/custom_text_field.dart';

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
       title: Text('register'.tr(),
       style: AppStyles.reg16YellowRoboto
       ),
      ),
      body: Padding(
        padding:  EdgeInsets.symmetric(
          horizontal: context.width*0.04,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          spacing: context.height*0.02,
          children: [
            Row(
              spacing: context.width*0.04,
              children: [
                Image.asset(AppAssets.thirdAvatarImage),
                Image.asset(AppAssets.firstAvatarImage),
                Image.asset(AppAssets.secondAvatarImage),
              ],
            ),
            Text('avatar'.tr(),
            textAlign: TextAlign.center,
            style: AppStyles.reg16WhiteRoboto),
            CustomTextField(
              prefixIcon: Image.asset(AppAssets.nameIcon),
              hintText: 'name'.tr(),
              hintStyle: AppStyles.reg16WhiteRoboto,
            ),
            CustomTextField(
              prefixIcon: Image.asset(AppAssets.emailIcon),
              hintText: 'email'.tr(),
              hintStyle: AppStyles.reg16WhiteRoboto,
            ),
            CustomTextField(
              prefixIcon: Image.asset(AppAssets.passwordIcon),
              suffixIcon: Icon(Icons.visibility_off_sharp),
              hintText: 'password'.tr(),
              hintStyle: AppStyles.reg16WhiteRoboto,
            ),
            CustomTextField(
              prefixIcon: Image.asset(AppAssets.passwordIcon),
              suffixIcon: Icon(Icons.visibility_off_sharp),
              hintText: 'confirm_password'.tr(),
              hintStyle: AppStyles.reg16WhiteRoboto,
            ),
            CustomTextField(
              prefixIcon: Image.asset(AppAssets.phoneIcon),
              hintText: 'phone_number'.tr(),
              hintStyle: AppStyles.reg16WhiteRoboto,
            ),
            CustomElevatedButton(
              backgroundColor: AppColors.yellowColor,
                verticalPadding: context.height*0.01,
                onPressed: (){},
                // todo : go to home screen
                child: Text('create_account'.tr(),
                style: AppStyles.reg20BlackRoboto,),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('already_have_account'.tr(),
                style: AppStyles.reg14WhiteRoboto,),

                TextButton(onPressed: (){
                  // todo : go to login
                },
                    child: Text('login'.tr(),
                style: AppStyles.black14YellowRoboto,)
                ),
              ],
            ),
            AnimatedToggle(),


          ],
        ),
      ),
    );
  }
}
