import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:movies_app/services/shared_preferences_service.dart';
import 'package:movies_app/ui/auth/login/forget_password_screen.dart';
import 'package:movies_app/ui/auth/login/login_screen.dart';
import 'package:movies_app/ui/auth/register/register_screen.dart';
import 'package:movies_app/ui/home/home_screen.dart';
import 'package:movies_app/ui/home/tabs/profile/update_profile_screen.dart';
import 'package:movies_app/ui/movie_details/movie_details_screen.dart';
import 'package:movies_app/ui/onboarding/onboarding_screen.dart';
import 'package:movies_app/utils/app_routes.dart';
import 'package:movies_app/utils/app_theme.dart';

import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await EasyLocalization.ensureInitialized();
  await SharedPreferencesService.init();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  final String initialRoute;

  if (!SharedPreferencesService.isOnboardingSeen) {
    initialRoute = AppRoutes.onboardingRouteName;
  } else if (FirebaseAuth.instance.currentUser != null) {
    initialRoute = AppRoutes.homeRouteName;
  } else {
    initialRoute = AppRoutes.loginRouteName;
  }
  runApp(
    EasyLocalization(
      supportedLocales: const [Locale('en'), Locale('ar')],
      path: 'assets/translations',
      fallbackLocale: const Locale('en'),
      startLocale: const Locale('en'),
      child: MyApp(initialRoute: initialRoute),
    ),
  );
}

class MyApp extends StatelessWidget {
  final String initialRoute;

  const MyApp({super.key, required this.initialRoute});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      debugShowCheckedModeBanner: false,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.dark,
      initialRoute: initialRoute,
      routes: {
        AppRoutes.onboardingRouteName: (context) => OnboardingScreen(),
        AppRoutes.loginRouteName: (context) => LoginScreen(),
        AppRoutes.registerRouteName: (context) => RegisterScreen(),
        AppRoutes.homeRouteName: (context) => HomeScreen(),
        AppRoutes.updateProfileRouteName: (context) => UpdateProfileScreen(),
        AppRoutes.forgetPasswordRouteName: (context) => ForgetPassword(),
        AppRoutes.movieDetailsScreenRouteName: (context) {
          final movieId = ModalRoute.of(context)!.settings.arguments as int;
          return MovieDetailsScreen(movieId: movieId);
        },
      },
    );
  }
}
