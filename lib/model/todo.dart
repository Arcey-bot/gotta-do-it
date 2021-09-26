class ToDo {
  String title;
  String description;
  String timeCreated = DateTime.now().toLocal().toString();

  ToDo({required this.title, this.description = ''});

  ToDo.fromMap(Map map)
      : title = map['title'],
        description = map['description'],
        timeCreated = map['timeCreated'];

  Map toMap() {
    return {
      'title': title,
      'description': description,
      'timeCreated': timeCreated,
    };
  }
}
