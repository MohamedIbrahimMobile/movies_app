import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:movies_app/utils/app_colors.dart';
import 'package:movies_app/utils/app_styles.dart';
import 'package:movies_app/utils/size_utils.dart';

class DialogUtils {
  static void showLoading({
    required BuildContext context,
    required String loadingText,
  }) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          backgroundColor: AppColors.darkGrayColor,
          content: Row(
            spacing: context.width * 0.04,
            children: [
              CircularProgressIndicator(color: AppColors.yellowColor),
              Expanded(
                child: Text(loadingText, style: AppStyles.reg16WhiteRoboto),
              ),
            ],
          ),
        );
      },
    );
  }

  static void hideLoading({required BuildContext context}) {
    Navigator.pop(context);
  }

  static void showMessage({
    required BuildContext context,
    required String message,
    String title = '',
    String? posActionName,
    VoidCallback? posAction,
    String? negActionName,
    VoidCallback? negAction,
  }) {
    List<Widget> actions = [];

    if (posActionName != null) {
      actions.add(
        TextButton(
          onPressed: () {
            Navigator.pop(context);
            posAction?.call();
          },
          child: Text(posActionName, style: AppStyles.reg16YellowRoboto),
        ),
      );
    }

    if (negActionName != null) {
      actions.add(
        TextButton(
          onPressed: () {
            Navigator.pop(context);
            negAction?.call();
          },
          child: Text(negActionName, style: AppStyles.reg16WhiteRoboto),
        ),
      );
    }

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: AppColors.darkGrayColor,
          title: title.isNotEmpty
              ? Text(title.tr(), style: AppStyles.reg20WhiteRoboto)
              : null,
          content: Text(message.tr(), style: AppStyles.reg16WhiteRoboto),
          actions: actions,
        );
      },
    );
  }

  static void showToast({required String message}) {
    Fluttertoast.showToast(
      msg: message.tr(),
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.TOP,
      timeInSecForIosWeb: 1,
      backgroundColor: AppColors.yellowColor,
      textColor: AppColors.blackColor,
      fontSize: 16.0,
    );
  }
}
