import 'dart:math';

import 'package:flutter/material.dart';
import 'package:gotta_do_it/util/shared_prefs.dart';

import 'package:gotta_do_it/util/strings.dart';
import 'package:gotta_do_it/util/theme_icon_toggle.dart';
import 'package:gotta_do_it/widget/todo_card.dart';
import 'package:gotta_do_it/model/todo.dart';
import 'package:gotta_do_it/widget/todo_data_holder.dart';
import 'package:provider/provider.dart';

// List<ToDo> items = SharedPrefs().todos;
// final GlobalKey<_ToDoReorderaobleStateList> todoList = GlobalKey();

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
            final dynamic container = StateContainer.of(context);
            List<ToDo> items = container.todos;
            items = _killToDo(items, 0);
            container.updateToDoList(items);
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
            final dynamic container = StateContainer.of(context);
            List<ToDo> items = container.todos;
            items = _createToDo(items);
            container.updateToDoList(items);
          }),
    );
  }
}

class ToDoReorderableList extends StatefulWidget {
  const ToDoReorderableList({Key? key}) : super(key: key);

  @override
  _ToDoReorderaobleStateList createState() => _ToDoReorderaobleStateList();
}

class _ToDoReorderaobleStateList extends State<ToDoReorderableList> {
  @override
  Widget build(BuildContext context) {
    final dynamic container = StateContainer.of(context);
    List<ToDo> items = container.todos;

    return ReorderableListView(
        children: _buildToDoCards(items),
        onReorder: (int oldIndex, int newIndex) {
          setState(() {
            if (oldIndex < newIndex) {
              newIndex -= 1;
            }
            items.insert(newIndex, items.removeAt(oldIndex));
          });
          container.updateToDoList(items);
        });
  }
}

List<ToDoCard> _buildToDoCards(List<ToDo> items) {
  return items.map((value) => ToDoCard(key: UniqueKey(), todo: value)).toList();
}

List<ToDo> _createToDo(List<ToDo> items) {
  items.add(
      ToDo(title: 'Test me!', description: (Random().nextInt(69)).toString()));
  SharedPrefs().todos = items;
  return items;
}

List<ToDo> _killToDo(List<ToDo> items, int index) {
  items.removeAt(index);
  SharedPrefs().todos = items;
  return items;
}
