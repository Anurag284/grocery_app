import 'package:shared_preferences/shared_preferences.dart';

class DarkThemePrefs {
  static const theme_status = "THEME_STATUS";
  setDarkTheme(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(theme_status, value);
  }

  Future<bool> getDarkTheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return (prefs.getBool(theme_status) ?? false);
  }
}
