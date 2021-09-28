class ToDo {
  String title;
  String description;
  String timeCreated = DateTime.now().toLocal().toString();
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
