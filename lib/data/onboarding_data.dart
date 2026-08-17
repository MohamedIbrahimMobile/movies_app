import 'package:movies_app/models/onboarding_button_data.dart';
import 'package:movies_app/models/onboarding_item.dart';
import 'package:movies_app/utils/app_assets.dart';

List<OnboardingItem> onboardingItems = [
  OnboardingItem(
    image: AppAssets.onBoarding1Image,
    title: 'Find Your Next Favorite Movie Here',
    description:
        'Get access to a huge library of movies to suit all tastes. You will surely like it.',
    buttons: [OnboardingButtonData(text: 'Explore Now', isPrimary: true)],
  ),
  OnboardingItem(
    image: AppAssets.onBoarding2Image,
    title: 'Discover Movies',
    description:
        'Explore a vast collection of movies in all qualities and genres. Find your next favorite film with ease.',
    buttons: [OnboardingButtonData(text: 'Next', isPrimary: true)],
  ),
  OnboardingItem(
    image: AppAssets.onBoarding3Image,
    title: 'Explore All Genres',
    description:
        'Discover movies from every genre, in all available qualities. Find something new and exciting to watch every day.',
    buttons: [
      OnboardingButtonData(text: 'Next', isPrimary: true),
      OnboardingButtonData(text: 'Back', isPrimary: false),
    ],
  ),
  OnboardingItem(
    image: AppAssets.onBoarding4Image,
    title: 'Create Watchlists',
    description:
        'Save movies to your watchlist to keep track of what you want to watch next. Enjoy films in various qualities and genres.',
    buttons: [
      OnboardingButtonData(text: 'Next', isPrimary: true),
      OnboardingButtonData(text: 'Back', isPrimary: false),
    ],
  ),
  OnboardingItem(
    image: AppAssets.onBoarding5Image,
    title: 'Rate, Review, and Learn',
    description:
        'Share your thoughts on the movies you\'ve watched. Dive deep into film details and help others discover great movies with your reviews.',
    buttons: [
      OnboardingButtonData(text: 'Next', isPrimary: true),
      OnboardingButtonData(text: 'Back', isPrimary: false),
    ],
  ),
  OnboardingItem(
    image: AppAssets.onBoarding6Image,
    title: 'Start Watching Now',
    buttons: [
      OnboardingButtonData(text: 'Finish', isPrimary: true,isFinish: true),
      OnboardingButtonData(text: 'Back', isPrimary: false),
    ],
  ),
];
