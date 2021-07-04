import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:todolist/DataBase/database.dart';
import 'package:todolist/Models/ProvidersClass/task_button.dart';
import 'package:todolist/ModelView/add_new_task.dart';
import 'package:todolist/Models/Data/draft_model.dart';
import 'package:todolist/Models/custom_expansion_tile.dart' as custom;


class ListOfDrafts extends StatelessWidget{
  Future<List<Draft>> getList()async{
    List<Draft> list = await DBProvider.db.getAllDraft();
    return (list.isNotEmpty)?list: [];
  }
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
                      Text("Draft's Tasks",style: TextStyle(color:Color(0xFF979DB0),fontSize: 20,),),
                    ],
                  ),
                ),
                Expanded(
                  child: Container(
                    color: Theme.of(context).backgroundColor,
                    child: FutureBuilder(
                        future: getList(),
                        builder: (context,AsyncSnapshot snapshot){
                          if(snapshot.hasData) {

                            List<Draft> items = snapshot.data;

                            return RefreshIndicator(
                              onRefresh: ()async{
                                TaskButton().setState();
                              },
                              backgroundColor: Theme.of(context).backgroundColor,
                              color: Theme.of(context).primaryColor,
                              child:(items.isEmpty)?Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(

                                    child: Text("is Empty",  style: TextStyle(fontWeight: FontWeight.normal , color: Color(0xFF979DB0)),),
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
                                        secondaryActions: [ /* right */
                                          TaskButton().deleteDraft(context,items[index]),

                                        ],
                                        child: custom.ExpansionTile(

                                          iconColor: Color(0xFFA5ABBD),
                                          backgroundColor: Theme.of(context).backgroundColor,
                                          headerBackgroundColor: Theme.of(context).primaryColorLight,
                                          leading: Icon(Icons.radio_button_off_rounded,color: Color(0xFF6D6E70)),

                                          title: Text(
                                            items[index].task,
                                            style: TextStyle(fontSize: 18.0,color: Theme.of(context).floatingActionButtonTheme.focusColor,),
                                          ),
                                          children: <Widget>[

                                            (items[index].goal.isNotEmpty)?  ListTile(
                                              title: Text(
                                                "Goal : ",
                                                style: TextStyle(fontWeight: FontWeight.normal , color: Color(0xFF979DB0)),
                                              ),
                                              subtitle: Container(

                                                child: Text(
                                                  items[index].goal,
                                                  style: TextStyle(fontWeight: FontWeight.w700 , color:Theme.of(context).floatingActionButtonTheme.backgroundColor),
                                                ),
                                              ),

                                            ):Container(),

                                            (items[index].note.isNotEmpty)? ListTile(
                                              title: Text(
                                                "Note : ",
                                                style: TextStyle(fontWeight: FontWeight.normal , color: Color(0xFF979DB0)),
                                              ),
                                              subtitle: Container(

                                                child: Text(
                                                  items[index].note,
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
                                                    Draft dr = items[index];
                                                    await DBProvider.db.deleteDraft(items[index].id);
                                                    Navigator.push(
                                                      context,
                                                      MaterialPageRoute<void>(
                                                        builder: (BuildContext context) => AddNewTasks(
                                                          id: dr.id,
                                                          category: dr.category,
                                                          date: dr.date,
                                                          dateReminder: dr.dateReminder,
                                                          frequency: dr.frequency,
                                                          goal: dr.goal,
                                                          note: dr.note,
                                                          status: dr.status,
                                                          task: dr.task,
                                                          time: dr.time,
                                                          timeReminder: dr.timeReminder,
                                                        ),
                                                        fullscreenDialog: true,
                                                      ),
                                                    );
                                                    TaskButton().setState();
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