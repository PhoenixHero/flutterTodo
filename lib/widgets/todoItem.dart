import 'package:flutter/material.dart';
import '../constants/colours.dart';
import '../model/todo.dart';

class TodoItem extends StatelessWidget {
  final Todo todo;
  final onTodoChanged;
  final onTodoDelete;

  const TodoItem({
    Key? key,
    required this.todo,
    required this.onTodoChanged,
    required this.onTodoDelete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 20),
      child: ListTile(
        onTap: () {
          onTodoChanged(todo);
        },
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        tileColor: Colors.white,
        leading: Icon(
            todo.complete ? Icons.check_box : Icons.check_box_outline_blank,
            color: tdblue),
        title: Text(
          todo.text!,
          style: TextStyle(
              fontSize: 16,
              color: tdBlack,
              decoration: todo.complete ? TextDecoration.lineThrough : null),
        ),
        trailing: Container(
          padding: EdgeInsets.all(0),
          height: 35,
          width: 35,
          decoration: BoxDecoration(
              color: tdRed, borderRadius: BorderRadius.circular(5)),
          child: IconButton(
            color: Colors.white,
            iconSize: 18,
            icon: Icon(Icons.delete),
            onPressed: () {
              onTodoDelete(todo.id);
            },
          ),
        ),
      ),
    );
  }
}
