import 'package:flutter/material.dart';
import 'package:todolist/ModelView/tasks_model.dart';

class TodayTasks extends StatefulWidget {


  @override
  _TodayTasksState createState() => _TodayTasksState();
}

class _TodayTasksState extends State<TodayTasks> {
  @override
  Widget build(BuildContext context) {
    return TasksModel();
  }
}
