import 'dart:convert';

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

  Task({
    this.id,
    this.task,
    this.category,
    this.note,
    this.status,
    this.frequency,
    this.date,
  });

  factory Task.fromMap(Map<String, dynamic> json) => new Task(
    id: json["id"],
    task: json["task"],
    category: json["category"],
    note: json["note"],
    status: json["status"],
    frequency: json["frequency"],
    date: json["date"],

  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "task": task,
    "category": category,
    "note": note,
    "status": status,
    "frequency": frequency,
    "date": date,
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