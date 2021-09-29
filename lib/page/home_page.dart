import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:gotta_do_it/model/todo.dart';
import 'package:gotta_do_it/page/add_todo_popup.dart';
import 'package:gotta_do_it/provider/theme_provider.dart';
import 'package:gotta_do_it/route/custom_route.dart';
import 'package:gotta_do_it/util/strings.dart';
import 'package:gotta_do_it/util/theme_icon_toggle.dart';
import 'package:gotta_do_it/widget/todo_card.dart';
import 'package:gotta_do_it/widget/todo_data_holder.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          Strings.appTitle,
        ),
        actions: const <Widget>[
          ThemeIconToggle(),
        ],
      ),
      body: const Padding(
        padding: EdgeInsets.symmetric(vertical: 8.0),
        child: ToDoReorderableList(),
      ),
      floatingActionButton: FloatingActionButton.small(
          child: const Icon(Icons.add),
          onPressed: () {
            Navigator.of(context).push(CustomRoute(builder: (context) {
              return const AddToDoPopup();
            }));
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
    final isDark = Provider.of<ThemeProvider>(context).isDarkMode;
    final dynamic container = StateContainer.of(context);
    List<ToDo> items = container.todos;

    return ReorderableListView(
        children: _buildToDoCards(items, isDark),
        onReorder: (int oldIndex, int newIndex) {
          setState(() {
            if (oldIndex < newIndex) {
              newIndex -= 1;
            }
            items.insert(newIndex, items.removeAt(oldIndex));
          });
          container.replaceToDoList(items);
        });
  }
}

List<ToDoCard> _buildToDoCards(List<ToDo> items, bool isDark) {
  return items
      .map((value) => ToDoCard(
            key: UniqueKey(),
            todo: value,
            isDark: isDark,
          ))
      .toList();
}
