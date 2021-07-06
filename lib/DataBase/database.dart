import 'dart:io';


import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todolist/Models/Data/TodayTask.dart';
import 'package:todolist/Models/Data/draft_model.dart';
import 'package:todolist/Models/Data/goal_model.dart';
import 'package:todolist/Models/Data/queue_model.dart';
import 'package:todolist/Models/Data/task_model.dart';
import 'package:todolist/Models/Data/user_model.dart';

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
      await db.execute("CREATE TABLE Queue ("
          "id INTEGER PRIMARY KEY,"
          "idTask INTEGER,"
          "task TEXT,"
          "frequency TEXT,"
          "status TEXT,"
          "date TEXT,"
          "isReminder TEXT,"
          "time TEXT"
          ")");
      await db.execute("CREATE TABLE TodayTask ("
          "id INTEGER PRIMARY KEY,"
          "task TEXT,"
          "category TEXT,"
          "note TEXT,"
          "status TEXT,"
          "frequency TEXT,"
          "goal TEXT,"
          "date TEXT,"
          "isReminder TEXT,"
          "hour INTEGER,"
          "minute INTEGER,"
          "idTask INTEGER,"
          "inMinute INTEGER"
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
          "goal TEXT,"
          "dateReminder TEXT,"
          "timeReminder TEXT"
          ")");
      await db.execute("CREATE TABLE User  ("
          "id INTEGER PRIMARY KEY,"
          "notificationUnread TEXT,"
          "darkMode TEXT,"
          "passWord TEXT,"
          "hideGoal TEXT,"
          "linkAgenda TEXT"
          ")");
    });


  }

  ///********************************
  newQueue(Queue newQueue) async {
    final db = await database;
    var res = await db.insert("Queue", newQueue.toMap());
    return res;
  }
  Future<List<Queue>> getAllQueue() async {
    final db = await database;
    var res = await db.query("Queue");
    List<Queue> list =
    res.isNotEmpty ? res.map((c) => Queue.fromMap(c)).toList() : [];
    return list;
  }
  deleteQueue(int id) async {
    final db = await database;
    db.delete("Queue", where: "id = ?", whereArgs: [id]);
  }
  ///********************************

  ///**************************************************************************
  newTodayTask(TodayTask newTask) async {
    final db = await database;
    var res = await db.insert("TodayTask", newTask.toMap());
    return res;
  }
  Future<List<TodayTask>> getAllTodayTask(String date) async {
    final db = await database;
    var res = await db.rawQuery("SELECT * FROM TodayTask WHERE TodayTask.date LIKE '$date' ORDER BY inMinute asc");
    List<TodayTask> list =
    res.isNotEmpty ? res.map((c) => TodayTask.fromMap(c)).toList() : [];
    return list;
  }
  Future<List<TodayTask>> getAllToTask() async {
    final db = await database;
    var res = await db.rawQuery("SELECT * FROM TodayTask");
    List<TodayTask> list =
    res.isNotEmpty ? res.map((c) => TodayTask.fromMap(c)).toList() : [];
    return list;
  }
  deleteTodayTask(int id) async {
    final db = await database;
    db.delete("TodayTask", where: "id = ?", whereArgs: [id]);
  }
  deleteAllTodayTask() async {
    final db = await database;
    //db.rawDelete("Delete * from History");
    try{

      await db.transaction((txn) async {
        var batch = txn.batch();
        batch.delete("TodayTask");
        await batch.commit();
      });
    } catch(error){
      throw Exception('DbBase.cleanDatabase: ' + error.toString());
    }
  }
  ///**************************************************************************



//insert new task
  newTask(Task newTask) async {
    final db = await database;
    var res = await db.insert("Task", newTask.toMap());
    return res;
  }
  // get task with id
  Future<Task> getTask(int id) async {
    final db = await database;
    var res =await  db.query("Task", where: "id = ?", whereArgs: [id]);
    Task task;
    if(res.isNotEmpty) task = Task.fromMap(res.first);
    return task;
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
  Future<List<Map<dynamic, dynamic>>> getCategories() async {
    final db = await database;
    var res = await db.rawQuery("SELECT COUNT(category), category FROM Task GROUP BY category");
    List<Map<dynamic, dynamic>> list =
    res.isNotEmpty ? res.toList() : [];
    return list;
  }



  Future<List<Task>> getTimeByDateSelected(String date) async {
    final db = await database;
    var res = await db.rawQuery("SELECT * FROM Task WHERE Task.date LIKE '$date' ORDER BY time asc");
    List<Task> list =
    res.isNotEmpty ? res.map((c) => Task.fromMap(c)).toList() : [];
    return list;
  }
  Future<List<Task>> getTimeByDateReminder(String date) async {
    final db = await database;
    var res = await db.rawQuery("SELECT *FROM Task WHERE Task.dateReminder LIKE '$date' ORDER BY timeReminder asc");
    List<Task> list =
    res.isNotEmpty ? res.toList() : [];
    return list;
  }



  //get all tasks with search by task name
  Future<List<Task>> getAllSearch(String taskSearch) async {
    final db = await database;
    var res = await db.rawQuery("SELECT * FROM Task WHERE task LIKE '%$taskSearch%'");
    List<Task> list =
    res.isNotEmpty ? res.map((c) => Task.fromMap(c)).toList() : [];
    return list;
  }
  //get all task by date
  ///date form :selectedDate.day.toString()+"/"+selectedDate.month.toString()+"/"+selectedDate.year.toString()
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
    var res = await db.query("Task",orderBy: "status asc");
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
  Future<User> getUser(int id) async {
    final db = await database;

    var res =await  db.query("User", where: "id = ?", whereArgs: [id]);
    if(res.isEmpty || res==null){
      newUser(User(id:1,darkMode: "Light",linkAgenda: "none",passWord: "",hideGoal: "no",notificationUnread: "false"));
      res =await  db.query("User", where: "id = ?", whereArgs: [id]);
    }
    User user;
    if(res!=null) user = User.fromMap(res.first);
    return user;
  }

//******************************** Draft ****************

//insert new Draft
  newDraft(Draft newDraft) async {
    final db = await database;
    var res = await db.insert("Draft", newDraft.toMap());
    return res;
  }
  // get Draft with id
  getDraft(int id) async {
    final db = await database;
    var res =await  db.query("Draft", where: "id = ?", whereArgs: [id]);
    return res.isNotEmpty ? Task.fromMap(res.first) : Null ;
  }

  //get all Drafts
  Future<List<Draft>> getAllDraft() async {
    final db = await database;
    var res = await db.query("Draft");
    List<Draft> list =
    res.isNotEmpty ? res.map((c) => Draft.fromMap(c)).toList() : [];
    return list;
  }
//update Draft
  updateDraft(Draft newDraft) async {
    final db = await database;
    var res = await db.update("Draft", newDraft.toMap(),
        where: "id = ?", whereArgs: [newDraft.id]);
    return res;
  }

  // delete Draft
  deleteDraft(int id) async {
    final db = await database;
    db.delete("Draft", where: "id = ?", whereArgs: [id]);
  }

// delete all Draft
  deleteAllDrafts() async {
    final db = await database;
    //db.rawDelete("Delete * from History");
    try{

      await db.transaction((txn) async {
        var batch = txn.batch();
        batch.delete("Draft");
        await batch.commit();
      });
    } catch(error){
      throw Exception('DbBase.cleanDatabase: ' + error.toString());
    }
  }

}