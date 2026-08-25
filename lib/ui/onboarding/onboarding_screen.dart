import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:movies_app/data/onboarding_data.dart';
import 'package:movies_app/ui/onboarding/widgets/onboarding_page.dart';
import 'package:movies_app/utils/app_routes.dart';
import 'package:movies_app/utils/size_utils.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  int currentIndex = 0;
  final CarouselSliderController _carouselController =
  CarouselSliderController();

  @override
  Widget build(BuildContext context) {
    return CarouselSlider.builder(
      carouselController: _carouselController,
      itemBuilder: (context, index, realIndex) {
        return OnboardingPage(
          index: index,
          item: onboardingItems[index],
          onNext: _carouselController.nextPage,
          onBack: _carouselController.previousPage,
          onFinish: () {
            Navigator.pushReplacementNamed(context, AppRoutes.loginRouteName);
          },
        );
      },
      itemCount: onboardingItems.length,
      options: CarouselOptions(
        scrollPhysics: NeverScrollableScrollPhysics(),
        height: context.height,
        viewportFraction: 1,
        enableInfiniteScroll: false,
        onPageChanged: (index, reason) {
          setState(() {
            currentIndex = index;
          });
        },
      ),
    );
  }
}