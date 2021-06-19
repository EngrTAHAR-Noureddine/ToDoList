import 'package:flutter/material.dart';

class ProviderClass extends ChangeNotifier{
  static final ProviderClass _singleton = ProviderClass._internal();

  factory ProviderClass() {
    return _singleton;
  }

  ProviderClass._internal();

  String _category = "click_button";
  PageController controller = PageController(initialPage: 0);


  List listWidgets =[Container(color:Colors.blue),Container(color:Colors.red)];

  void setCategory(String cat){
    if(cat.isNotEmpty) {
      this._category = cat;
      controller.jumpToPage(0);
    }
    notifyListeners();
  }

  void setWidget(){
    this.listWidgets[0] = Container(color:Colors.yellowAccent);
    print("length in set widget : "+this.listWidgets.length.toString());
    //ProviderClass().controller.jumpToPage(0);
    notifyListeners();
  }
  void removewidget(){
    if(this._category!="click_button") {
      this._category = "click_button";
      this.listWidgets[0] = Container(color:Colors.blue);

      notifyListeners();
    }
  }

  String categoryName(){ return _category;}

  Widget her(){
    print(this._category);
    if(this._category!="click_button"){
    return Container(color:Colors.blue);
    }
    else return Container(color:Colors.red);

  }

}