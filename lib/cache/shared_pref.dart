import 'package:shared_preferences/shared_preferences.dart';

class SharedPref {
  // Save a boolean.
  // ignore: avoid_positional_boolean_parameters
  Future<void> setBool(String key, bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(key, value);
  }

  // Get a boolean.
  Future<bool> getBool(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(key) ?? false;
  }
}
