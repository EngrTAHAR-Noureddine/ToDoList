import 'dart:io';


import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todolist/Models/goal_model.dart';
import 'package:todolist/Models/task_model.dart';
import 'package:todolist/Models/user_model.dart';

class DBProvider {
  DBProvider._();
  static final DBProvider db = DBProvider._();
  static Database _database;

  Future<Database> get database async {
    // ignore: unnecessary_null_comparison
    if (_database != null)
      return _database;

    // if _database is null we instantiate it
    _database = await initDB();
    return _database;
  }


  initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "ToDoListDB.db");
    return await openDatabase(path, version: 1, onOpen: (db) {
    }, onCreate: (Database db, int version) async {
      await db.execute("CREATE TABLE Task ("
          "id INTEGER PRIMARY KEY,"
          "task TEXT,"
          "category TEXT,"
          "note TEXT,"
          "status TEXT,"
          "frequency TEXT,"
          "date TEXT,"
          "time TEXT,"
          "goal TEXT,"
          "dateReminder TEXT,"
          "timeReminder TEXT"
          ")");

      await db.execute("CREATE TABLE Goal ("
          "id INTEGER PRIMARY KEY,"
          "goal TEXT,"
          "reason TEXT,"
          "note TEXT"
          ")");
      await db.execute("CREATE TABLE Draft  ("
          "id INTEGER PRIMARY KEY,"
          "task TEXT,"
          "category TEXT,"
          "note TEXT,"
          "status TEXT,"
          "frequency TEXT,"
          "date TEXT,"
          "time TEXT,"
          "dateReminder TEXT,"
          "timeReminder TEXT"
          ")");
      await db.execute("CREATE TABLE User  ("
          "id INTEGER PRIMARY KEY,"
          "darkMode TEXT,"
          "passWord TEXT,"
          "linkAgenda TEXT"
          ")");
    });


  }

//insert new task
  newTask(Task newTask) async {
    final db = await database;
    var res = await db.insert("Task", newTask.toMap());
    return res;
  }
  // get task with id
  getTask(int id) async {
    final db = await database;
    var res =await  db.query("Task", where: "id = ?", whereArgs: [id]);
    return res.isNotEmpty ? Task.fromMap(res.first) : Null ;
  }
//get all tasks  with category
  Future<List<Task>> getCategory(String category) async {
    final db = await database;
    var res = await db.query("Task", where: "category = ?", whereArgs: [category]);
    List<Task> list =
    res.isNotEmpty ? res.map((c) => Task.fromMap(c)).toList() : [];
    return list;
  }
  Future<List<Task>> getTemporary(String temporary) async {
    final db = await database;
    var res = await db.query("Task", where: "status = ?", whereArgs: [temporary]);
    List<Task> list =
    res.isNotEmpty ? res.map((c) => Task.fromMap(c)).toList() : [];
    return list;
  }
  Future<List<dynamic>> getCategories() async {
    final db = await database;
    var res = await db.rawQuery("SELECT COUNT(category), category FROM Task GROUP BY category");
    List<dynamic> list =
    res.isNotEmpty ? res.toList() : [];
    return list;
  }



  //get all tasks with search by task name
  Future<List<Task>> getAllSearch(String taskSearch) async {
    final db = await database;
    var res = await db.query("Task", where: "task = ?", whereArgs: [taskSearch]);
    List<Task> list =
    res.isNotEmpty ? res.map((c) => Task.fromMap(c)).toList() : [];
    return list;
  }
  //get all task by date
  ///date form : yyyy-mm-dd
  Future<List<Task>> getByDate(String date,String dateReminder) async {
    final db = await database;
    var res = await db.query("Task", where: "date = ? OR dateReminder = ?", whereArgs: [date,dateReminder]);
    List<Task> list =
    res.isNotEmpty ? res.map((c) => Task.fromMap(c)).toList() : [];
    return list;
  }



//get all tasks
  Future<List<Task>> getAllTask() async {
    final db = await database;
    var res = await db.query("Task");
    List<Task> list =
    res.isNotEmpty ? res.map((c) => Task.fromMap(c)).toList() : [];
    return list;
  }
//update task
  updateTask(Task newTask) async {
    final db = await database;
    var res = await db.update("Task", newTask.toMap(),
        where: "id = ?", whereArgs: [newTask.id]);
    return res;
  }

  // delete task
  deleteTask(int id) async {
    final db = await database;
    db.delete("Task", where: "id = ?", whereArgs: [id]);
  }

// delete all
  deleteAll() async {
    final db = await database;
    //db.rawDelete("Delete * from History");
    try{

      await db.transaction((txn) async {
        var batch = txn.batch();
        batch.delete("Task");
        await batch.commit();
      });
    } catch(error){
      throw Exception('DbBase.cleanDatabase: ' + error.toString());
    }
  }

//***************************************  Goal ***********
//insert new Goal
  newGoal(Goal newGoal) async {
    final db = await database;
    var res = await db.insert("Goal", newGoal.toMap());
    return res;
  }
//get all Goals
  Future<List<Goal>> getAllGoals() async {
    final db = await database;
    var res = await db.query("Goal");
    List<Goal> list =
    res.isNotEmpty ? res.map((c) => Goal.fromMap(c)).toList() : [];
    return list;
  }
//update Goal
  updateGoal(Goal newGoal) async {
    final db = await database;
    var res = await db.update("Goal", newGoal.toMap(),
        where: "id = ?", whereArgs: [newGoal.id]);
    return res;
  }


  // delete Goal
  deleteGoal(int id) async {
    final db = await database;
    db.delete("Goal", where: "id = ?", whereArgs: [id]);
  }
// delete all
  deleteAllGoal() async {
    final db = await database;
    //db.rawDelete("Delete * from History");
    try{

      await db.transaction((txn) async {
        var batch = txn.batch();
        batch.delete("Goal");
        await batch.commit();
      });
    } catch(error){
      throw Exception('DbBase.cleanDatabase: ' + error.toString());
    }
  }

  //*************************** User *********
//insert new User
  newUser(User newGoal) async {
    final db = await database;
    var res = await db.insert("User", newGoal.toMap());
    return res;
  }
//update User
  updateUser(User newUser) async {
    final db = await database;
    var res = await db.update("User", newUser.toMap(),
        where: "id = ?", whereArgs: [newUser.id]);
    return res;
  }
  // get User with id
  getUser(int id) async {
    final db = await database;
    var res =await  db.query("User", where: "id = ?", whereArgs: [id]);
    return res.isNotEmpty ? Task.fromMap(res.first) : Null ;
  }

}