import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeMode activeTheme = ThemeMode.system;

  // bool get isDarkMode => activeTheme == ThemeMode.dark;

  bool get isDarkMode {
    if (activeTheme == ThemeMode.system) {
      return SchedulerBinding.instance!.window.platformBrightness ==
          Brightness.dark;
    }
    return activeTheme == ThemeMode.dark;
  }

  void toggleTheme(bool i) {
    activeTheme = i ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }
}
