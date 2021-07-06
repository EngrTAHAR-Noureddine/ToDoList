import 'package:flutter/material.dart';
import 'package:todolist/DataBase/database.dart';
import 'package:todolist/Models/Data/data_variable.dart';
import 'package:todolist/Models/Data/queue_model.dart';
import 'package:todolist/Models/Data/task_model.dart';
import 'package:todolist/Models/Data/user_model.dart';
import 'package:todolist/Models/ProvidersClass/settings_provider.dart';

class NotificationProvider extends ChangeNotifier{
  static final NotificationProvider _singleton = NotificationProvider._internal();
  factory NotificationProvider() {
    return _singleton;
  }
  NotificationProvider._internal();

  List<Queue> listQueues;
  String isUnread;

  Stream<bool> getUnread()async*{
    User user = await SettingsProvider().getUser();
    if(user!=null){
      this.isUnread = user.notificationUnread;
      print("inside if of get unread "+this.isUnread.toString());
    }
    yield (this.isUnread=="true");
  }

  updateNotificationRead()async{
    User user = await SettingsProvider().getUser();
    if(user!=null){
      user.notificationUnread = "false";
      await DBProvider.db.updateUser(user);
      notifyListeners();
    }
  }


  Future<List<Queue>> getList()async{
    this.listQueues = await DBProvider.db.getAllQueue();
    if(this.listQueues!=null){

     await updateNotificationRead();

    }
    return this.listQueues;
  }





  Future<void> cancelNotification()async{
    this.listQueues =[];
    this.listQueues = await getList();

    if(this.listQueues!=null&&this.listQueues.isNotEmpty) {
      for (int i = 0; i < this.listQueues.length; i++) {
        Queue queue = listQueues[i];
        Task task = await DBProvider.db.getTask(queue.idTask);
        if (task != null) {
          task.status =(queue.isReminder == "yes") ? Variables().status[2] : Variables().status[1];
          await DBProvider.db.updateTask(task);
          await DBProvider.db.deleteQueue(queue.id);
        }
      }
      await updateNotificationRead();
    }
    notifyListeners();
  }


  Future<void> clickInProgress(context ,int id,int idQ)async{
    Task task = await DBProvider.db.getTask(id);
    if(task != null) {
      task.status = Variables().status[0];
      await DBProvider.db.updateTask(task);
    }
    await DBProvider.db.deleteQueue(idQ);
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text('The task is in progress')));
    notifyListeners();
  }

  Future<void> clickFinished(context ,int idTask ,int id)async{

    Task task = await DBProvider.db.getTask(idTask);
    if(task != null) {
      print("i'm in click finished => "+task.task);
      print("i'm in click finished => "+task.frequency);
      task.status =(task.frequency==Variables().frequency[0])?Variables().status[4]:Variables().status[3];
      print("i'm in click finished => "+task.status);
      List<String> dateSelected = task.date.split("/");
      DateTime date ;
      List<String> dateReminder = task.dateReminder.split("/");
      switch(task.frequency){
        case "monthly":
                    date= DateTime(int.parse(dateSelected[2]),(int.parse(dateSelected[1])+1),int.parse(dateSelected[0]));
                    task.date = date.day.toString()+"/"+date.month.toString()+"/"+date.year.toString();
                    date= DateTime(int.parse(dateReminder[2]),(int.parse(dateReminder[1])+1),int.parse(dateReminder[0]));
                    task.dateReminder = date.day.toString()+"/"+date.month.toString()+"/"+date.year.toString();
                        break;
        case"weekly":
                      date= DateTime(int.parse(dateSelected[2]),int.parse(dateSelected[1]),(int.parse(dateSelected[0])+7));
                      task.date = date.day.toString()+"/"+date.month.toString()+"/"+date.year.toString();
                      date= DateTime(int.parse(dateReminder[2]),int.parse(dateReminder[1]),(int.parse(dateReminder[0])+7));
                      task.dateReminder = date.day.toString()+"/"+date.month.toString()+"/"+date.year.toString();
                        break;
        case"Daily":
                    date= DateTime(int.parse(dateSelected[2]),int.parse(dateSelected[1]),(int.parse(dateSelected[0])+1));
                    task.date = date.day.toString()+"/"+date.month.toString()+"/"+date.year.toString();
                    date= DateTime(int.parse(dateReminder[2]),int.parse(dateReminder[1]),(int.parse(dateReminder[0])+1));
                    task.dateReminder = date.day.toString()+"/"+date.month.toString()+"/"+date.year.toString();
                        break;
      }
      await DBProvider.db.updateTask(task);
      await DBProvider.db.deleteQueue(id);
    }
    notifyListeners();
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text('The task is finished')));

  }
}