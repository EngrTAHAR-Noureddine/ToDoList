import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:todolist/DataBase/database.dart';
import 'package:todolist/ModelView/add_task.dart';
import 'package:todolist/Models/ProvidersClass/task_list_provider.dart';
import 'package:todolist/Models/custom_expansion_tile.dart' as custom;
import 'package:todolist/Models/ProvidersClass/provider_home_class.dart';
import 'package:todolist/Models/Data/task_model.dart';
import 'package:todolist/View/home_view.dart';


class SearchResult extends StatelessWidget {
  Future<List<Item>> getList(String searchItem)async{
    List<Task> list =(searchItem!=null && searchItem.isNotEmpty)? await DBProvider.db.getAllSearch(searchItem):[];
    List<Item> items =  (list.isEmpty)?[]:List<Item>.generate(list.length, (int index) {
    return Item(list[index]);
    });
    return items;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope (
      onWillPop: ()async{

          SwitchViews().index=0;
          SwitchViews().setState();
        Navigator.push(
          context,
          MaterialPageRoute<void>(
            builder: (BuildContext context) => Home(),
            fullscreenDialog: true,
          ),
        );
        return false;
      },
      child: Consumer<SwitchViews>(
          builder: (context, value, child) {
            return FutureBuilder(
                future: getList(value.searchItem),
                builder:(context,snapshot){
                  if(snapshot.hasData){
                    List<Item> items = snapshot.data;
                    if(items!=null && items.isNotEmpty){
                      return Container(
                        color: Theme.of(context).backgroundColor,
                        child: ListView.builder(

                            scrollDirection: Axis.vertical,
                            itemCount: items.length,
                            padding: EdgeInsets.all(5),
                            itemBuilder: (BuildContext context, int ind){
                              int index = items.length-ind-1;
                              return Consumer<ToDoListBodyProvider>(
                                  builder: (context, value, child) {
                                    return Container(
                                      margin: EdgeInsets.all(5),
                                      child:Slidable(
                                        actionPane: SlidableScrollActionPane(),
                                        actionExtentRatio: 0.5,

                                        actions: [ /*left */
                                          (items[index].task.status == "In progress")?
                                          ToDoListBodyProvider().finishedButton(context,items[index]):(items[index].task.status == "Finished")?ToDoListBodyProvider().renewalButton(context,items[index]):ToDoListBodyProvider().inProgressButton(context,items[index]),

                                        ],

                                        secondaryActions: [ /* right */
                                          ToDoListBodyProvider().deleteButton(context,items[index]),

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
                                                        builder: (BuildContext context) => AddNewTask(editTask:tk.task,

                                                        ),
                                                        fullscreenDialog: true,
                                                      ),
                                                    );
                                                    SwitchViews().setState();
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
                                  });
                            }),

                      );
                    }else{return Container(
                      color:Theme.of(context).backgroundColor,
                      alignment: Alignment.center,
                      child: Text("not found"),
                    );
                    }

                  }else{
                    return Container(
                      color:Theme.of(context).backgroundColor,
                      alignment: Alignment.center,
                      child: Text("not found"),
                    );
                  }
                });

          }),
    );
  }
}
