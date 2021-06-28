import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'package:todolist/ModelView/add_new_task.dart';
import 'package:todolist/Models/provider_class.dart';
import 'package:todolist/Models/task_model.dart';
import 'package:todolist/Models/custom_expansion_tile.dart' as custom;
class TasksModel extends StatefulWidget {

  @override
  _TasksModelState createState() => _TasksModelState();
}



class _TasksModelState extends State<TasksModel> {


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
                            itemBuilder: (BuildContext context, int index){
                              return Container(
                                margin: EdgeInsets.all(5),
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
                                          onPressed: (){
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute<void>(
                                                builder: (BuildContext context) => AddNewTasks(
                                                  id: items[index].task.id,
                                                  category: items[index].task.category,
                                                  date: items[index].task.date,
                                                  dateReminder: items[index].task.dateReminder,
                                                  frequency: items[index].task.frequency,
                                                  goal: items[index].task.goal,
                                                  note: items[index].task.note,
                                                  status: items[index].task.status,
                                                  task: items[index].task.task,
                                                  time: items[index].task.time,
                                                  timeReminder: items[index].task.timeReminder,
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
