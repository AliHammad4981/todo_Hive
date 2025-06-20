import 'package:hive_flutter/hive_flutter.dart';

class todoDatabase {
  final _myBox = Hive.box('MyBox');
  List toDoList = [
  ];

  void createInitialData(){
    List toDoList = [
      ["Make App", true],
      ["Add Task", false],
    ];
  }

  void LoadData(){
    toDoList = _myBox.get("TODOLIST");
  }
  void UpdateDatabase(){
    _myBox.put("TODOLIST", toDoList);
  }
}