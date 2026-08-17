import 'onboarding_button_data.dart';

class OnboardingItem {
  final String image;
  final String title;
  final String? description ;
  final List<OnboardingButtonData> buttons;

  OnboardingItem({
    required this.image,
    required this.title,
    this.description,
    required this.buttons,
  });
}
