import 'dart:math';

import 'package:flutter/material.dart';
import 'package:gotta_do_it/util/shared_prefs.dart';

import 'package:gotta_do_it/util/strings.dart';
import 'package:gotta_do_it/util/theme_icon_toggle.dart';
import 'package:gotta_do_it/widget/todo_card.dart';
import 'package:gotta_do_it/model/todo.dart';
import 'package:provider/provider.dart';

List<ToDo> items = SharedPrefs().todos;
final GlobalKey<_ToDoReorderaobleStateList> todoList = GlobalKey();

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          Strings.appTitle,
        ),
        leading: IconButton(
          onPressed: () {
            _killToDo(0);
            context
                .findAncestorStateOfType<_ToDoReorderaobleStateList>()
                ?.setState(() {
              print('Test');
            });
          },
          icon: const Icon(Icons.delete_forever_outlined),
        ),
        actions: const <Widget>[
          ThemeIconToggle(),
        ],
      ),
      body: const Padding(
        padding: EdgeInsets.all(8.0),
        child: ToDoReorderableList(),
      ),
      floatingActionButton: FloatingActionButton.small(
          child: const Icon(Icons.add),
          onPressed: () {
            _createToDo();
            context
                .findAncestorStateOfType<_ToDoReorderaobleStateList>()
                ?.setState(() {
              print('Test');
            });
          }),
    );
  }
}

class FloatingUpdaterButton extends StatefulWidget {
  const FloatingUpdaterButton({Key? key}) : super(key: key);

  @override
  FloatingUpdaterButtonState createState() => FloatingUpdaterButtonState();
}

class FloatingUpdaterButtonState extends State<FloatingUpdaterButton> {
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.small(
        child: const Icon(Icons.add),
        onPressed: () {
          setState(() {
            _createToDo();
          });
        });
  }
}

class ToDoReorderableList extends StatefulWidget {
  const ToDoReorderableList({Key? key}) : super(key: key);

  @override
  _ToDoReorderaobleStateList createState() => _ToDoReorderaobleStateList();
}

class _ToDoReorderaobleStateList extends State<ToDoReorderableList> {
  // List<ToDo> items = [
  //   ToDo(title: 'Groceries'),
  //   ToDo(title: 'Walk Dog', description: 'He gets fussy after 6'),
  //   ToDo(title: 'Shaquille', description: "O'Neal"),
  //   ToDo(
  //       title: 'Shaquille',
  //       description:
  //           "O'NeallllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllNealllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllNeallllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllNealllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllll"),
  // ];

  @override
  Widget build(BuildContext context) {
    return ReorderableListView(
        children: _buildToDoCards(),
        onReorder: (int oldIndex, int newIndex) {
          setState(() {
            if (oldIndex < newIndex) {
              newIndex -= 1;
            }
            items.insert(newIndex, items.removeAt(oldIndex));
          });
        });
  }
}

List<ToDoCard> _buildToDoCards() {
  return items.map((value) => ToDoCard(key: UniqueKey(), todo: value)).toList();
}

void _createToDo() {
  items.add(
      ToDo(title: 'Test me!', description: (Random().nextInt(69)).toString()));
  SharedPrefs().todos = items;
}

void _killToDo(int index) {
  items.removeAt(index);
  SharedPrefs().todos = items;
}
