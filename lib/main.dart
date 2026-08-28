import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
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

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(
    EasyLocalization(
      supportedLocales: const [Locale('en'), Locale('ar')],
      path: 'assets/translations',
      fallbackLocale: const Locale('en'),
      startLocale: const Locale('en'),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      debugShowCheckedModeBanner: false,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.dark,
      initialRoute: AppRoutes.onboardingRouteName,
      routes: {
        AppRoutes.onboardingRouteName: (context) => OnboardingScreen(),
        AppRoutes.loginRouteName: (context) => LoginScreen(),
        AppRoutes.registerRouteName: (context) => RegisterScreen(),
        AppRoutes.homeRouteName: (context) => HomeScreen(),
        AppRoutes.updateProfileRouteName: (context) => UpdateProfileScreen(),
        AppRoutes.forgetPasswordRouteName: (context) => ForgetPassword(),
        AppRoutes.movieDetailsScreenRouteName: (context) =>
            MovieDetailsScreen(),
      },
    );
  }
}
