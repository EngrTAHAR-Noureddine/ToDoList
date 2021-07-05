import 'package:flutter/material.dart';
import 'package:todolist/DataBase/database.dart';
import 'package:todolist/Models/Data/data_variable.dart';
import 'package:todolist/Models/ProvidersClass/provider_class.dart';
import 'package:todolist/Models/Data/task_model.dart';

class CategoryFunction {
  static final CategoryFunction _singleton = CategoryFunction._internal();

  factory CategoryFunction() {
    return _singleton;
  }

  CategoryFunction._internal();
  Stream<List<Category>> getCategories()async*{

    List<Map> list = await DBProvider.db.getCategories();

    List<Category> listCat = list.map((c) => Category.fromMap(c)).toList();
    List<String> categoriesList = [];
    listCat.forEach((element) { categoriesList.add(element.category); });
    Variables().setCat(categoriesList);
    yield listCat;
  }

  Widget  categoryWidget(context,Category category){
    return Container(
      width: 200,
      height: 100,
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.all(0),

      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(20)),
        boxShadow: [

          BoxShadow(
            color: Color(0x40000000),//.withOpacity(0.5),
            spreadRadius: 0,
            blurRadius: 4,
            offset: Offset(0, 4), // changes position of shadow
          ),
        ],
        color: Theme.of(context).cardColor,
      ),
      child: MaterialButton(

        onPressed: (){

          ProviderClass().setWidget(category.category);

        },
        colorBrightness:Theme.of(context).primaryColorBrightness,
        padding: EdgeInsets.only(left: 10),
        elevation: 3,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),

        ),
        color: Theme.of(context).accentColor,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            Align(
                alignment: Alignment.topLeft,
                child: Text("Task: "+category.count.toString(),style:TextStyle(color:Theme.of(context).bottomAppBarColor ,fontSize:16,fontFamily: "Roboto") ,)
            ),
            Text(category.category ,style: TextStyle(color:Theme.of(context).floatingActionButtonTheme.focusColor ,fontSize:20,fontFamily: "Roboto"),),
          ],
        ),
      ),
    );
  }
}