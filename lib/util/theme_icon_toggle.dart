import 'package:gotta_do_it/provider/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ThemeIconToggle extends StatelessWidget {
  const ThemeIconToggle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ThemeProvider>(context);
    final bool isDark = !provider.isDarkMode;
    return IconButton(
        onPressed: () {
          provider.toggleTheme(isDark);
        },
        icon: Icon(
          isDark ? Icons.dark_mode_outlined : Icons.light_mode_outlined,
        ));
  }
}
