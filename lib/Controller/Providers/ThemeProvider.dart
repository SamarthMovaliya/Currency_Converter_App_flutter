import 'package:currency_converter_app_api/Modals/Glpbals/Modals/ThemeModal.dart';
import 'package:flutter/material.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeModal themeModal = ThemeModal(isDark: false);

  changeTheme() {
    themeModal.isDark = !themeModal.isDark;
    notifyListeners();
  }
}
