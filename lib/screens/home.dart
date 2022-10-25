import 'dart:convert';

import 'package:flutter/material.dart';
import '../widgets/todoItem.dart';
import '../constants/colours.dart';
import '../model/todo.dart';

class Home extends StatefulWidget {
  Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Todo> todoList = getTodo();
  List<Todo> foundTodo = [];
  final todoConntroller = TextEditingController();

  @override
  void initState() {
    foundTodo = todoList;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: tdBG,
      appBar: _buildAppBar(),
      body: Stack(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            child: Column(
              children: [
                searchBox(),
                Expanded(
                  child: ListView(
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 50, bottom: 20),
                        child: const Text(
                          "All Items",
                          style: TextStyle(
                              fontSize: 30, fontWeight: FontWeight.w500),
                        ),
                      ),
                      for (Todo todo in foundTodo)
                        TodoItem(
                          todo: todo,
                          onTodoChanged: _todoChange,
                          onTodoDelete: _todoDelete,
                        ),
                    ],
                  ),
                )
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Row(children: [
              Expanded(
                  child: Container(
                      margin: const EdgeInsets.only(
                          bottom: 20, right: 20, left: 20),
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey,
                            offset: Offset(0.0, 0.0),
                            blurRadius: 10.0,
                            spreadRadius: 0.0,
                          )
                        ],
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: TextField(
                        controller: todoConntroller,
                        decoration: InputDecoration(
                          hintText: 'Add a new item',
                          border: InputBorder.none,
                        ),
                      ))),
              Container(
                margin: EdgeInsets.only(bottom: 20, right: 20),
                child: ElevatedButton(
                  child: Text(
                    '+',
                    style: TextStyle(fontSize: 40),
                  ),
                  onPressed: () {
                    _todoAdd(todoConntroller.text);
                  },
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.all(0),
                    backgroundColor: tdblue,
                    minimumSize: Size(60, 60),
                    elevation: 10,
                  ),
                ),
              ),
            ]),
          )
        ],
      ),
    );
  }

  Widget searchBox() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(20)),
      child: TextField(
        onChanged: (value) => filter(value),
        decoration: InputDecoration(
            contentPadding: EdgeInsets.all(0),
            prefixIcon: Icon(Icons.search, color: tdBlack, size: 20),
            prefixIconConstraints: BoxConstraints(
              maxHeight: 20,
              minWidth: 25,
            ),
            border: InputBorder.none,
            hintText: "Search",
            hintStyle: TextStyle(color: tdGrey)),
      ),
    );
  }

  void _todoChange(Todo todo) {
    setState(() {
      todo.complete = !todo.complete;
    });
    jsonString = jsonEncode(todoList);
  }

  void _todoDelete(String id) {
    setState(() {
      todoList.removeWhere((element) => element.id == id);
    });
    jsonString = jsonEncode(todoList);
  }

  void _todoAdd(String toDo) {
    setState(() {
      todoList.add(Todo(
          id: DateTime.now().millisecondsSinceEpoch.toString(), text: toDo));
    });
    todoConntroller.clear();
    jsonString = jsonEncode(todoList);
  }

  void filter(String keyword) {
    List<Todo> results = [];
    if (keyword.isEmpty) {
      results = todoList;
    } else {
      results = todoList
          .where((element) =>
              element.text!.toLowerCase().contains(keyword.toLowerCase()))
          .toList();
    }

    setState(() {
      foundTodo = results;
    });
  }

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: tdBG,
      elevation: 0,
      title: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        const Icon(
          Icons.menu,
          color: tdBlack,
          size: 30,
        ),
        Container(
            height: 40,
            width: 40,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.asset("assets/avatar.jpeg"),
            ))
      ]),
    );
  }
}
