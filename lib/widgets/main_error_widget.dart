import 'package:flutter/material.dart';
import 'package:movies_app/utils/app_styles.dart';
import 'package:movies_app/utils/size_utils.dart';

class MainErrorWidget extends StatelessWidget {
  final String message;
  final VoidCallback onPressed;

  const MainErrorWidget({
    super.key,
    required this.message,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      spacing: context.height * 0.02,
      children: [
        Text(message, style: AppStyles.reg16WhiteRoboto),
        ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.symmetric(
              vertical: context.height * 0.015,
              horizontal: context.width * 0.08,
            ),
          ),
          child: Text('Try Again', style: AppStyles.reg16YellowRoboto),
        ),
      ],
    );
  }
}
