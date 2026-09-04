import 'package:movies_app/utils/app_assets.dart';

import '../models/onboarding_button_data.dart';

List<OnboardingItem> onboardingItems = [
  OnboardingItem(
    image: AppAssets.onBoarding1Image,
    titleKey: 'onboarding_title_1',
    descriptionKey: 'onboarding_desc_1',
    buttons: [OnboardingButtonData(textKey: 'explore_now', isPrimary: true)],
  ),
  OnboardingItem(
    image: AppAssets.onBoarding2Image,
    titleKey: 'onboarding_title_2',
    descriptionKey: 'onboarding_desc_2',
    buttons: [OnboardingButtonData(textKey: 'next', isPrimary: true)],
  ),
  OnboardingItem(
    image: AppAssets.onBoarding3Image,
    titleKey: 'onboarding_title_3',
    descriptionKey: 'onboarding_desc_3',
    buttons: [
      OnboardingButtonData(textKey: 'next', isPrimary: true),
      OnboardingButtonData(textKey: 'back', isPrimary: false),
    ],
  ),
  OnboardingItem(
    image: AppAssets.onBoarding4Image,
    titleKey: 'onboarding_title_4',
    descriptionKey: 'onboarding_desc_4',
    buttons: [
      OnboardingButtonData(textKey: 'next', isPrimary: true),
      OnboardingButtonData(textKey: 'back', isPrimary: false),
    ],
  ),
  OnboardingItem(
    image: AppAssets.onBoarding5Image,
    titleKey: 'onboarding_title_5',
    descriptionKey: 'onboarding_desc_5',
    buttons: [
      OnboardingButtonData(textKey: 'next', isPrimary: true),
      OnboardingButtonData(textKey: 'back', isPrimary: false),
    ],
  ),
  OnboardingItem(
    image: AppAssets.onBoarding6Image,
    titleKey: 'onboarding_title_6',
    buttons: [
      OnboardingButtonData(textKey: 'finish', isPrimary: true, isFinish: true),
      OnboardingButtonData(textKey: 'back', isPrimary: false),
    ],
  ),
];
