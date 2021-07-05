import 'package:flutter/material.dart';
import 'package:todolist/Models/Data/queue_model.dart';

class NotificationProvider extends ChangeNotifier{
  static final NotificationProvider _singleton = NotificationProvider._internal();
  factory NotificationProvider() {
    return _singleton;
  }
  NotificationProvider._internal();

  List<Queue> listQueues;
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
}