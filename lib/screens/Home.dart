import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo_hive/screens/todoTile.dart';
import 'package:todo_hive/screens/todo_database.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _myBox = Hive.box('MyBox');
  todoDatabase db = todoDatabase();
  @override
  void initState() {
    if(_myBox.get("TODOLIST")==null){
      db.createInitialData();
    }else
      {
        db.LoadData();
      }
  }
  void CheckBoxChanged(bool? Value, int index)
  {
    setState(() {
      db.toDoList[index][1] = !db.toDoList[index][1];
      db.UpdateDatabase();
    });
  }
  void SaveNewTask(){
    setState(() {
      db.toDoList.add([ToDoController.text, false]);
      Navigator.of(context).pop();
      ToDoController.clear();
      db.UpdateDatabase();
    });
  }
  void deleteTask(int index){
    setState(() {
      db.toDoList.removeAt(index);
      db.UpdateDatabase();
    });
  }
  void editTask(int index) {
    ToDoController.text = db.toDoList[index][0]; // Pre-fill current task name
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.deepPurple[300],
          content: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: 120,
              child: Column(
                children: [
                  TextField(
                    controller: ToDoController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(
                          width: 5,
                          color: Colors.white,
                        ),
                      ),
                      hintText: "Edit To Do",
                      hintStyle: TextStyle(color: Colors.white),
                    ),
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      MaterialButton(
                        color: Colors.deepPurple,
                        onPressed: () {
                          Navigator.of(context).pop();
                          ToDoController.clear();
                        },
                        child: Text('Cancel', style: TextStyle(color: Colors.white)),
                      ),
                      SizedBox(width: 5),
                      MaterialButton(
                        color: Colors.deepPurple,
                        onPressed: () {
                          setState(() {
                            db.toDoList[index][0] = ToDoController.text;
                            db.UpdateDatabase();
                            ToDoController.clear();
                          });
                          Navigator.of(context).pop();
                        },
                        child: Text("Save", style: TextStyle(color: Colors.white)),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
  TextEditingController ToDoController = TextEditingController();
  void CreateNewTask(){
    showDialog(
        context: context,
        builder: (context){
          return AlertDialog(
            backgroundColor: Colors.deepPurple[300],
            content: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 120,
                child: Column(
                  children: [
                    TextField(
                      controller: ToDoController,
                      decoration: InputDecoration(border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(
                          width: 5,
                          color: Colors.white
                        )
                      ),
                          hintText: "Add New To Do",
                        hintStyle: TextStyle(color: Colors.white)
                      ),
                    ),
                    SizedBox(height: 10,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        MaterialButton(
                          color: Colors.deepPurple,
                          onPressed: () {
                          Navigator.of(context).pop();
                          ToDoController.clear();
                          },
                          child: Text('Cancel',style: TextStyle(color: Colors.white),),
                        ),
                        SizedBox(width: 5,),
                        MaterialButton(
                          color: Colors.deepPurple,
                            onPressed:SaveNewTask,
                        child:Text("Save",style: TextStyle(color: Colors.white),)),
                      ],
                    )
                  ],
                ),
              ),
            ),
          );
        }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple[300],
      appBar: AppBar(
        backgroundColor: Colors.deepPurple[600],
        title: Text("To Do",style: TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.white
        ),),

        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: CreateNewTask,
        child: Icon(Icons.add,size: 30,),
      ),
        body: ListView(
          children: [
            SizedBox(height: 10,),
            // Uncompleted Tasks
            if (db.toDoList.any((task) => task[1] == false)) ...[
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Center(
                  child: Text(
                    "Pending Tasks",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              ...db.toDoList.asMap().entries.where((entry) => entry.value[1] == false).map((entry) {
                int index = entry.key;
                return todoTile(
                  TaskName: entry.value[0],
                  TaskCompleted: entry.value[1],
                  onChange: (value) => CheckBoxChanged(value, index),
                  deleteFunction: (context) => deleteTask(index),
                  editFunction: (context) => editTask(index),
                );
              }).toList(),
            ],

            // Divider
            if (db.toDoList.any((task) => task[1] == true)) ...[
              Divider(
                color: Colors.white70,
                thickness: 1,
                indent: 20,
                endIndent: 20,
                height: 40,
              ),
              // Padding(
              //   padding: const EdgeInsets.all(10.0),
              //   child: Center(
              //     child: Text(
              //       "Completed Tasks",
              //       style: TextStyle(
              //         fontSize: 18,
              //         fontWeight: FontWeight.bold,
              //         color: Colors.white,
              //       ),
              //     ),
              //   ),
              // ),
              ...db.toDoList.asMap().entries.where((entry) => entry.value[1] == true).map((entry) {
                int index = entry.key;
                return todoTile(
                  TaskName: entry.value[0],
                  TaskCompleted: entry.value[1],
                  onChange: (value) => CheckBoxChanged(value, index),
                  deleteFunction: (context) => deleteTask(index),
                  editFunction: (context) => editTask(index),
                );
              }).toList(),
            ],
          ],
        ),

    );
  }
}
