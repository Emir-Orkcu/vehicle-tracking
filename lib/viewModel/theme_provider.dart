import 'package:CarTracker/sharedPreferences/shared_preferences.dart';
import 'package:flutter/cupertino.dart';

class ThemeProvider with ChangeNotifier {
  String? language;
  Future changeLanguage(String newLanguage) async {
    language = newLanguage;
    Preferences().languageAdd(language);

    notifyListeners();
  }
}
