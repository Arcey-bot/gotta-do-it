import 'package:intl/intl.dart';

class ToDo {
  // final DateFormat _dateFormat = DateFormat('MMM dd, yyyy');
  String title;
  String description;
  String timeCreated =
      DateFormat('MMM dd, yyyy').format(DateTime.now().toLocal());
  bool done;

  ToDo({required this.title, this.description = '', this.done = false});

  ToDo.fromMap(Map map)
      : title = map['title'],
        description = map['description'],
        timeCreated = map['timeCreated'],
        done = map['done'];

  Map toMap() {
    return {
      'title': title,
      'description': description,
      'timeCreated': timeCreated,
      'done': done,
    };
  }

  String show() => '$title/$description/$done';
}
