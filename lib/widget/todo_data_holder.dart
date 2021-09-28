import 'package:flutter/material.dart';

import 'package:gotta_do_it/model/todo.dart';
import 'package:gotta_do_it/util/shared_prefs.dart';

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
  List<ToDo> todos = SharedPrefs().todos;

  void updateToDoList(List<ToDo> newTodos) {
    setState(() {
      todos = newTodos;
    });
  }

  @override
  Widget build(BuildContext context) {
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
  }) : super(key: key, child: child);

  static _StateContainerState of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<InheritedData>()!.stateWidget;

  @override
  bool updateShouldNotify(InheritedData oldWidget) {
    return oldWidget.todos != todos;
    // return true;
  }
}
