import 'package:flutter/material.dart';

class Variables{
  static final Variables _singleton = Variables._internal();

  factory Variables() {
    return _singleton;
  }

  Variables._internal();
bool isLarge;
  int _idOfList;
  List<String> _categories =[];
  List<String> status = ["Important","Less important","In progress","Finished","Voluntary"];
  List<String> frequency = ["Once","Daily","weekly","monthly"];
  ///have : today, tomorrow, Temporary(is status)
  Map<String,int> _tasks;

  ThemeData mode(context){
    var brightness = MediaQuery.of(context).platformBrightness;
    bool darkModeOn = brightness == Brightness.dark;


    if(!darkModeOn){
      return ThemeData.light().copyWith(
        colorScheme: ColorScheme.light(),
      );
    }else{
      return ThemeData.dark().copyWith(
        colorScheme: ColorScheme.dark(),
      );
    }
  }

  setTask(String name, int value){
    this._tasks[name]=value;
  }
  updateTask(String name,val){
    this._tasks.update(name, (value) => val);
  }
  int getNum(String name){
    return this._tasks[name];
  }
  List<String> getKeys(){
    return this._tasks.keys;
  }

  setCat(List<String> cat){
    this._categories = cat;
  }
  List<String> getCat(){
    return this._categories;
  }

  setData(int value){
    this._idOfList = value;
  }
  getData(){
    return this._idOfList;
  }


}