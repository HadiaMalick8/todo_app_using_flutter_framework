import 'package:flutter/material.dart';

import '../model/todo.dart';
import '../constants/colors.dart';
import '../widgets/todo_item_tile.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final todoList = ToDo.todoList();
  List<ToDo> _foundTasks = [];

  final _todoController = TextEditingController();

  @override
  void initState() {
    _foundTasks = todoList;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: hOrangeLighter,
      appBar: _buildAppBar(),
      body: Stack(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              children: [
                searchBar(),

                Expanded(
                  child: ListView(
                    children: [
                      //Heading Text
                      Container(
                        margin: const EdgeInsets.only(
                          top: 15,
                          bottom: 20,
                        ),
                        child: const Text(
                          'All Tasks',
                          style: TextStyle(
                              fontSize: 25, fontWeight: FontWeight.w400),
                        ),
                      ),

                      for (ToDo todo in _foundTasks.reversed) //Using reversed to show newly added task at top
                        ToDoItemTile(
                          todoItem: todo,
                          onToDoChanged: _handleToDoChange,
                          onDeleteTask: (String? id) {
                            _deleteTask(id!);
                          },
                        )
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
                //TextField to Enter New Task
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 20, right: 20, left: 20),
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.brown,
                          offset: Offset(0.0, 0.0),
                          blurRadius: 10.0,
                          spreadRadius: 0.0,
                        ),
                      ],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: TextField(
                      controller: _todoController,
                      decoration: const InputDecoration(
                          hintText: 'Add a new Task', border: InputBorder.none),
                    ),
                  ),
                ),

                //Plus Button to Add New Task
                Container(
                  margin: const EdgeInsets.only(bottom: 20, right: 20),
                  child: ElevatedButton(
                    onPressed: () {
                      _addNewTask(_todoController.text);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: hOrange,
                      minimumSize: const Size(60, 60),
                      elevation: 10,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                    ),
                    child: const Padding(
                      padding: EdgeInsets.only(bottom: 5.0),
                      child: Text(
                        '+',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 30, color: Colors.white),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget searchBar() {
    return Container(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: TextField(
                  onChanged: (value) => _filterTask(value),
                  decoration: const InputDecoration(
                      suffixIcon: Icon(
                        Icons.search_outlined,
                        color: Colors.grey,
                        size: 20,
                      ),
                      prefixIconConstraints: BoxConstraints(
                        maxHeight: 20,
                        minWidth: 25,
                      ),
                      border: InputBorder.none,
                      hintText: 'Search Here...',
                      hintStyle: TextStyle(color: Colors.grey)),
                ),
              );
  }

  AppBar _buildAppBar() {
    return AppBar(
      centerTitle: true,
      title: const Text(
        'ToDo App',
        style: TextStyle(color: Colors.black),
      ),
      elevation: 0,
      leading: Image.asset('assets/menu.png'),
      backgroundColor: hOrangeLighter,
    );
  }

  void _handleToDoChange(ToDo todo) {
    setState(() {
      todo.isCompleted = !todo.isCompleted;
    });
  }

  void _deleteTask(String? id) {
    setState(() {
      todoList.removeWhere((item) => item.id == id);
    });
  }

  void _addNewTask(todo) {
    setState(() {
      todoList.add(ToDo(
        id: DateTime.now().microsecondsSinceEpoch.toString(),
        todoText: todo,
      ));
    });
    _todoController.clear();
  }

  void _filterTask(String searchedText) {
    List<ToDo> results = [];
    if (searchedText.isEmpty) {
      results = todoList;
    } else {
      results = todoList
          .where((item) =>
              item.todoText!.toLowerCase().contains(searchedText.toLowerCase()))
          .toList();
    }

    setState(() {
      _foundTasks = results;
    });
  }

}
