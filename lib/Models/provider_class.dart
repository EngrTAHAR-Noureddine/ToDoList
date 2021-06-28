import 'package:flutter/material.dart';

class ProviderClass extends ChangeNotifier{
  static final ProviderClass _singleton = ProviderClass._internal();

  factory ProviderClass() {
    return _singleton;
  }

  ProviderClass._internal();


  PageController controller = PageController(initialPage: 0);


  List<String> listWidgets =["Today","Tomorrow"];



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



}