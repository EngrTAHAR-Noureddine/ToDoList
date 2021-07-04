import 'dart:convert';

Goal goalFromJson(String str) {
  final jsonData = json.decode(str);
  return Goal.fromMap(jsonData);
}

String goalToJson(Goal data) {
  final dyn = data.toMap();
  return json.encode(dyn);
}

class Goal {
  int id;
  String goal;
  String reason;
  String note;



  Goal({
    this.id,
    this.goal,
    this.reason,
    this.note,

  });

  factory Goal.fromMap(Map<String, dynamic> json) => new Goal(
    id: json["id"],
    goal: json["goal"],
    reason: json["reason"],
    note: json["note"],

  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "goal": goal,
    "reason": reason,
    "note": note,

  };
}