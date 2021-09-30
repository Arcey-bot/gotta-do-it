import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:gotta_do_it/model/todo.dart';
import 'package:gotta_do_it/widget/todo_data_holder.dart';

class ToDoCard extends StatelessWidget {
  final ToDo todo;
  final bool isDark;
  const ToDoCard({Key? key, required this.todo, required this.isDark})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Card(
        elevation: 4.0,
        child: Dismissible(
          key: UniqueKey(),
          resizeDuration: const Duration(milliseconds: 500),
          background:
              Container(color: !isDark ? Colors.grey[900] : Colors.grey[200]),
          onDismissed: ((dir) {
            StateContainer.of(context).removeToDo(todo);
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text('${todo.title} removed')));
          }),
          child: Center(
            child: Stack(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    ToDoToggleButton(task: todo),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ToDoText(
                          task: todo,
                        ),
                      ),
                    ),
                  ],
                ),
                Positioned(
                  bottom: 1.0,
                  right: 2.0,
                  child: ToDoTimestamp(time: todo.timeCreated),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ToDoToggleButton extends StatefulWidget {
  final ToDo task;
  const ToDoToggleButton({
    Key? key,
    required this.task,
  }) : super(key: key);

  @override
  _ToDoToggleButtonState createState() => _ToDoToggleButtonState();
}

class _ToDoToggleButtonState extends State<ToDoToggleButton> {
  @override
  Widget build(BuildContext context) {
    return Checkbox(
      value: widget.task.done,
      onChanged: (bool? value) {
        setState(() {
          widget.task.done = value!;
          StateContainer.of(context).removeToDo(widget.task);
        });
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('${widget.task.title} completed')));
        // StateContainer.of(context).toDoComplete(widget.task, value!);
      },
    );
  }
}

class ToDoText extends StatelessWidget {
  final ToDo task;
  const ToDoText({Key? key, required this.task}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.topStart,
      children: <Widget>[
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              task.title,
              softWrap: true,
              style: const TextStyle(
                color: Colors.blueAccent,
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              task.description,
              softWrap: true,
            ),
          ],
        ),
      ],
    );
  }
}

class ToDoTimestamp extends StatelessWidget {
  final String time;
  const ToDoTimestamp({Key? key, required this.time}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      time,
      style: const TextStyle(
        fontStyle: FontStyle.italic,
        fontSize: 9.0,
      ),
    );
  }
}

class ToDoPin extends StatefulWidget {
  const ToDoPin({Key? key}) : super(key: key);

  @override
  _ToDoPinState createState() => _ToDoPinState();
}

class _ToDoPinState extends State<ToDoPin> {
  bool isToggled = false;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      color: isToggled ? Colors.orangeAccent : Colors.black,
      icon: const Icon(Icons.push_pin_outlined),
      onPressed: () {
        setState(() {
          isToggled = !isToggled;
        });
      },
    );
  }
}
