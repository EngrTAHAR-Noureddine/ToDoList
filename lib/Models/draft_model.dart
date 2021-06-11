//Draft

import 'dart:convert';

Draft draftFromJson(String str) {
  final jsonData = json.decode(str);
  return Draft.fromMap(jsonData);
}

String taskToJson(Draft data) {
  final dyn = data.toMap();
  return json.encode(dyn);
}

class Draft {
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


  Draft({
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

  factory Draft.fromMap(Map<String, dynamic> json) => new Draft(
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


