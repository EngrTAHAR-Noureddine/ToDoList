import 'dart:io';


import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todolist/Models/task_model.dart';

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
          "date INTEGER"
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
  //get all tasks with search by task name
  Future<List<Task>> getAllSearch(String taskSearch) async {
    final db = await database;
    var res = await db.query("Task", where: "task = ?", whereArgs: [taskSearch]);
    List<Task> list =
    res.isNotEmpty ? res.map((c) => Task.fromMap(c)).toList() : [];
    return list;
  }
  //get all task by date
  Future<List<Task>> getByDate(String date) async {
    final db = await database;
    var res = await db.query("Task", where: "date = ?", whereArgs: [date]);
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
  updateTask(Task newClient) async {
    final db = await database;
    var res = await db.update("Task", newClient.toMap(),
        where: "id = ?", whereArgs: [newClient.id]);
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

}