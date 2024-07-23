import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LanguageProvider extends ChangeNotifier {
  String locale;

  LanguageProvider({this.locale = "en"});

  void changeLanguage(String newLanguage) {
    if (locale == newLanguage) {
      return;
    }
    locale = newLanguage;
    notifyListeners();
    saveDataLocalization();
  }

  void saveDataLocalization() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('appLanguage', locale);
    notifyListeners();
  }
}
