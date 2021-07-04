import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:todolist/DataBase/database.dart';
import 'package:todolist/Models/Data/goal_model.dart';
import 'package:todolist/Models/Data/user_model.dart';
import 'package:todolist/Models/ProvidersClass/settings_provider.dart';

class GoalProvider extends ChangeNotifier {
  static final GoalProvider _singleton = GoalProvider._internal();
  factory GoalProvider() {
    return _singleton;
  }
  GoalProvider._internal();
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
              title: Center(child: Text("Delete Goal" , style: TextStyle(color: Color(0xFF979DB0) ),),),
              actions: [
                MaterialButton(

                  child: Text("OK",style: TextStyle(color:Color(0xFF979DB0)),),
                  onPressed: ()async{

                    await DBProvider.db.deleteGoal(item.id);
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
                  child: Text("You are sure to delete the goal ?",),),
              ),
            ); });
        },
      ),

    );
  }

  User user;

  Future<List<Goal>> getList()async{

    user= await SettingsProvider().getUser();
    List<Goal> list = await DBProvider.db.getAllGoals();
    return (list.isNotEmpty)?list: [];
  }

  setState(){notifyListeners();}

}