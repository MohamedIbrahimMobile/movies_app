import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:movies_app/api/model/data.dart';
import 'package:movies_app/api/model/movie.dart';
import 'package:movies_app/ui/movie_details/movie_details_screen.dart';
import 'package:movies_app/ui/onboarding/onboarding_screen.dart';
import 'package:movies_app/ui/similar_movies/similar_movies.dart';
import 'package:movies_app/ui/splash/splash_screen.dart';
import 'package:movies_app/ui/auth/login/forget_password_screen.dart';
import 'package:movies_app/ui/auth/login/login_screen.dart';
import 'package:movies_app/ui/auth/register/register_screen.dart';
import 'package:movies_app/ui/home/home_screen.dart';
import 'package:movies_app/ui/home/tabs/profile/update_profile_screen.dart';
import 'package:movies_app/utils/app_routes.dart';
import 'package:movies_app/utils/app_theme.dart';
import 'api/model/movies.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  await Firebase.initializeApp(
  options: DefaultFirebaseOptions.currentPlatform,
);
  runApp(
    EasyLocalization(
      supportedLocales: const [
        Locale('en'),
        Locale('ar'),
      ],
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
      initialRoute: AppRoutes.splashScreenRouteName,
      onGenerateRoute: (settings) {
        if (settings.name == AppRoutes.movieDetailsScreenRouteName) {
          final movies = settings.arguments as Movies? ??
              ///ال id هنا المفروض يتغير علي اساس ال list اللي في ال homeTab
              Movies(data: Data(movie: Movie(id: 30)))
        ;
          return MaterialPageRoute(
            builder: (context) => MovieDetailsScreen(movies: movies),
          );
        }
        return null;
      },
      routes: {
        AppRoutes.splashScreenRouteName: (context) => SplashScreen(),
        AppRoutes.onboardingRouteName: (context) => OnboardingScreen(),
        AppRoutes.loginRouteName: (context) => LoginScreen(),
        AppRoutes.registerRouteName: (context) => RegisterScreen(),
        AppRoutes.homeRouteName: (context) => HomeScreen(),
        AppRoutes.updateProfileRouteName: (context) => UpdateProfileScreen(),
        AppRoutes.forgetPasswordRouteName: (context) => ForgetPassword(),
        AppRoutes.similarMoviesRouteName: (context) => SimilarMovies(),
      },
    );
  }
}