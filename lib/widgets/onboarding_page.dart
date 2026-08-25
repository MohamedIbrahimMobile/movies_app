import 'package:flutter/material.dart';
import 'package:movies_app/data/onboarding_item.dart';
import '../utils/app_colors.dart';
import '../utils/app_styles.dart';
import '../utils/size_utils.dart';
import 'custom_elevated_button.dart';

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
    required this.onBack, required this.onFinish,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset(item.image),
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
                top: context.height * 0.03,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    item.title,
                    style: AppStyles.bold24WhiteInter,
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: context.height * 0.017),
                  Text(
                    item.description ?? '',
                    style: AppStyles.reg20White60Inter,
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: context.height * 0.03),
                  for (var button in item.buttons)
                    Padding(
                      padding: EdgeInsets.only(bottom: context.height * 0.01),
                      child: SizedBox(
                        width: double.infinity,
                        child: CustomElevatedButton(
                          onPressed: button.isFinish ? onFinish
                          : button.isPrimary? onNext:onBack,
                          backgroundColor: button.isPrimary
                              ? AppColors.yellowColor
                              : AppColors.transparent,
                          radius: 15,
                          verticalPadding: context.height * 0.01716,
                          sideColor: button.isPrimary
                              ? AppColors.transparent
                              : AppColors.yellowColor,
                          child: Text(
                            button.text,
                            style: button.isPrimary
                                ? AppStyles.simi20BlackInter
                                : AppStyles.simi20YellowInter,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
