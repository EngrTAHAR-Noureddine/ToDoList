import 'package:flutter/material.dart';
import 'package:todolist/ModelView/body_model.dart';
import 'package:todolist/ModelView/search_result.dart';
import 'package:todolist/View/page_of_draft.dart';
import 'package:todolist/View/goal_fragment.dart';
import 'package:todolist/View/settings_view.dart';

class SwitchViews extends ChangeNotifier{
  static final SwitchViews _singleton = SwitchViews._internal();

  factory SwitchViews() {
    return _singleton;
  }

  SwitchViews._internal();

String searchItem;


  int index=0;
  List<Widget> bodyWidgets =[ToDoListBody(),PageOfDrafts(),GoalView(),SettingsView(),ToDoListBody(),SearchResult()];

    void onSearch(value){
      searchItem=value.toString();

      notifyListeners();
    }



  Widget returnWidget(){

      return bodyWidgets[this.index];

  }



}