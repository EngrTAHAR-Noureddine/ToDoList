import 'package:flutter/material.dart';

class ProviderClass extends ChangeNotifier{
  static final ProviderClass _singleton = ProviderClass._internal();

  factory ProviderClass() {
    return _singleton;
  }

  ProviderClass._internal();

  String _category = "click_button";
  PageController controller = PageController(initialPage: 0);

  void setCategory(String cat){
    if(cat.isNotEmpty) {
      this._category = cat;
      controller.jumpToPage(0);
    }
    notifyListeners();
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