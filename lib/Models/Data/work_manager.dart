import 'package:flutter/material.dart';
import 'package:todolist/DataBase/database.dart';
import 'package:todolist/Models/Data/TodayTask.dart';
import 'package:todolist/Models/Data/data_variable.dart';
import 'package:todolist/Models/Data/task_model.dart';
import 'package:todolist/Models/Data/user_model.dart';
import 'package:todolist/Models/ProvidersClass/provider_class.dart';
import 'package:todolist/Models/ProvidersClass/settings_provider.dart';
import 'package:todolist/Models/ProvidersClass/task_list_provider.dart';
import 'package:todolist/Models/notification_service.dart';
import 'package:workmanager/workmanager.dart';

import '../../main.dart';

class WorkManagerProvider{
  static final WorkManagerProvider _singleton = WorkManagerProvider._internal();

  factory WorkManagerProvider() {
    return _singleton;
  }

  WorkManagerProvider._internal();

  Future<void> traitLastDay()async{
    DateTime now = DateTime.now();
    DateTime lastDate = DateTime(now.year,now.month,(now.day-1));
    String lastDateString = lastDate.day.toString()+"/"+lastDate.month.toString()+"/"+lastDate.year.toString();
    List<Task> lastTask = await DBProvider.db.getTimeByDateSelected(lastDateString);

    if(lastTask!=null&&lastTask.isNotEmpty){
      for(int i=0;i<lastTask.length;i++){
        Task task = lastTask[i];
        if((task.status!=Variables().status[3])&&(task.status!=Variables().status[4])){
          List<String> dateSelected = task.date.split("/");
          List<String> dateReminder = task.dateReminder.split("/");
          task.status =Variables().status[3];
          switch(task.frequency){
            case "monthly":
              lastDate= DateTime(int.parse(dateSelected[2]),(int.parse(dateSelected[1])+1),int.parse(dateSelected[0]));
              task.date = lastDate.day.toString()+"/"+lastDate.month.toString()+"/"+lastDate.year.toString();
              lastDate= DateTime(int.parse(dateReminder[2]),(int.parse(dateReminder[1])+1),int.parse(dateReminder[0]));
              task.dateReminder = lastDate.day.toString()+"/"+lastDate.month.toString()+"/"+lastDate.year.toString();

              await DBProvider.db.updateTask(task);
              break;
            case"weekly":
              lastDate= DateTime(int.parse(dateSelected[2]),int.parse(dateSelected[1]),(int.parse(dateSelected[0])+7));
              task.date = lastDate.day.toString()+"/"+lastDate.month.toString()+"/"+lastDate.year.toString();
              lastDate= DateTime(int.parse(dateReminder[2]),int.parse(dateReminder[1]),(int.parse(dateReminder[0])+7));
              task.dateReminder = lastDate.day.toString()+"/"+lastDate.month.toString()+"/"+lastDate.year.toString();
              await DBProvider.db.updateTask(task);
              break;
            case"Daily":
              lastDate= DateTime(int.parse(dateSelected[2]),int.parse(dateSelected[1]),(int.parse(dateSelected[0])+1));
              task.date = lastDate.day.toString()+"/"+lastDate.month.toString()+"/"+lastDate.year.toString();
              lastDate= DateTime(int.parse(dateReminder[2]),int.parse(dateReminder[1]),(int.parse(dateReminder[0])+1));
              task.dateReminder = lastDate.day.toString()+"/"+lastDate.month.toString()+"/"+lastDate.year.toString();
              await DBProvider.db.updateTask(task);
              break;
            default :
              if(task.status!=Variables().status[2]) await DBProvider.db.deleteTask(task.id);
              break;
          }
        }
      }
    }

  }

  Future<void> initialWork()async{

    DateTime now = DateTime.now();
    String dateNow = now.day.toString()+"/"+now.month.toString()+"/"+now.year.toString();

    List<TodayTask> todayTasks = await DBProvider.db.getAllToTask();
    if(todayTasks!=null) await DBProvider.db.deleteAllTodayTask();

    List<Task> taskToday = await DBProvider.db.getTimeByDateSelected(dateNow);
    List<Task> taskreminder = await DBProvider.db.getTimeByDateSelected(dateNow);
    await traitLastDay();
    TodayTask todayTask;

    if(taskToday!=null && taskToday.isNotEmpty){
      for(int i=0; i<taskToday.length;i++){
        todayTask = new TodayTask(
            idTask: taskToday[i].id,
            task: taskToday[i].task,
            category: taskToday[i].category,
            frequency: taskToday[i].frequency,
            goal: taskToday[i].goal,
            status: taskToday[i].status,
            note: taskToday[i].note,
            date: taskToday[i].date,
            isReminder: "no",
            hour: int.parse(taskToday[i].time.split(":")[0]),
            minute: int.parse(taskToday[i].time.split(":")[1]),
            inMinute: ((int.parse(taskToday[i].time.split(":")[0])*60)+int.parse(taskToday[i].time.split(":")[1]))
        );
        await DBProvider.db.newTodayTask(todayTask);
      }
    }
    if(taskreminder!=null && taskreminder.isNotEmpty){
      for(int i=0; i<taskreminder.length;i++){
        todayTask = new TodayTask(
            idTask: taskreminder[i].id,
            task: taskreminder[i].task,
            category: taskreminder[i].category,
            frequency: taskreminder[i].frequency,
            goal: taskreminder[i].goal,
            status: taskreminder[i].status,
            note: taskreminder[i].note,
            date: taskreminder[i].dateReminder,
            isReminder: "yes",
            hour: int.parse(taskreminder[i].timeReminder.split(":")[0]),
            minute: int.parse(taskreminder[i].timeReminder.split(":")[1]),
            inMinute: ((int.parse(taskreminder[i].timeReminder.split(":")[0])*60)+int.parse(taskreminder[i].timeReminder.split(":")[1]))
        );
        await DBProvider.db.newTodayTask(todayTask);
      }
    }

    WidgetsFlutterBinding.ensureInitialized();
    await Workmanager().initialize(callbackDispatcher);
    await Workmanager().registerOneOffTask(
        "tomorrow"+now.toString(), "test3",
        inputData: {
          "data": "init",
          "title":" ",
          "body":" ",
          "time":" ",
          "idTask":0,
          "date":" ",
          "status":" ",
          "frequency":" ",
          "isReminder":"no"
        },
        initialDelay: Duration(minutes: ((24*60)-(now.hour*60+now.minute)))
    );
    WidgetsFlutterBinding.ensureInitialized();
    await Workmanager().initialize(callbackDispatcher);
    await Workmanager().registerOneOffTask(
        "today"+now.toString(), "test2",
        inputData: {
          "data": "notNow",
          "title":" ",
          "body":" ",
          "time":" ",
          "idTask":0,
          "date":" ",
          "status":" ",
          "frequency":" ",
          "isReminder":"no"
        },
        initialDelay: Duration(seconds: 1)
    );
  }

  Future<void> notNowToWork()async{
    DateTime now = DateTime.now();

    DateTime date ;

    int inMinuteNow = now.hour*60+now.minute;
    TodayTask picker;
    int delay ;
    String dateNow = now.day.toString()+"/"+now.month.toString()+"/"+now.year.toString();
    List<TodayTask> tdt = await DBProvider.db.getAllTodayTask(dateNow);
    print("notNowWork");
    print(tdt);
    if(tdt!=null && tdt.isNotEmpty) {
      print("tdt affiche ====== ");
      print(tdt);
      for(int i=0; i<tdt.length;i++) {
        print(tdt[i].hour.toString()+":"+tdt[i].minute.toString());
        print("picker no in loop : "+tdt[i].inMinute.toString());

        if (inMinuteNow <= tdt[i].inMinute){
          print("picker ====== ");
          picker = tdt[i];
          print("picked = "+picker.task);
          break;
        }
        else{
          print("else of picker ==== ");
          print("hi ! ");

          Task task = await DBProvider.db.getTask(tdt[i].idTask);
          if(task!=null){
            print("this colored in workmanager =========== ");
            if((task.status==Variables().status[3])||(task.status==Variables().status[4])){
              List<String> dateSelected = task.date.split("/");
              List<String> dateReminder = task.dateReminder.split("/");
              task.status =Variables().status[3];
              switch(task.frequency){
                case "monthly":
                  date= DateTime(int.parse(dateSelected[2]),(int.parse(dateSelected[1])+1),int.parse(dateSelected[0]));
                  task.date = date.day.toString()+"/"+date.month.toString()+"/"+date.year.toString();
                  date= DateTime(int.parse(dateReminder[2]),(int.parse(dateReminder[1])+1),int.parse(dateReminder[0]));
                  task.dateReminder = date.day.toString()+"/"+date.month.toString()+"/"+date.year.toString();

                  await DBProvider.db.updateTask(task);
                  break;
                case"weekly":
                  date= DateTime(int.parse(dateSelected[2]),int.parse(dateSelected[1]),(int.parse(dateSelected[0])+7));
                  task.date = date.day.toString()+"/"+date.month.toString()+"/"+date.year.toString();
                  date= DateTime(int.parse(dateReminder[2]),int.parse(dateReminder[1]),(int.parse(dateReminder[0])+7));
                  task.dateReminder = date.day.toString()+"/"+date.month.toString()+"/"+date.year.toString();
                  await DBProvider.db.updateTask(task);
                  break;
                case"Daily":
                  date= DateTime(int.parse(dateSelected[2]),int.parse(dateSelected[1]),(int.parse(dateSelected[0])+1));
                  task.date = date.day.toString()+"/"+date.month.toString()+"/"+date.year.toString();
                  date= DateTime(int.parse(dateReminder[2]),int.parse(dateReminder[1]),(int.parse(dateReminder[0])+1));
                  task.dateReminder = date.day.toString()+"/"+date.month.toString()+"/"+date.year.toString();
                  await DBProvider.db.updateTask(task);
                  break;
                default :
                  print("delete");
                  await DBProvider.db.deleteTask(task.id);
                          break;
              }

            }
          }
          await DBProvider.db.deleteTodayTask(tdt[i].id);
        }
      }



      if(picker != null) {
        print(picker.hour.toString()+":"+picker.minute.toString());

        if (picker.inMinute == inMinuteNow) {
          print("it time to notification");
          WidgetsFlutterBinding.ensureInitialized();
          await Workmanager().initialize(callbackDispatcher);
          await Workmanager().registerOneOffTask(
              picker.id.toString(), "test2",
              inputData: {
                "data": "itTime",
                "title":picker.task,
                "body":(picker.note!=null)?picker.note:"click to show details...",
                "time":picker.date,
                "idTask":picker.idTask,
                "date":dateNow,
                "status":picker.status,
                "frequency":picker.frequency,
                "isReminder":picker.isReminder
              },
              initialDelay: Duration(seconds: 1)
          );
        } else {
          print("it delay  to notification");
          delay = picker.inMinute - inMinuteNow;
          WidgetsFlutterBinding.ensureInitialized();
          await Workmanager().initialize(callbackDispatcher);
          await Workmanager().registerOneOffTask(
              picker.id.toString(), "test",
              inputData: {
                "data": "itTime",
                "title":picker.task,
                "body":(picker.note!=null)?picker.note:"click to show details...",
                "time":picker.date,
                "idTask":picker.idTask,
                "date":dateNow,
                "status":picker.status,
                "frequency":picker.frequency,
                "isReminder":picker.isReminder
              },
              initialDelay: Duration(minutes: delay)
          );
        }
      }
    }
  }

  Future<void> itTimeToWork(inputData)async{
    print("its time to work ");
    print("inputdata = ");
    print(inputData["idTask"]);
    print(inputData["idTask"] is int);

    LocalNotification.Initializer();
    LocalNotification.ShowOneTimeNotification(DateTime.now(),inputData["title"],inputData["body"],inputData["time"]);
   // WidgetsFlutterBinding.ensureInitialized();

    Task task = await DBProvider.db.getTask(inputData["idTask"]);

    if(task!=null && (task.status==Variables().status[3])){
      print("task in it work is : "+task.task);
      print(task.status +"and reminder "+inputData["isReminder"]);
      task.status = (inputData["isReminder"]=="yes")?Variables().status[2]:Variables().status[1];
      await DBProvider.db.updateTask(task);
      ProviderClass().setState();
    }
   // await ProviderClass().changeColor(task, inputData["isReminder"]);


    WidgetsFlutterBinding.ensureInitialized();
    await Workmanager().initialize(callbackDispatcher);
    await Workmanager().registerOneOffTask(
        "today"+DateTime.now().toString(), "test",
        inputData: {
          "data": "notNow",
          "title":" ",
          "body":" ",
          "time":" ",
          "idTask":0,
          "date":" ",
          "status":" ",
          "frequency":" ",
          "isReminder":"no"
        },
        initialDelay: Duration(minutes: 1)
    );
  }
  }

