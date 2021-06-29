import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:todolist/DataBase/database.dart';
import 'package:todolist/ModelView/add_new_task.dart';
import 'package:todolist/Models/draft_model.dart';
import 'package:todolist/Models/custom_expansion_tile.dart' as custom;
class DraftLists extends StatefulWidget {
  const DraftLists({Key key}) : super(key: key);

  @override
  _DraftListsState createState() => _DraftListsState();
}

class _DraftListsState extends State<DraftLists> {
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

                    await DBProvider.db.deleteDraft(item.id);
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

  @override
  Widget build(BuildContext context) {
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
                  future: DBProvider.db.getAllDraft(),
                  builder: (context,AsyncSnapshot snapshot){
                    print(snapshot.hasData);
                    print(snapshot.data);
                    print(snapshot.hasError);
                    print(snapshot.error);

                    if(snapshot.hasData) {

                      List<Draft> items = snapshot.data;

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

                              child: Text("is Empty",  style: TextStyle(fontWeight: FontWeight.normal , color: Color(0xFF979DB0)),),
                              alignment: Alignment.center,



                            ),
                          ],
                        )
                            : ListView.builder(
                            scrollDirection: Axis.vertical,
                            itemCount: items.length,
                            padding: EdgeInsets.all(5),
                            itemBuilder: (BuildContext context, int index){
                              return Container(
                                margin: EdgeInsets.all(5),
                                child:Slidable(
                                  actionPane: SlidableScrollActionPane(),
                                  actionExtentRatio: 0.5,


                                  secondaryActions: [ /* right */
                                    deleteButton(items[index]),

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
                                            onPressed: (){
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute<void>(
                                                  builder: (BuildContext context) => AddNewTasks(
                                                    id: items[index].id,
                                                    category: items[index].category,
                                                    date: items[index].date,
                                                    dateReminder: items[index].dateReminder,
                                                    frequency: items[index].frequency,
                                                    goal: items[index].goal,
                                                    note: items[index].note,
                                                    status: items[index].status,
                                                    task: items[index].task,
                                                    time: items[index].time,
                                                    timeReminder: items[index].timeReminder,
                                                  ),
                                                  fullscreenDialog: true,
                                                ),
                                              );
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
}
