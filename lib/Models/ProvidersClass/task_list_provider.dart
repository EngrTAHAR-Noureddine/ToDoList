import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:todolist/DataBase/database.dart';
import 'package:todolist/Models/Data/data_variable.dart';
import 'package:todolist/Models/Data/task_model.dart';
import 'package:todolist/Models/ProvidersClass/provider_class.dart';

class ToDoListBodyProvider extends ChangeNotifier{
  static final ToDoListBodyProvider _singleton = ToDoListBodyProvider._internal();
  factory ToDoListBodyProvider() {
    return _singleton;
  }
  ToDoListBodyProvider._internal();

  Widget inProgressButton(context,item){
    return Container(

      height: double.infinity,
      decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,

          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(10),
            topLeft: Radius.circular(10),
          )
      ),
      child: MaterialButton(
        shape: RoundedRectangleBorder(
            borderRadius:BorderRadius.only(
              bottomLeft: Radius.circular(10),
              topLeft: Radius.circular(10),
            )
        ),
        height: double.infinity,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.published_with_changes_outlined, ),
            Text('In progress')
          ],
        ),
        textColor: Theme.of(context).splashColor,
        color: Colors.transparent,
        hoverColor: Colors.transparent,
        highlightColor: Colors.transparent,
        focusColor: Colors.transparent,
        splashColor: Colors.white.withOpacity(0.3),
        elevation: 0,
        hoverElevation: 0,
        highlightElevation: 0,
        focusElevation: 0,

        onPressed: ()async{
          item.task.status = Variables().status[0];
          await DBProvider.db.updateTask(item.task);
          // setState(() {}); update
          notifyListeners();
        },

      ),
    );
  }
  Widget finishedButton(context,item){
    return Container(

      height: double.infinity,
      decoration: BoxDecoration(
          color:Color(0xFF00B98C),

          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(10),
            topLeft: Radius.circular(10),
          )
      ),
      child: MaterialButton(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(10),
              topLeft: Radius.circular(10),
            )
        ),
        height: double.infinity,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.task_alt_rounded, ),
            Text('Finished')
          ],
        ),
        textColor: Theme.of(context).splashColor,
        color: Colors.transparent,
        hoverColor: Colors.transparent,
        highlightColor: Colors.transparent,
        focusColor: Colors.transparent,
        splashColor: Colors.white.withOpacity(0.3),
        elevation: 0,
        hoverElevation: 0,
        highlightElevation: 0,
        focusElevation: 0,

        onPressed: ()async{
          item.task.status = Variables().status[4];
          await DBProvider.db.updateTask(item.task);
          // setState(() {}); update
          notifyListeners();
        },

      ),
    );
  }
  Widget renewalButton(context,item){
    return Container(

      height: double.infinity,
      decoration: BoxDecoration(
          color:Color(0xFF6D6E70),

          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(10),
            topLeft: Radius.circular(10),
          )
      ),
      child: MaterialButton(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(10),
              topLeft: Radius.circular(10),
            )
        ),
        height: double.infinity,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.restart_alt_outlined, ),
            Text('Renewal')
          ],
        ),
        textColor: Theme.of(context).splashColor,
        color: Colors.transparent,
        hoverColor: Colors.transparent,
        highlightColor: Colors.transparent,
        focusColor: Colors.transparent,
        splashColor: Colors.white.withOpacity(0.3),
        elevation: 0,
        hoverElevation: 0,
        highlightElevation: 0,
        focusElevation: 0,

        onPressed: ()async{
          item.task.status = Variables().status[3];
          await DBProvider.db.updateTask(item.task);
          //setState(() {}); update
          notifyListeners();
        },

      ),
    );
  }
  Widget deleteButton(context,item){
    return Container(

      height: double.infinity,
      decoration: BoxDecoration(
          color:Theme.of(context).errorColor,

          borderRadius: BorderRadius.only(
            bottomRight: Radius.circular(10),
            topRight: Radius.circular(10),
          )
      ),
      child: IconSlideAction(
        color: Colors.transparent,
        foregroundColor: Color(0xDEFFFFFF),
        icon: Icons.delete,
        caption: 'Delete',
        onTap: (){
          return showDialog(context: context, builder: (context){
            return AlertDialog(
              backgroundColor:Theme.of(context).floatingActionButtonTheme.hoverColor,

              shape: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              title: Center(child: Text("Delete Task" , style: TextStyle(color: Color(0xFF979DB0) ),),),
              actions: [
                MaterialButton(

                  child: Text("OK",style: TextStyle(color:Color(0xFF979DB0)),),
                  onPressed: ()async{

                    await DBProvider.db.deleteTask(item.task.id);
                    //setState(() {}); update
                    notifyListeners();
                    Navigator.pop(context);
                  },
                ),
                MaterialButton(

                  splashColor: Colors.transparent,
                  child: Text("Cancel",style: TextStyle(color:Color(0xFF979DB0)),),
                  onPressed: () {
                    Navigator.pop(context);

                  },
                ),
              ],
              content: SingleChildScrollView(
                child: Container(
                  child: Text("You are sure to delete the task ?",),),
              ),
            ); });
        },
      ),

    );
  }
  Widget deleteDraft(context,item){
    return Container(

      height: double.infinity,
      decoration: BoxDecoration(
          color:Theme.of(context).errorColor,

          borderRadius: BorderRadius.only(
            bottomRight: Radius.circular(10),
            topRight: Radius.circular(10),
          )
      ),
      child: IconSlideAction(
        color: Colors.transparent,
        foregroundColor: Color(0xDEFFFFFF),
        icon: Icons.delete,
        caption: 'Delete',
        onTap: (){
          return showDialog(context: context, builder: (context){
            return AlertDialog(
              backgroundColor:Theme.of(context).floatingActionButtonTheme.hoverColor,

              shape: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              title: Center(child: Text("Delete Task" , style: TextStyle(color: Color(0xFF979DB0) ),),),
              actions: [
                MaterialButton(

                  child: Text("OK",style: TextStyle(color:Color(0xFF979DB0)),),
                  onPressed: ()async{

                    await DBProvider.db.deleteDraft(item.id);
                    notifyListeners();
                    Navigator.pop(context);
                  },
                ),
                MaterialButton(

                  splashColor: Colors.transparent,
                  child: Text("Cancel",style: TextStyle(color:Color(0xFF979DB0)),),
                  onPressed: () {
                    Navigator.pop(context);

                  },
                ),
              ],
              content: SingleChildScrollView(
                child: Container(
                  child: Text("You are sure to delete the task ?",),),
              ),
            ); });
        },
      ),

    );
  }

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

  changeColor(Task task, String reminder)async{
    if(task!=null && (task.status==Variables().status[3])){
      task.status = (reminder=="yes")?Variables().status[2]:Variables().status[1];
      await DBProvider.db.updateTask(task);
    }
    notifyListeners();
  }

  setState(){
    notifyListeners();
  }
}