import 'package:flutter/material.dart';
import 'package:movies_app/utils/app_colors.dart';
import 'package:movies_app/utils/app_styles.dart';
import 'package:movies_app/utils/size_utils.dart';

class MainErrorWidget extends StatelessWidget {
  final String errorMessage;
  final VoidCallback onPressed;
  const MainErrorWidget({super.key, required this.errorMessage,
    required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
        child: Center(
          child: Padding(
            padding:  EdgeInsets.symmetric(
              horizontal: context.width*0.06
            ),
            child: Column(
              spacing: context.height*0.04,
              children: [
                Text(
                    errorMessage,
                style:AppStyles.bold20WhiteRoboto
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.yellowColor
                  ),
                    onPressed: onPressed,
                    child: Text('Try Again',
                    style: AppStyles.bold20WhiteRoboto),
                ),
              ],
            ),
          ),
        ),
            ),
      );
  }
}
