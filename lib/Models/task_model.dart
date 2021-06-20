import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todolist/DataBase/database.dart';

Task taskFromJson(String str) {
  final jsonData = json.decode(str);
  return Task.fromMap(jsonData);
}

String taskToJson(Task data) {
  final dyn = data.toMap();
  return json.encode(dyn);
}

class Task {
  int id;
  String task;
  String category;
  String note;
  String status;
  String frequency;
  String date;
  String time;
  String dateReminder;
  String timeReminder;
  String goal;


  Task({
    this.id,
    this.task,
    this.category,
    this.note,
    this.status,
    this.frequency,
    this.date,
    this.time,
    this.dateReminder,
    this.timeReminder,
    this.goal,
  });

  factory Task.fromMap(Map<String, dynamic> json) => new Task(
    id: json["id"],
    task: json["task"],
    category: json["category"],
    note: json["note"],
    status: json["status"],
    frequency: json["frequency"],
    date: json["date"],
    time:json["time"],
    timeReminder: json["timeReminder"],
      dateReminder:json["dateReminder"],
      goal:json["goal"],
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "task": task,
    "category": category,
    "note": note,
    "status": status,
    "frequency": frequency,
    "date": date,
    "time":time,
    "dateReminder":dateReminder,
    "timeReminder":timeReminder,
    "goal":goal,
  };
}




Category categoryFromJson(String str) {
  final jsonData = json.decode(str);
  return Category.fromMap(jsonData);
}

String categoryToJson(Category data) {
  final dyn = data.toMap();
  return json.encode(dyn);
}

class Category {
  int count;
  String category;

  Category({
    this.count,
    this.category,
  });

  factory Category.fromMap(Map<String, dynamic> json) => new Category(
    count: json["COUNT(category)"],
    category: json["category"],

  );

  Map<String, dynamic> toMap() => {
    "COUNT(category)": count,
    "category": category,

  };
}

class Item {
  Task task;
  bool isExpanded;


  Item(Task task){
    this.task= task;
    this.isExpanded = false;
  }



  Widget getIcon(){
    switch(this.task.status){
      case "Important": /*C00000*/
        return Icon(Icons.radio_button_off_rounded,color: Color(0xFFC00000),);
        break;
      case "Less important": /* ff4500 */
        return Icon(Icons.radio_button_off_rounded,color: Color(0xFFFF4500));
        break;
      case "Finished"://00B98C
        return Icon(Icons.task_alt_rounded,color: Color(0xFF6D6E70));
        break;
      case "Voluntary": /* 6D6E70 */
        return Icon(Icons.radio_button_off_rounded,color: Color(0xFF6D6E70));
        break;
      default : /* In progress  0269CA */
        return Icon(Icons.radio_button_off_rounded,color: Color(0xFF0269CA));
        break;

    }
  }

}

class TaskFunctions{
  static final TaskFunctions _singleton = TaskFunctions._internal();

  factory TaskFunctions() {
    return _singleton;
  }

  TaskFunctions._internal();


  Future<List<Item>> getList(String name)async{
    DateTime dateNow = DateTime.now();
    List<Task> list =[];
    DateTime tomorrow = DateTime(dateNow.year, dateNow.month, dateNow.day + 1);
    String date ;
    switch(name){
      case "TODAY":
                    date = dateNow.day.toString()+"/"+dateNow.month.toString()+"/"+dateNow.year.toString();
                    list = await DBProvider.db.getByDate(date, date);
                    break;
      case "TOMORROW":
                      date = tomorrow.day.toString()+"/"+tomorrow.month.toString()+"/"+tomorrow.year.toString();
                      list = await DBProvider.db.getByDate(date, date);
                      break;
      default : list = await DBProvider.db.getCategory(name);  break;
    }

    List<Item> items =  (list.isEmpty)?[]:List<Item>.generate(list.length, (int index) {
    return Item(list[index]);
    });
    return items;
  }

}