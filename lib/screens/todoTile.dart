import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class todoTile extends StatelessWidget {
  final String TaskName;
  final bool TaskCompleted;
  Function(bool?) onChange;
  Function(BuildContext)? deleteFunction;
  Function(BuildContext)? editFunction;

  todoTile({
    super.key,
    required this.TaskName,
    required this.TaskCompleted,
    required this.onChange,
    required this.deleteFunction,
    required this.editFunction
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(6.0),
      child: Slidable(
        endActionPane: ActionPane(
            motion: StretchMotion(),
            children: [
              SlidableAction(
                spacing: 10,
                borderRadius: BorderRadius.circular(12),
                icon: Icons.edit,
                  backgroundColor: Colors.green,
                  onPressed: editFunction),
              SlidableAction(
                spacing: 100,
                borderRadius: BorderRadius.circular(12),
                icon: Icons.delete,
                  backgroundColor: Colors.red,
                  onPressed: deleteFunction),
            ]),
        child: Container(
          decoration: BoxDecoration(
            color: TaskCompleted == true? Colors.white38 : Colors.white70,
            borderRadius: BorderRadius.circular(12)
          ),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
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
      ),
    );
  }
}
