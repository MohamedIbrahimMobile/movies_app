class OnboardingButtonData {
  final String textKey;
  final bool isPrimary;
  final bool isFinish;

  OnboardingButtonData({
    required this.textKey,
    required this.isPrimary,
    this.isFinish = false,
  });
}

class OnboardingItem {
  final String image;
  final String titleKey;
  final String? descriptionKey;
  final List<OnboardingButtonData> buttons;

  OnboardingItem({
    required this.image,
    required this.titleKey,
    this.descriptionKey,
    required this.buttons,
  });
}