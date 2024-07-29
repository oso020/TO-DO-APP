import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider extends ChangeNotifier {
  bool? mode;
  ThemeMode? theme;

  ThemeProvider({bool mode = true}) {
    if (mode) {
      theme = ThemeMode.dark;
    } else {
      theme = ThemeMode.light;
    }
  }

  void changeTheme(ThemeMode newTheme) {
    if (theme == newTheme) {
      return;
    }
    theme = newTheme;
    mode = newTheme == ThemeMode.dark;

    notifyListeners();
    saveDataTheme();
  }

  void saveDataTheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('theme', mode ?? false);
    notifyListeners();
  }
}
