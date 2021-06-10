import 'package:flutter/material.dart';
import 'package:todolist/DataBase/database.dart';
import 'package:todolist/Models/task_model.dart';

class TodayTasks extends StatefulWidget {
bool isLarge;
TodayTasks({this.isLarge});
  @override
  _TodayTasksState createState() => _TodayTasksState();
}

class _TodayTasksState extends State<TodayTasks> {
  bool _isLarge;
  @override
  void initState() {
    // TODO: implement initState
    _isLarge = widget.isLarge;
  }
  @override
  Widget build(BuildContext context) {
    initState();

    return _VarticalLayout().build(context);
  }
}

class _VarticalLayout extends StatefulWidget{

  Widget build(BuildContext context){
    return Container(
      color: Colors.red,
      width: MediaQuery.of(context).size.width,
      height: 500,
      child: MaterialButton(
        child: Text("Add"),
        onPressed: (){
          for(int i=0; i< 20; i++){
            DBProvider.db.newTask(new Task(category:"Cat"+i.toString(),date: 2,frequency: "fre",note: "note",status: "status",task: "task"));
          }
          for(int j=0; j<5;j++){
            DBProvider.db.newTask(new Task(category:"Cat0",date: 2,frequency: "fre",note: "note",status: "status",task: "task"));
          }
        },
      ),

    );
  }

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    throw UnimplementedError();
  }
}
