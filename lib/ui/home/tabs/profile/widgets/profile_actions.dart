import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:movies_app/utils/app_colors.dart';
import 'package:movies_app/utils/app_routes.dart';
import 'package:movies_app/utils/app_styles.dart';
import 'package:movies_app/utils/size_utils.dart';

class ProfileActions extends StatelessWidget {
  const ProfileActions({super.key});

  Future<void> _showLogoutDialog(BuildContext context) async {
    final shouldLogout = await showDialog<bool>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          backgroundColor: AppColors.darkGrayColor,
          title: Text('logout'.tr(),
            style: AppStyles.bold20WhiteRoboto,
          ),
          content: Text('logout_confirmation'.tr(),
            style: AppStyles.reg14WhiteRoboto,
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(dialogContext, false);
              },
              child: Text('cancel'.tr(),
                style: AppStyles.reg14WhiteRoboto,
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(dialogContext, true);
              },
              child: Text('logout'.tr(),
                style: AppStyles.reg14WhiteRoboto.copyWith(
                  color: AppColors.redColor,
                ),
              ),
            ),
          ],
        );
      },
    );

    if (shouldLogout != true) {
      return;
    }
    try {
      await FirebaseAuth.instance.signOut();
      if (!context.mounted) {
        return;
      }

      Navigator.pushNamedAndRemoveUntil(
        context, AppRoutes.loginRouteName,
            (route) => false,
        arguments: true,
      );
    } catch (e) {
      if (!context.mounted) {
        return;
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Logout failed: $e',
          ),
          backgroundColor: AppColors.redColor,
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: context.width * 0.045,
        right: context.width * 0.045,
        top: context.height * 0.015,
      ),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: SizedBox(
              height: context.height * 0.055,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(
                    context,
                    AppRoutes.updateProfileRouteName,
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.yellowColor,
                  foregroundColor: AppColors.blackColor,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                      context.width * 0.025,
                    ),
                  ),
                ),
                child: Text(
                  'edit_profile'.tr(),
                  style: AppStyles.reg16BlackRoboto,
                ),
              ),
            ),
          ),
          SizedBox(width: context.width * 0.02,),
          Expanded(
            flex: 2,
            child: SizedBox(
              height: context.height * 0.055,
              child: ElevatedButton(
                onPressed: () {
                  _showLogoutDialog(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.redColor,
                  foregroundColor: AppColors.whiteColor,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                      context.width * 0.025,
                    ),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('exit'.tr(),
                      style: AppStyles.reg16WhiteRoboto,
                    ),
                    SizedBox(width: context.width * 0.015,),
                    Icon(Icons.logout,
                      size: 18,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}