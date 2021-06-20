import 'package:flutter/material.dart';

class ProviderClass extends ChangeNotifier{
  static final ProviderClass _singleton = ProviderClass._internal();

  factory ProviderClass() {
    return _singleton;
  }

  ProviderClass._internal();


  PageController controller = PageController(initialPage: 0);


  List listWidgets =[Container(color:Colors.blue),Container(color:Colors.red)];



  void setWidget(name){
    this.listWidgets.insert(0,Container(color:Colors.yellowAccent));
    this.controller.jumpToPage(0);
    notifyListeners();
  }

  void removeWidget(){


      this.listWidgets.removeAt(0);
        this.controller.jumpToPage(0);
      notifyListeners();

  }



}