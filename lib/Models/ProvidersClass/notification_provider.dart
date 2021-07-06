import 'package:flutter/material.dart';
import 'package:todolist/DataBase/database.dart';
import 'package:todolist/Models/Data/data_variable.dart';
import 'package:todolist/Models/Data/queue_model.dart';
import 'package:todolist/Models/Data/task_model.dart';

class NotificationProvider extends ChangeNotifier{
  static final NotificationProvider _singleton = NotificationProvider._internal();
  factory NotificationProvider() {
    return _singleton;
  }
  NotificationProvider._internal();

  List<Queue> listQueues;
  String isUnread;
  int number;
  setList(List<Queue> list){
    this.listQueues = list;
    this.number=list.length;

    notifyListeners();
  }
  int getNumber(){
    return this.number;
  }
  List<Queue> getList(){
    return this.listQueues;
  }
  //TODO
/// refresh in icon of notification not work
  /// refresh the last item of notification didn't delete
  /// we need log in
  /// splash screen
  /// logo
  /// ascendent the tasks
  Future<void> changeColorTask()async{
    if(this.listQueues!=null&&this.listQueues.isNotEmpty){
    for(int i=0; i<this.listQueues.length;i++){
      Queue queue = listQueues[i];
      Task task = await DBProvider.db.getTask(queue.idTask);
      if(task!=null){
        task.status =(queue.isReminder =="yes")? Variables().status[2]:Variables().status[1];
        await DBProvider.db.updateTask(task);
      }
    }
    }
  }



  Future<void> cancelNotification()async{
    if(this.listQueues!=null&&this.listQueues.isNotEmpty) {
      for (int i = 0; i < this.listQueues.length; i++) {
        Queue queue = listQueues[i];
        Task task = await DBProvider.db.getTask(queue.idTask);
        if (task != null) {
          task.status =
          (queue.isReminder == "yes") ? Variables().status[2] : Variables()
              .status[1];
          await DBProvider.db.updateTask(task);
          await DBProvider.db.deleteQueue(queue.id);
        }
      }
    }
  }


  Future<void> clickInProgress(context ,int id)async{
    Task task = await DBProvider.db.getTask(id);
    if(task != null) {
      task.status = Variables().status[0];
      await DBProvider.db.updateTask(task);
    }
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text('The task is in progress')));
    notifyListeners();
  }
  Future<void> clickFinished(context ,int idTask ,int id)async{
    await DBProvider.db.deleteQueue(id);
    Task task = await DBProvider.db.getTask(idTask);
    if(task != null) {
      task.status =(task.frequency=="Once")?Variables().status[4]:Variables().status[3];
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
    }
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text('The task is finished')));
    notifyListeners();
  }
}