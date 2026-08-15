import 'package:flutter/material.dart';
import 'package:movies_app/utils/app_colors.dart';
import 'package:movies_app/utils/app_styles.dart';
import 'package:movies_app/utils/size_utils.dart';

class ProfileActions extends StatelessWidget {
  const ProfileActions({super.key});

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
                onPressed: () {},
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
                  'Edit Profile',
                  style: AppStyles.reg16BlackRoboto,
                ),
              ),
            ),
          ),

          SizedBox(
            width: context.width * 0.02,
          ),

          Expanded(
            flex: 2,
            child: SizedBox(
              height: context.height * 0.055,
              child: ElevatedButton(
                onPressed: () {},
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
                    Text(
                      'Exit',
                      style: AppStyles.reg16WhiteRoboto,
                    ),
                    SizedBox(
                      width: context.width * 0.015,
                    ),
                    const Icon(
                      Icons.logout,
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