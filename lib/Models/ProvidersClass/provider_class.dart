import 'package:flutter/material.dart';
import 'package:todolist/DataBase/database.dart';
import 'package:todolist/Models/Data/data_variable.dart';
import 'package:todolist/Models/Data/task_model.dart';
import 'package:todolist/Models/Data/user_model.dart';

class ProviderClass extends ChangeNotifier{
  static final ProviderClass _singleton = ProviderClass._internal();

  factory ProviderClass() {
    return _singleton;
  }

  ProviderClass._internal();


  PageController controller = PageController(initialPage: 0);
  ThemeMode themeMode = ThemeMode.system;

  changeColor(Task task, String reminder)async{
    if(task!=null && (task.status==Variables().status[3])){
      task.status = (reminder=="yes")?Variables().status[2]:Variables().status[1];

      print("update task ************************************* ");
      await DBProvider.db.updateTask(task);

    }
    notifyListeners();
  }

  List<String> listWidgets =["Today","Tomorrow"];

  Future<void> setAppMode(value,User user)async{
    user.darkMode =(value)?"Dark":"Light";
    themeMode=(user.darkMode=="Dark")?ThemeMode.dark:ThemeMode.light;
    await DBProvider.db.updateUser(user);
    notifyListeners();
  }

  Future<void> setAppMod(User user)async{

    themeMode=(user.darkMode=="Dark")?ThemeMode.dark:ThemeMode.light;

    notifyListeners();
  }

  void setWidget(name){
    if(this.listWidgets.length>2){
      this.listWidgets[0] = name;
    } else this.listWidgets.insert(0,name);
    this.controller.jumpToPage(0);
    notifyListeners();
  }

  void removeWidget(){
    this.listWidgets.removeAt(0);
    this.controller.jumpToPage(0);
    notifyListeners();
  }

  void setState(){
    notifyListeners();
  }


}