import 'package:flutter/material.dart';
import 'package:todolist/DataBase/database.dart';
import 'package:todolist/Models/Data/draft_model.dart';
import 'package:todolist/Models/Data/task_model.dart';

class NewTaskProvider extends ChangeNotifier{
  static final NewTaskProvider _singleton = NewTaskProvider._internal();
  factory NewTaskProvider() {
    return _singleton;
  }
  NewTaskProvider._internal();

  Task task;




  setTask(task){
    this.task = task;
  }


}