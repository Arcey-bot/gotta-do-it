import 'package:flutter/material.dart';
import 'package:gotta_do_it/model/todo.dart';

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
