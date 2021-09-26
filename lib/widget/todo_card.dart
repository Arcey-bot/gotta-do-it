import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:gotta_do_it/model/todo.dart';

class ToDoCard extends StatelessWidget {
  final ToDo todo;
  const ToDoCard({Key? key, required this.todo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4.0,
      child: Center(
        child: Row(
          children: <Widget>[
            const ToDoToggleButton(),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ToDoBody(
                  task: todo,
                ),
              ),
            ),
            //const ToDoPin(),
          ],
        ),
      ),
    );
  }
}

class ToDoToggleButton extends StatefulWidget {
  const ToDoToggleButton({Key? key}) : super(key: key);

  @override
  _ToDoToggleButtonState createState() => _ToDoToggleButtonState();
}

class _ToDoToggleButtonState extends State<ToDoToggleButton> {
  bool isToggled = false;

  @override
  Widget build(BuildContext context) {
    return Checkbox(
      value: isToggled,
      onChanged: (bool? value) {
        setState(() {
          isToggled = value!;
        });
      },
    );
  }
}

class ToDoBody extends StatelessWidget {
  final ToDo task;
  const ToDoBody({Key? key, required this.task}) : super(key: key);

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
            Text(task.description),
          ],
        ),
        Positioned(
          bottom: 1.0,
          right: 1.0,
          child: ToDoTimestamp(time: task.timeCreated),
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
    return Text(time);
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