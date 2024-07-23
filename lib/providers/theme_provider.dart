import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider extends ChangeNotifier {
  bool mode;
  ThemeMode theme;

  ThemeProvider({this.mode = true})
      : theme = mode ? ThemeMode.dark : ThemeMode.light;

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
    prefs.setBool('theme', mode);
    notifyListeners();
  }
}
