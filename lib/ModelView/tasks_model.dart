import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:todolist/DataBase/database.dart';
import 'package:todolist/ModelView/add_new_task.dart';
import 'package:todolist/Models/provider_class.dart';
import 'package:todolist/Models/task_model.dart';
import 'package:todolist/Models/custom_expansion_tile.dart' as custom;
class TasksModel extends StatefulWidget {

  @override
  _TasksModelState createState() => _TasksModelState();
}



class _TasksModelState extends State<TasksModel> {

  /// inProgressButton
  /// *******************************************************************
Widget inProgressButton(item){
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
        setState(() {});
      },

    ),
  );
}
/// finishedButton
/// *******************************************************************************
Widget finishedButton(item){
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
        setState(() {});
      },

    ),
  );
}
/// renewalButton
/// ************************************************************************************

Widget renewalButton(item){
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
        setState(() {});
      },

    ),
  );
}

/// deleteButton
/// ************************************************************************************************
Widget deleteButton(item){
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
                  setState(() {

                  });
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


/// build
/// ***********************************************************************************


  Widget pageViewCategory(String category){

    return Container(
      color: Theme.of(context).backgroundColor,
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.all(10),
            child: Row(
              children: [
                Text(category+"'s Tasks",style: TextStyle(color:Color(0xFF979DB0),fontSize: 20,),),
              ],
            ),
          ),
          Expanded(
            child: Container(
              color: Theme.of(context).backgroundColor,
              child: FutureBuilder(
                  future: TaskFunctions().getList(category),
                  builder: (context,AsyncSnapshot snapshot){
                    print(snapshot.hasData);
                    print(snapshot.data);
                    print(snapshot.hasError);
                    print(snapshot.error);

                    if(snapshot.hasData) {

                      List<Item> items = snapshot.data;

                      return RefreshIndicator(
                        onRefresh: ()async{
                          setState(() {});
                        },
                        backgroundColor: Theme.of(context).backgroundColor,
                        color: Theme.of(context).primaryColor,
                        child:(items.isEmpty)?Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(

                              child: Text("Take a break now you have no tasks",  style: TextStyle(fontWeight: FontWeight.normal , color: Color(0xFF979DB0)),),
                            alignment: Alignment.center,



                            ),
                          ],
                        )
                            : ListView.builder(

                            scrollDirection: Axis.vertical,
                            itemCount: items.length,
                            padding: EdgeInsets.all(5),
                            itemBuilder: (BuildContext context, int ind){
                              int index = items.length-ind-1;
                              return Container(
                                margin: EdgeInsets.all(5),
                                child:Slidable(
                                    actionPane: SlidableScrollActionPane(),
                                    actionExtentRatio: 0.5,

                                    actions: [ /*left */
                                      (items[index].task.status == "In progress")?
                                         finishedButton(items[index]):(items[index].task.status == "Finished")?renewalButton(items[index]):inProgressButton(items[index]),
                                      
                                         

                                    ],

                                    secondaryActions: [ /* right */
                                      deleteButton(items[index]),

                                    ],
                                    child: custom.ExpansionTile(

                                                      iconColor: Color(0xFFA5ABBD),
                                                      backgroundColor: Theme.of(context).backgroundColor,
                                                      headerBackgroundColor: Theme.of(context).primaryColorLight,
                                                      leading: items[index].getIcon(),

                                                      title: Text(
                                                        items[index].task.task,
                                                        style: TextStyle(fontSize: 18.0,color: Theme.of(context).floatingActionButtonTheme.focusColor,),
                                                      ),
                                                      children: <Widget>[

                                                        (items[index].task.goal.isNotEmpty)?  ListTile(
                                                          title: Text(
                                                            "Goal : ",
                                                            style: TextStyle(fontWeight: FontWeight.normal , color: Color(0xFF979DB0)),
                                                          ),
                                                          subtitle: Container(

                                                            child: Text(
                                                              items[index].task.goal,
                                                              style: TextStyle(fontWeight: FontWeight.w700 , color:Theme.of(context).floatingActionButtonTheme.backgroundColor),
                                                            ),
                                                          ),

                                                        ):Container(),

                                                        (items[index].task.note.isNotEmpty)? ListTile(
                                                          title: Text(
                                                            "Note : ",
                                                            style: TextStyle(fontWeight: FontWeight.normal , color: Color(0xFF979DB0)),
                                                          ),
                                                          subtitle: Container(

                                                            child: Text(
                                                              items[index].task.note,
                                                              style: TextStyle(fontWeight: FontWeight.w700 , color:Theme.of(context).floatingActionButtonTheme.backgroundColor),
                                                            ),
                                                          ),

                                                        ):Container(),
                                                        Container(
                                                          alignment: Alignment.center,
                                                          padding: EdgeInsets.all(2),
                                                          child: CircleAvatar(
                                                            backgroundColor: Colors.transparent,
                                                            child: IconButton(
                                                              padding: EdgeInsets.all(0),
                                                              onPressed: ()async{
                                                                Item tk = items[index];
                                                                await DBProvider.db.deleteTask(items[index].task.id);
                                                                Navigator.push(
                                                                  context,
                                                                  MaterialPageRoute<void>(
                                                                    builder: (BuildContext context) => AddNewTasks(
                                                                      id: tk.task.id,
                                                                      category: tk.task.category,
                                                                      date: tk.task.date,
                                                                      dateReminder: tk.task.dateReminder,
                                                                      frequency: tk.task.frequency,
                                                                      goal: tk.task.goal,
                                                                      note: tk.task.note,
                                                                      status: tk.task.status,
                                                                      task: tk.task.task,
                                                                      time: tk.task.time,
                                                                      timeReminder: tk.task.timeReminder,
                                                                    ),
                                                                    fullscreenDialog: true,
                                                                  ),
                                                                );
                                                                setState(() {});
                                                              },
                                                              icon :Icon( Icons.edit),
                                                              iconSize: 20,
                                                              color:  Color(0xFF979DB0),

                                                            ),
                                                          ),
                                                        )

                                                      ],
                                                    ),

                                ),
                              );
                            }),
                      );

                    }else  return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Center(child: Text("Be patient...",  style: TextStyle(fontWeight: FontWeight.normal , color: Color(0xFF979DB0)),),),
                      ],
                    );
                  }),
            ),
          ),
        ],
      ),
    );
  }
 ///*************************************************************************************

  @override
  Widget build(BuildContext context) {


    return Consumer<ProviderClass>(
      builder: (context, value, child) {
        return PageView.builder(
          itemCount: value.listWidgets.length,
          scrollDirection: Axis.horizontal,
          controller: value.controller,
          itemBuilder: (context, index){
            return pageViewCategory(value.listWidgets[index]);
          },
          onPageChanged: (index){
           if(index>0) if(value.listWidgets.length>2) value.removeWidget();
          },
        );
      },

    );


  }
}
