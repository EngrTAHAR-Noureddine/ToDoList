import 'package:flutter/material.dart';
import 'package:todolist/DataBase/database.dart';
import 'package:todolist/Models/Data/data_variable.dart';
import 'package:todolist/Models/Data/queue_model.dart';
import 'package:todolist/Models/Data/task_model.dart';

class NotificationProvider extends ChangeNotifier{
  static final NotificationProvider _singleton = NotificationProvider._internal();
  factory NotificationProvider() {
    return _singleton;
  }
  NotificationProvider._internal();

  List<Queue> listQueues;
  bool isUnread;
  int number;
  setList(List<Queue> list){
    this.listQueues = list;
    this.number=list.length;

    notifyListeners();
  }
  int getNumber(){
    return this.number;
  }
  List<Queue> getList(){
    return this.listQueues;
  }

  Future<void> clickInProgress(context ,int id)async{
    Task task = await DBProvider.db.getTask(id);
    if(task != null) {
      task.status = Variables().status[2];
      await DBProvider.db.updateTask(task);
    }
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text('The task is in progress')));
    notifyListeners();
  }
  Future<void> clickFinished(context ,int id)async{
    Task task = await DBProvider.db.getTask(id);
    if(task != null) {
      task.status = Variables().status[3];
      await DBProvider.db.updateTask(task);
    }
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text('The task is finished')));
    notifyListeners();
  }
}