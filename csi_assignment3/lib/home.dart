import 'dart:js';

import 'package:assignment_3/constants/colors.dart';
import 'package:assignment_3/providers/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'todo.dart';
import 'todo_items.dart';

class home extends StatefulWidget {
  @override
  State<home> createState() => _homeState();
}

class _homeState extends State<home> {
  bool _switchvalue = true;
  final todoslist = Todo.todoList();
  List<Todo> _foundTodo = [];
  final _todoController = TextEditingController();
  @override
  void initState() {
    _foundTodo = todoslist;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      // backgroundColor: tdBGColor,
      appBar: AppBar(
        elevation: 0,
        // backgroundColor,
        title:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          _switchvalue
              ? Icon(Icons.menu, size: 30, color: tdBlack)
              : Icon(Icons.menu, size: 30, color: tdBGColor),
          Container(
            child: Row(
              children: [
                Icon(
                  Icons.nightlight,
                  color: Colors.grey,
                ),
                Switch(
                  value: _switchvalue,
                  onChanged: (newvalue) {
                    setState(() {
                      _switchvalue = newvalue;
                      provider.toggleTheme(_switchvalue);
                    });
                  },
                ),
                Icon(
                  Icons.sunny,
                  color: Colors.yellow,
                ),
              ],
            ),
          ),
          Container(
            height: 40,
            width: 40,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(30),
              child: Image.network(
                './assets/images/avatar.jpg',
                scale: 1,
              ),
            ),
          ),
        ]),
      ),
      body: Stack(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20)),
                  child: TextField(
                    onChanged: (value) => search(value),
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(8),
                      prefixIcon: Icon(
                        Icons.search,
                        color: tdBlack,
                        size: 20,
                      ),
                      prefixIconConstraints:
                          BoxConstraints(maxHeight: 20, maxWidth: 25),
                      border: InputBorder.none,
                      hintText: 'Search',
                      hintStyle: TextStyle(color: tdGrey),
                    ),
                  ),
                ),
                Expanded(
                  child: ListView(
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 50, bottom: 20),
                        child: Text(
                          "Today's Task",
                          style: TextStyle(
                              fontSize: 26, fontWeight: FontWeight.w500),
                        ),
                      ),
                      for (Todo todoo in _foundTodo.reversed)
                        Todoitems(
                          todo: todoo,
                          onTodoChanged: _handleToChange,
                          onDeleteItem: _deleteTodoItem,
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    margin: EdgeInsets.only(bottom: 20, right: 20, left: 20),
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: const [
                          BoxShadow(
                              color: Colors.grey,
                              offset: Offset(0.0, 0.0),
                              blurRadius: 10.0,
                              spreadRadius: 0.0)
                        ],
                        borderRadius: BorderRadius.circular(10.0)),
                    child: TextField(
                      controller: _todoController,
                      decoration: InputDecoration(
                          hintText: 'Add a task',
                          border: InputBorder.none,
                          hintStyle: TextStyle(color: tdGrey)),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 20, right: 20),
                  child: ClipRRect(
                    child: ElevatedButton(
                      onPressed: (() {
                        _addTodoItem(_todoController.text);
                      }),
                      child: Icon(
                        Icons.add,
                        size: 25,
                      ),
                      style: ElevatedButton.styleFrom(
                          primary: tdBlue,
                          minimumSize: Size(60, 60),
                          elevation: 10),
                    ),
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  void _addTodoItem(String todo) {
    setState(() {
      todoslist.add(Todo(
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          todoText: todo));
    });
  }

  void _handleToChange(Todo todo) {
    setState(() {
      todo.isDone = !todo.isDone;
    });
    _todoController.clear();
  }

  void _deleteTodoItem(String id) {
    setState(() {
      todoslist.removeWhere((element) => element.id == id);
    });
  }

  void search(String keyword) {
    List<Todo> results = [];
    if (keyword.isEmpty) {
      results = todoslist;
      // print(results);
    } else {
      results = todoslist
          .where((element) =>
              element.todoText!.toLowerCase().contains(keyword.toLowerCase()))
          .toList();
    }
    setState(() {
      _foundTodo = results;
    });
  }
}
