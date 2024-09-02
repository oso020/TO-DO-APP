import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider extends ChangeNotifier {
  bool? mode;
  ThemeMode? theme;

  ThemeProvider({bool? mode}) {
    if (mode != null) {
      this.mode = mode;
      theme = mode ? ThemeMode.dark : ThemeMode.light;
    } else {
      // Get the theme from the system settings
      var brightness = WidgetsBinding.instance.window.platformBrightness;
      theme = brightness == Brightness.dark ? ThemeMode.dark : ThemeMode.light;
      this.mode = brightness == Brightness.dark;
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
