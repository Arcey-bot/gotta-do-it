import 'dart:math';

import 'package:flutter/material.dart';
import 'package:gotta_do_it/model/todo.dart';
import 'package:gotta_do_it/util/shared_prefs.dart';
import 'package:gotta_do_it/util/theme_icon_toggle.dart';
import 'package:gotta_do_it/widget/todo_card.dart';
import 'package:provider/provider.dart';

import 'package:gotta_do_it/page/home_page.dart';
import 'package:gotta_do_it/provider/theme_provider.dart';
import 'package:gotta_do_it/util/strings.dart';
import 'package:gotta_do_it/widget/todo_data_holder.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPrefs().init();
  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) => StateContainer(
        child: ChangeNotifierProvider(
            create: (context) => ThemeProvider(),
            builder: (context, _) {
              final themeProvider = Provider.of<ThemeProvider>(context);
              return MaterialApp(
                title: Strings.appTitle,
                theme: ThemeData.light(),
                darkTheme: ThemeData.dark(),
                themeMode: themeProvider.activeTheme,
                home: const HomePage(),
              );
            }),
      );
}
