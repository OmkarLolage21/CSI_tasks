import 'package:assignment_3/constants/colors.dart';
import 'package:assignment_3/todo.dart';
import 'package:flutter/material.dart';

class Todoitems extends StatelessWidget {
  final Todo todo;
  final onTodoChanged;
  final onDeleteItem;
  const Todoitems(
      {super.key, required this.todo, this.onTodoChanged, this.onDeleteItem});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 20),
      child: ListTile(
          onTap: () {
            onTodoChanged(todo);
          },
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          tileColor: Colors.white,
          leading: Icon(
            todo.isDone ? Icons.check_box : Icons.check_box_outline_blank,
            color: tdBlue,
          ),
          title: Text(
            todo.todoText!,
            style: TextStyle(
                fontSize: 16,
                color: tdBlack,
                decoration: todo.isDone ? TextDecoration.lineThrough : null),
          ),
          trailing: Container(
            child: IconButton(
              color: tdRed,
              iconSize: 22,
              icon: Icon(Icons.delete),
              onPressed: (() {
                onDeleteItem(todo.id);
              }),
            ),

            // trailing: Container(
            //   height: 35,
            //   width: 35,
            //   decoration: BoxDecoration(
            //       color: tdRed, borderRadius: BorderRadius.circular(5)),
            //   child: IconButton(
            //     color: Colors.white,
            //     icon: Icon(Icons.delete),
            //     onPressed: () {},
            //   ),
            // ),
          )),
    );
  }
}
