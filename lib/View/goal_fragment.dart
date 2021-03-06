import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:todolist/DataBase/database.dart';
import 'package:todolist/ModelView/add_new_goal.dart';
import 'package:todolist/Models/custom_expansion_tile.dart' as custom;
import 'package:todolist/Models/Data/goal_model.dart';
import 'package:todolist/Models/ProvidersClass/goal_provider.dart';
import 'package:todolist/Models/ProvidersClass/settings_provider.dart';

class GoalView extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return Consumer<SettingsProvider>(
        builder: (context, value, child){
          return Container(
            color: Theme.of(context).backgroundColor,
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.all(10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Goals",style: TextStyle(color:Color(0xFF979DB0),fontSize: 20,),),

                      IconButton(
                          onPressed:()async{
                            if(SettingsProvider().user.hideGoal == "yes" && SettingsProvider().user.passWord!=null && SettingsProvider().user.passWord.isNotEmpty){
                              return await SettingsProvider().showDialogToHideGoals(context);
                            }else {
                              SettingsProvider().user.hideGoal=(SettingsProvider().user.hideGoal=="no")?"yes" :"no";
                              await DBProvider.db.updateUser(SettingsProvider().user);
                              SettingsProvider().setState();
                            }
                          },
                          color:Color(0xFF979DB0) ,
                          icon: (SettingsProvider().user != null &&
                              SettingsProvider().user.hideGoal == "no")
                              ? Icon(Icons.visibility)
                              : Icon(Icons.visibility_off)

                      )
                    ],
                  ),
                ),
                Expanded(
                  child: Container(
                    color: Theme.of(context).backgroundColor,
                    child: StreamBuilder(
                        stream: GoalProvider().getList(),
                        builder: (context,AsyncSnapshot snapshot){

                          if(snapshot.hasData) {

                            List<Goal> items = snapshot.data;

                            return RefreshIndicator(
                              onRefresh: ()async{
                                SettingsProvider().setState();
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
                                  :(SettingsProvider().user.hideGoal=="no")? ListView.builder(

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
                                          GoalProvider().deleteButton(context,items[index]),

                                        ],
                                        child: custom.ExpansionTile(

                                          iconColor: Color(0xFFA5ABBD),
                                          backgroundColor: Theme.of(context).backgroundColor,
                                          headerBackgroundColor: Theme.of(context).primaryColorLight,
                                          leading: Icon(Icons.radio_button_off_rounded,color: Color(0xFF6D6E70)),

                                          title: Text(
                                            items[index].goal,
                                            style: TextStyle(fontSize: 18.0,color: Theme.of(context).floatingActionButtonTheme.focusColor,),
                                          ),
                                          children: <Widget>[

                                            (items[index].reason.isNotEmpty)?  ListTile(
                                              title: Text(
                                                "Reason : ",
                                                style: TextStyle(fontWeight: FontWeight.normal , color: Color(0xFF979DB0)),
                                              ),
                                              subtitle: Container(

                                                child: Text(
                                                  items[index].reason,
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
                                                    Goal dr = items[index];
                                                    await DBProvider.db.deleteGoal(items[index].id);
                                                    Navigator.push(
                                                      context,
                                                      MaterialPageRoute<void>(
                                                        builder: (BuildContext context) => AddGoal(
                                                          id: dr.id,
                                                          goal: dr.goal,
                                                          note: dr.note,
                                                          reason: dr.reason,
                                                        ),
                                                        fullscreenDialog: true,
                                                      ),
                                                    );
                                                    SettingsProvider().setState();
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
                                  }):Container(

                                child: Text("Sorry! is Privacy",  style: TextStyle(fontWeight: FontWeight.normal , color: Color(0xFF979DB0)),),
                                alignment: Alignment.center,



                              ),
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


