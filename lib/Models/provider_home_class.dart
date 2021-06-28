import 'package:flutter/material.dart';
import 'package:todolist/ModelView/body_model.dart';
import 'package:todolist/View/drafts_view.dart';
import 'package:todolist/View/goal_view.dart';

class ProviderHome extends ChangeNotifier{
  static final ProviderHome _singleton = ProviderHome._internal();

  factory ProviderHome() {
    return _singleton;
  }

  ProviderHome._internal();




  int index=0;
  List<Widget> bodyWidgets =[ToDoListBody(),DraftsView(),GoalView()];



  void setNumWidget(int num){
      this.index = num;

  }

  Widget returnWidget(){

      return bodyWidgets[index];
  }



}