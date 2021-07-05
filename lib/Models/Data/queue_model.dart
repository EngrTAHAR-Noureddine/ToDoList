import 'dart:convert';

Queue queueFromJson(String str) {
  final jsonData = json.decode(str);
  return Queue.fromMap(jsonData);
}

String queueToJson(Queue data) {
  final dyn = data.toMap();
  return json.encode(dyn);
}

class Queue {
  int id;
  int idTask;
  String task;
  String frequency;
  String status;
  String date;
  String time;


  Queue({
    this.id,
    this.idTask,
    this.task,
    this.frequency,
    this.status,
    this.time,
    this.date,
  });

  factory Queue.fromMap(Map<String, dynamic> json) => new Queue(
    id: json["id"],
    idTask: json["idTask"],
    task: json["task"],
    frequency: json["frequency"],
    status: json["status"],
    time: json["time"],
    date: json["date"],

  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "idTask": idTask,
    "task": task,
    "frequency": frequency,
    "status": status,
    "time": time,
    "date": date,
  };
}