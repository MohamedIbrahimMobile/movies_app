import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:movies_app/models/onboarding_button_data.dart';
import 'package:movies_app/utils/app_colors.dart';
import 'package:movies_app/utils/app_styles.dart';
import 'package:movies_app/utils/size_utils.dart';
import 'package:movies_app/widgets/custom_elevated_button.dart';

class OnboardingPage extends StatelessWidget {
  final OnboardingItem item;
  final int index;
  final VoidCallback onNext;
  final VoidCallback onBack;
  final VoidCallback onFinish;

  const OnboardingPage({
    super.key,
    required this.item,
    required this.index,
    required this.onNext,
    required this.onBack,
    required this.onFinish,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset(
          item.image,
          fit: BoxFit.cover,
          width: double.infinity,
          height: double.infinity,
        ),
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Container(
            decoration: BoxDecoration(
              color: index == 0 ? AppColors.transparent : AppColors.blackColor,
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(35),
                topLeft: Radius.circular(35),
              ),
            ),
            child: Padding(
              padding: EdgeInsets.only(
                left: context.width * 0.05,
                right: context.width * 0.05,
              ),
              child: SafeArea(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      item.titleKey.tr(),
                      style: AppStyles.bold24WhiteInter.copyWith(
                        decoration: TextDecoration.none,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: context.height * 0.02),
                    if (item.descriptionKey != null) ...[
                      Text(
                        item.descriptionKey!.tr(),
                        style: AppStyles.reg20White60Inter.copyWith(
                          decoration: TextDecoration.none,
                          height: 1.2,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: context.height * 0.02),
                    ] else
                      SizedBox(height: context.height * 0.01),
                    for (var button in item.buttons)
                      Padding(
                        padding: EdgeInsets.only(bottom: context.height * 0.01),
                        child: SizedBox(
                          width: double.infinity,
                          child: CustomElevatedButton(
                            onPressed: button.isFinish
                                ? onFinish
                                : button.isPrimary
                                ? onNext
                                : onBack,
                            backgroundColor: button.isPrimary
                                ? AppColors.yellowColor
                                : AppColors.transparent,
                            radius: 15,
                            verticalPadding: context.height * 0.01716,
                            sideColor: button.isPrimary
                                ? AppColors.transparent
                                : AppColors.yellowColor,
                            child: Text(
                              button.textKey.tr(),
                              style:
                                  (button.isPrimary
                                          ? AppStyles.simi20BlackInter
                                          : AppStyles.simi20YellowInter)
                                      .copyWith(
                                        decoration: TextDecoration.none,
                                      ),
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
