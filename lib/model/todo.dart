import 'dart:convert';

class Todo {
  String? id;
  String? text;
  bool complete;

  Todo({
    required this.id,
    required this.text,
    this.complete = false,
  });
}

String jsonString =
    '[{"text": "foo", "id": "0", "complete": false},{"text": "bar", "id": "1", "complete": false}]';
List<dynamic> jsonList = jsonDecode(jsonString);
List<Todo> getTodo() {
  List<Todo> todoList = [];
  for (int i = 0; i < jsonList.length; i++) {
    todoList.add(Todo(
        id: jsonList[i]['id'],
        text: jsonList[i]['text'],
        complete: jsonList[i]['complete']));
  }
  return todoList;
}
