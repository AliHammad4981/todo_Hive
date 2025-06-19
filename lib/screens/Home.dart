import 'package:flutter/material.dart';
import 'package:todo_hive/screens/todoTile.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List toDoList = [
    ["Make App", true],
    ["Add Task", false],
  ];
  void CheckBoxChanged(bool? Value, int index)
  {
    setState(() {
      toDoList[index][1] = !toDoList[index][1];
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow[200],
      appBar: AppBar(
        backgroundColor: Colors.yellow,
        title: Text("To Do",style: TextStyle(
          fontWeight: FontWeight.bold,
        ),),

        centerTitle: true,
      ),
      body: ListView.builder(
          itemCount: toDoList.length,
          itemBuilder: (context, index){
        return todoTile(
            TaskName: toDoList[index][0],
            TaskCompleted: toDoList[index][1],
            onChange: (value) => CheckBoxChanged(value, index),
        );
      })
    );
  }
}
