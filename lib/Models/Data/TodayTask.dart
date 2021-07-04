import 'dart:convert';

TodayTask todayTaskFromJson(String str) {
  final jsonData = json.decode(str);
  return TodayTask.fromMap(jsonData);
}

String todayTaskToJson(TodayTask data) {
  final dyn = data.toMap();
  return json.encode(dyn);
}

class TodayTask {
  int id;
  String task;
  String category;
  String note;
  String status;
  String frequency;
  String goal;
  String date;
  int hour;
  int minute;
  int idTask;
  int inMinute;



  TodayTask({
    this.id,
    this.minute,
    this.hour,

    this.inMinute,
    this.date,
    this.task,

    this.status,
    this.frequency,
    this.category,

    this.idTask,
    this.goal,
    this.note,

  });

  factory TodayTask.fromMap(Map<String, dynamic> json) => new TodayTask(
    id: json["id"],
    goal: json["goal"],
    task: json["task"],

    minute: json["minute"],
    hour: json["hour"],
    inMinute: json["inMinute"],

    date: json["date"],
    status: json["status"],
    frequency: json["frequency"],

    category: json["category"],
    idTask: json["idTask"],
    note: json["note"],


  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "goal": goal,
    "task": task,

    "minute": minute,
    "hour": hour,
    "inMinute": inMinute,

    "date": date,
    "status": status,
    "frequency": frequency,

    "category": category,
    "idTask": idTask,
    "note": note,
  };
}