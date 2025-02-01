import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DarkLightModeChanger extends ChangeNotifier {
  static const IconData phone = Icons.phone_android_outlined;
  static const IconData darkMode = Icons.dark_mode_outlined;
  static const IconData lightMode = Icons.light_mode_outlined;
  //late String modeString;
  late ThemeMode mode = ThemeMode.system;
  void getModePrefs() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var modeString = prefs.getString("mode") ?? "system";
    if (modeString == "light") {
      mode = ThemeMode.light;
    } else if (modeString == "dark") {
      mode = ThemeMode.dark;
    } else {
      mode = ThemeMode.system;
    }
    notifyListeners();
  }

  void writeModePrefs() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("mode", mode.name);
  }

  void toggleModePrefs() {
    if (mode == ThemeMode.system) {
      mode = ThemeMode.light;
    } else if (mode == ThemeMode.light) {
      mode = ThemeMode.dark;
    } else {
      mode = ThemeMode.system;
    }
    writeModePrefs();
    notifyListeners();
  }

  IconData getCurentIcon() {
    if (mode == ThemeMode.system) {
      return phone;
    } else if (mode == ThemeMode.light) {
      return lightMode;
    } else {
      return darkMode;
    }
  }
}
