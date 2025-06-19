import 'dart:ffi';

import 'package:flutter/material.dart';

class todoTile extends StatelessWidget {
  final String TaskName;
  final bool TaskCompleted;
  Function(bool?) onChange;


  todoTile({super.key, required this.TaskName, required this.TaskCompleted, required this.onChange});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.yellow,
          borderRadius: BorderRadius.circular(12)
        ),
        child: Padding(
          padding: const EdgeInsets.all(22.0),
          child: Row(
            children: [
              Checkbox(value: TaskCompleted, onChanged: onChange, activeColor: Colors.black,),
              Text(TaskName,
              style: TextStyle(
                fontSize: 18,
                decoration: TaskCompleted? TextDecoration.lineThrough : TextDecoration.none
              ),)
            ],
          ),
        ),
      ),
    );
  }
}
