import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:movies_app/ui/register/register_screen.dart';
import 'utils/app_routes.dart';
import 'utils/app_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  runApp(
    EasyLocalization(
      supportedLocales: [Locale('en'), Locale('ar')],
      path: 'assets/translations',
      fallbackLocale: Locale('en'),
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
      initialRoute: AppRoutes.registerRouteName,
      routes: {
        AppRoutes.onboardingRouteName: (context) => SizedBox(),
        AppRoutes.loginRouteName: (context) => SizedBox(),
        AppRoutes.registerRouteName: (context) => RegisterScreen(),
        AppRoutes.homeRouteName: (context) => SizedBox(),
        AppRoutes.updateProfileRouteName: (context) => SizedBox(),
      },
    );
  }
}
