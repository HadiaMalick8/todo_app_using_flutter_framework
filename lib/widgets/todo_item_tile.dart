import 'package:flutter/material.dart';
import 'package:todo_app/model/todo.dart';
import '../constants/colors.dart';

class ToDoItemTile extends StatelessWidget {
  const ToDoItemTile({
    Key? key,
    required this.todoItem,
    required this.onDeleteTask,
    required this.onToDoChanged,
  }) : super(key: key);

  final ToDo todoItem;
  final Function(ToDo) onToDoChanged;
  final Function(String? id) onDeleteTask;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      child: ListTile(
        onTap: () {
          onToDoChanged(todoItem);
        },
        contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        tileColor: Colors.white,
        leading: Icon(
          todoItem.isCompleted
              ? Icons.check_box
              : Icons.check_box_outline_blank,
          color: hOrange,
        ),
        title: Padding(
          padding: const EdgeInsets.only(left: 10),
          child: Text(
            todoItem.todoText!,
            style: TextStyle(
              fontSize: 16,
              //color: Colors.black,
              decoration:
                  todoItem.isCompleted ? TextDecoration.lineThrough : null,
            ),
          ),
        ),
        trailing: Container(
          height: 35,
          width: 35,
          decoration: BoxDecoration(
            color: hOrange,
            borderRadius: BorderRadius.circular(5),
          ),
          child: IconButton(
            onPressed: () {
              onDeleteTask(todoItem.id);
            },
            color: Colors.white,
            iconSize: 18,
            icon: Icon(Icons.delete),
          ),
        ),
      ),
    );
  }
}
