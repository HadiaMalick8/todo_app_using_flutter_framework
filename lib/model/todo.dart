import 'package:flutter/material.dart';

class ToDo{

  String? id;
  String? todoText;
  bool isCompleted;

  ToDo({
    required this.id,
    required this.todoText,
    this.isCompleted = false,
  });

  static List<ToDo> todoList(){
    return [
      ToDo(id: '1', todoText: 'Check Email',),
      // ToDo(id: '2', todoText: 'Breakfast', isCompleted: true),
      // ToDo(id: '3', todoText: 'Workout'),
    ];
  }
}