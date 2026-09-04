import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:movies_app/utils/app_styles.dart';
import 'package:movies_app/utils/size_utils.dart';

class MainErrorWidget extends StatelessWidget {
  final String message;
  final double? height;
  final double? width;
  final VoidCallback onPressed;

  const MainErrorWidget({
    super.key,
    required this.message,
    required this.onPressed,
    this.height,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        spacing: context.height * 0.02,
        children: [
          Text(message.tr(), style: AppStyles.reg16WhiteRoboto),
          ElevatedButton(
            onPressed: onPressed,
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.symmetric(
                vertical: context.height * 0.015,
                horizontal: context.width * 0.08,
              ),
            ),
            child: Text('try_again'.tr(), style: AppStyles.reg16YellowRoboto),
          ),
        ],
      ),
    );
  }
}
