import 'dart:convert';

User userFromJson(String str) {
  final jsonData = json.decode(str);
  return User.fromMap(jsonData);
}

String userToJson(User data) {
  final dyn = data.toMap();
  return json.encode(dyn);
}

class User {
  int id;
  String darkMode;
  String passWord;
  String linkAgenda;



  User({
    this.id,
    this.darkMode,
    this.passWord,
    this.linkAgenda,

  });

  factory User.fromMap(Map<String, dynamic> json) => new User(
    id: json["id"],
    darkMode: json["darkMode"],
    passWord: json["passWord"],
    linkAgenda: json["linkAgenda"],

  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "darkMode": darkMode,
    "passWord": passWord,
    "linkAgenda": linkAgenda,

  };
}