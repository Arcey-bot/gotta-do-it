import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:gotta_do_it/model/todo.dart';
import 'package:gotta_do_it/widget/todo_data_holder.dart';

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
            ToDoToggleButton(task: todo),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ToDoBody(
                  task: todo,
                ),
              ),
            ),
            ToDoDeleteButton(task: todo),
          ],
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
        });
      },
    );
  }
}

// TODO: Move timestamp out of body into card
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

class ToDoDeleteButton extends StatefulWidget {
  final ToDo task;
  const ToDoDeleteButton({Key? key, required this.task}) : super(key: key);

  @override
  _ToDoDeleteButtonState createState() => _ToDoDeleteButtonState();
}

class _ToDoDeleteButtonState extends State<ToDoDeleteButton> {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.delete_outlined),
      onPressed: () {
        StateContainer.of(context).removeToDo(widget.task);
      },
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
