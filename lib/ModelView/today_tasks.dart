import 'package:flutter/material.dart';
import 'package:todolist/DataBase/database.dart';
import 'package:todolist/Models/task_model.dart';
import 'package:todolist/Models/custom_expansion_tile.dart' as custom;
class TodayTasks extends StatefulWidget {

  @override
  _TodayTasksState createState() => _TodayTasksState();
}

class Item{
Task task;
bool isExpanded;
  Item(Task task){
    this.task= task;
    this.isExpanded = false;
  }



 Widget getIcon(){
    switch(this.task.status){
      case "Important": /*C00000*/
        return Icon(Icons.circle_rounded,color: Color(0xFFC00000),);
        break;
      case "Less important": /* ff4500 */
        return Icon(Icons.circle_rounded,color: Color(0xFFFF4500));
              break;
      case "Finished"://00B98C
        return Icon(Icons.check_circle_outline_sharp,color: Color(0xFF6D6E70));
        break;
      case "Voluntary": /* 6D6E70 */
        return Icon(Icons.circle_rounded,color: Color(0xFF6D6E70));
          break;
      default : /* In progress  0269CA */
        return Icon(Icons.circle_rounded,color: Color(0xFF0269CA));
        break;

    }
  }
}

class _TodayTasksState extends State<TodayTasks> {





  Future<List<Task>> getListTaskToday()async{

    DateTime dateNow = DateTime.now();
    String date = dateNow.day.toString()+"/"+dateNow.month.toString()+"/"+dateNow.year.toString();
    List<Task> list = await DBProvider.db.getByDate(date, date);

    //setState(() {});
    return (list.isEmpty)?[]:list;
  }



  Widget pageViewToDay(){
    return Container(
      color: Theme.of(context).backgroundColor,
      child: FutureBuilder(
          future: getListTaskToday(),
          builder: (context,AsyncSnapshot snapshot){
            if(snapshot.hasData) {
              List<Task> list = snapshot.data;
              List<Item> items = List<Item>.generate(list.length, (int index) {
                return Item(list[index]);
              });
              print(items);

              return RefreshIndicator(
                onRefresh: ()async{
                  setState(() {});
                },
                child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount: items.length,
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

                            ListTile(
                              title: Text(
                                "Note : ",
                                style: TextStyle(fontWeight: FontWeight.w700 , color: Color(0xFF979DB0)),
                              ),
                              subtitle: Container(
                                height: 120,
                                child: Text(
                                  (items[index].task.note.isEmpty)?"Add a note...":items[index].task.note,
                                  style: TextStyle(fontWeight: FontWeight.w700 , color:Theme.of(context).floatingActionButtonTheme.backgroundColor),
                                ),
                              ),

                            )
                          ],
                        ),
                      );
                    }),
              );

            }

              return Center(child: Text("Take a break now you have no tasks"),);
          }),
    );
  }



  @override
  Widget build(BuildContext context) {



    return PageView(
      children: <Widget>[
        pageViewToDay(),
        Container(
          color: Colors.cyan,
        ),

      ],
    );
  }
}
