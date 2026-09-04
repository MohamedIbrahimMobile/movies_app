import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesService {
  static late SharedPreferences _prefs;

  static const String _onboardingKey = 'onboarding_seen';

  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  static bool get isOnboardingSeen {
    return _prefs.getBool(_onboardingKey) ?? false;
  }

  static Future<void> setOnboardingSeen() async {
    await _prefs.setBool(_onboardingKey, true);
  }
}
