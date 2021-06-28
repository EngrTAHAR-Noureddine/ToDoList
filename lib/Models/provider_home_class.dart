import 'package:flutter/material.dart';
import 'package:todolist/ModelView/body_model.dart';
import 'package:todolist/View/drafts_view.dart';
import 'package:todolist/View/goal_view.dart';

class SwitchViews{
  static final SwitchViews _singleton = SwitchViews._internal();

  factory SwitchViews() {
    return _singleton;
  }

  SwitchViews._internal();




  int index=0;
  List<Widget> bodyWidgets =[ToDoListBody(),DraftsView(),GoalView()];



  void setNumWidget(int num){
      this.index = num;

  }

  Widget returnWidget(){

      return bodyWidgets[this.index];

  }



}