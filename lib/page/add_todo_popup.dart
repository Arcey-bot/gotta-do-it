import 'package:flutter/material.dart';

import 'package:gotta_do_it/model/todo.dart';
import 'package:gotta_do_it/widget/todo_data_holder.dart';

TextEditingController title = TextEditingController();
TextEditingController description = TextEditingController();

class AddToDoPopup extends StatelessWidget {
  const AddToDoPopup({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Material(
          elevation: 8.0,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                const Text(
                  'New ToDo',
                  textScaleFactor: 2.0,
                ),
                const Divider(
                  thickness: 0.8,
                ),
                TextField(
                  minLines: 1,
                  maxLines: 3,
                  controller: title,
                  decoration: const InputDecoration(
                    hintText: 'Go to the store',
                    hintStyle: TextStyle(
                      color: Colors.grey,
                      fontStyle: FontStyle.italic,
                    ),
                    filled: true,
                    border: InputBorder.none,
                  ),
                ),
                const Divider(),
                TextField(
                  minLines: 3,
                  maxLines: 9,
                  controller: description,
                  decoration: const InputDecoration(
                    hintText: 'Get milk, eggs, cheese...',
                    hintStyle: TextStyle(
                      color: Colors.grey,
                      fontStyle: FontStyle.italic,
                    ),
                    filled: true,
                    border: InputBorder.none,
                  ),
                ),
                TextButton(
                    onPressed: () {
                      StateContainer.of(context).addToDo(ToDo(
                          title: title.text, description: description.text));
                      title.clear();
                      description.clear();
                      Navigator.of(context).pop();
                    },
                    child: const Text('Save')),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
