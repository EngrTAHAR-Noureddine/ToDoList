import 'package:flutter/material.dart';
import 'package:todolist/ModelView/body_model.dart';
import 'package:todolist/ModelView/search_result.dart';
import 'package:todolist/View/drafts_view.dart';
import 'package:todolist/View/goal_view.dart';
import 'package:todolist/View/settings_view.dart';

class SwitchViews extends ChangeNotifier{
  static final SwitchViews _singleton = SwitchViews._internal();

  factory SwitchViews() {
    return _singleton;
  }

  SwitchViews._internal();

String searchItem;


  int index=0;
  List<Widget> bodyWidgets =[ToDoListBody(),DraftsView(),GoalView(),SettingsView(),ToDoListBody(),SearchResult()];

    void onSearch(value){
      searchItem=value.toString();

      notifyListeners();
    }



  Widget returnWidget(){

      return bodyWidgets[this.index];

  }



}