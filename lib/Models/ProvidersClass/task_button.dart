import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:todolist/DataBase/database.dart';

class TaskButton extends ChangeNotifier{
  static final TaskButton _singleton = TaskButton._internal();
  factory TaskButton() {
    return _singleton;
  }
  TaskButton._internal();

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
          item.task.status = "In progress";
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
          item.task.status = "Finished";
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
          item.task.status = "Voluntary";
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

  setState(){
    notifyListeners();
  }
}