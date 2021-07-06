import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:todolist/DataBase/database.dart';
import 'package:todolist/ModelView/add_new_task.dart';
import 'package:todolist/Models/Data/data_variable.dart';
import 'package:todolist/Models/ProvidersClass/provider_class.dart';
import 'package:todolist/Models/Data/task_model.dart';
import 'package:todolist/Models/custom_expansion_tile.dart' as custom;
import '../Models/ProvidersClass/task_button.dart';

class PageOfTasks extends StatelessWidget {

  String category;
  PageOfTasks({this.category});


  @override
  Widget build(BuildContext context) {
    return Consumer<TaskButton>(
        builder: (context, value, child) {
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
                    child: StreamBuilder(
                        stream: TaskFunctions().getList(category),
                        builder: (context,AsyncSnapshot snapshot){

                          if(snapshot.hasData) {

                            List<Item> items = snapshot.data;

                            return RefreshIndicator(
                              onRefresh: ()async{
                                ProviderClass().setState();

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
                                          (items[index].task.status == Variables().status[0])?
                                          TaskButton().finishedButton(context,items[index]):(items[index].task.status == Variables().status[4])?TaskButton().renewalButton(context,items[index]):TaskButton().inProgressButton(context,items[index]),



                                        ],

                                        secondaryActions: [ /* right */
                                          TaskButton().deleteButton(context,items[index]),

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
                                                    // Workmanager().cancelAll();
                                                    //await LocalNotification.flutterNotificationPlugin.cancelAll();
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
                                                    ProviderClass().setState();
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
        });
  }


}