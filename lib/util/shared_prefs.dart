import 'dart:convert';

import 'package:gotta_do_it/model/todo.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefs {
  static late SharedPreferences _sharedPrefs;

  factory SharedPrefs() => SharedPrefs._internal();

  SharedPrefs._internal();

  Future<void> init() async =>
      _sharedPrefs = await SharedPreferences.getInstance();

  List<ToDo> get todos {
    List<String>? stuff = _sharedPrefs.getStringList('todo');
    if (stuff != null) {
      return stuff.map((item) => ToDo.fromMap(jsonDecode(item))).toList();
    }
    return List.empty(growable: true);
  }

  set todos(List<ToDo> value) {
    List<String> strings =
        value.map((item) => jsonEncode(item.toMap())).toList();
    _sharedPrefs.setStringList('todo', strings);
  }
}

// final sharedPrefs = SharedPrefs();
