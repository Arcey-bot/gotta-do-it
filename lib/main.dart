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
                home: Scaffold(
                  appBar: AppBar(
                    title: const Text(
                      Strings.appTitle,
                    ),
                    leading: IconButton(
                      onPressed: () {
                        final _StateContainerState container =
                            StateContainer.of(context);
                        List<ToDo> items = container.todos;
                        print('kill - ' + container.toString());
                        print('kill - ' + items.toString());
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
                        final _StateContainerState container =
                            StateContainer.of(context);
                        List<ToDo> items = container.todos;
                        print('Add - ' + container.toString());
                        print('Add - ' + items.toString());
                        items = _createToDo(items);
                        container.updateToDoList(items);
                      }),
                ),
              );
            }),
      );
}

class ToDoReorderableList extends StatefulWidget {
  const ToDoReorderableList({Key? key}) : super(key: key);

  @override
  _ToDoReorderaobleStateList createState() => _ToDoReorderaobleStateList();
}

class _ToDoReorderaobleStateList extends State<ToDoReorderableList> {
  @override
  Widget build(BuildContext context) {
    final _StateContainerState container = StateContainer.of(context);
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

/* This Widget wraps around the InheritedWidget and essentially
  allows the InheritedWidet to be treated like a mutable object.
  Have this Widget take whatever data you can immediately make
  available */
class StateContainer extends StatefulWidget {
  static _StateContainerState of(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<InheritedData>()!
        .stateWidget;
  }

  const StateContainer({Key? key, required this.child}) : super(key: key);

  final Widget child;

  @override
  _StateContainerState createState() => _StateContainerState();
}

class _StateContainerState extends State<StateContainer> {
  List<ToDo> todos = List.empty(growable: true);

  void updateToDoList(List<ToDo> newTodos) {
    print('updateToDoList - ' + newTodos.toString());
    setState(() {
      todos = newTodos;
    });
  }

  @override
  Widget build(BuildContext context) {
    print('_StateContainerState build - ' + todos.toString());
    return InheritedData(
      todos: todos,
      stateWidget: this,
      child: widget.child,
    );
  }
}

/* This is similar to a global variable. A root widget that any
   child Widget can access and use to retrive data/force redraws*/
class InheritedData extends InheritedWidget {
  final List<ToDo> todos;
  final _StateContainerState stateWidget;

  const InheritedData({
    Key? key,
    required this.todos,
    required this.stateWidget,
    required Widget child,
  })  : assert(todos != null),
        assert(stateWidget != null),
        assert(child != null),
        super(key: key, child: child);

  static _StateContainerState of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<InheritedData>()!.stateWidget;

  @override
  bool updateShouldNotify(InheritedData oldWidget) {
    print('Updateshouldnotify - ' + todos.toString());
    // return oldWidget.todos != todos || oldWidget.onToDoUpdate != onToDoUpdate;
    return true;
  }
}
