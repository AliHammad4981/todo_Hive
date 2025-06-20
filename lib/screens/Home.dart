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
  void SaveNewTask(){
    setState(() {
      toDoList.add([ToDoController.text, false]);
      Navigator.of(context).pop();
      ToDoController.clear();
    });
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
                          onPressed: () => Navigator.of(context).pop(),
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
