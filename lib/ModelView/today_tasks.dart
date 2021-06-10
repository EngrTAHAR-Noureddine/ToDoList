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
  Widget todayTask(){
    return Column(
      children: [
        Text("Today Tasks"),
        Expanded(
            child:
        ),
      ],
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    _isLarge = widget.isLarge;
  }
  @override
  Widget build(BuildContext context) {
    initState();

    return PageView(
      children: <Widget>[
        Container(
          color: Colors.pink,
        ),
        Container(
          color: Colors.cyan,
        ),

      ],
    );
  }
}
