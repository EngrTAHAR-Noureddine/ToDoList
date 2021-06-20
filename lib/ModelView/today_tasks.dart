import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todolist/DataBase/database.dart';
import 'package:todolist/Models/provider_class.dart';
import 'package:todolist/Models/task_model.dart';
import 'package:todolist/Models/custom_expansion_tile.dart' as custom;
class TodayTasks extends StatefulWidget {

  @override
  _TodayTasksState createState() => _TodayTasksState();
}



class _TodayTasksState extends State<TodayTasks> {




/*
  Future<List<Task>> getListTaskToday()async{

    DateTime dateNow = DateTime.now();
    String date = dateNow.day.toString()+"/"+dateNow.month.toString()+"/"+dateNow.year.toString();
    List<Task> list = await DBProvider.db.getByDate(date, date);

    //setState(() {});
    return (list.isEmpty)?[]:list;
  }

*/
/*
  Widget pageViewToDay(){
    return Container(
      color: Theme.of(context).backgroundColor,
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.all(10),
            child: Row(
              children: [
                Text("TODAY'S TASKS",style: TextStyle(color:Color(0xFF979DB0),fontSize: 20,),),
              ],
            ),
          ),
          Expanded(
            child: Container(
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
                        backgroundColor: Theme.of(context).backgroundColor,
                        color: Theme.of(context).primaryColor,
                        child: ListView.builder(
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

                                    ListTile(
                                      title: Text(
                                        "Note : ",
                                        style: TextStyle(fontWeight: FontWeight.normal , color: Color(0xFF979DB0)),
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

                      return Center(child: Text("Take a break now you have no tasks",  style: TextStyle(fontWeight: FontWeight.normal , color: Color(0xFF979DB0)),),);
                  }),
            ),
          ),
        ],
      ),
    );
  }*/
 /* Future<List<Task>> getListTaskTomorrow()async{

    DateTime dateNow = DateTime.now();
    DateTime tomorrow = DateTime(dateNow.year, dateNow.month, dateNow.day + 1);
    String date = tomorrow.day.toString()+"/"+tomorrow.month.toString()+"/"+tomorrow.year.toString();

    List<Task> list = await DBProvider.db.getByDate(date, date);

    return (list.isEmpty)?[]:list;
  }*/
  /*
  Widget pageViewTomorrow(){
    return Container(
      color: Theme.of(context).backgroundColor,
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.all(10),
            child: Row(
              children: [
                Text("TOMORROW'S TASKS",style: TextStyle(color:Color(0xFF979DB0),fontSize: 20,),),
              ],
            ),
          ),
          Expanded(
            child: Container(
              color: Theme.of(context).backgroundColor,
              child: FutureBuilder(
                  future: getListTaskTomorrow(),
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
                        backgroundColor: Theme.of(context).backgroundColor,
                        color: Theme.of(context).primaryColor,
                        child: ListView.builder(
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

                                    ListTile(
                                      title: Text(
                                        "Note : ",
                                        style: TextStyle(fontWeight: FontWeight.normal , color: Color(0xFF979DB0)),
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

                    return Center(child: Text("Take a break now you have no tasks",  style: TextStyle(fontWeight: FontWeight.normal , color: Color(0xFF979DB0)),),);
                  }),
            ),
          ),
        ],
      ),
    );
  }

*/
 /* Future<List<Task>> getListTaskCategory(String category)async{


    List<Task> list = await DBProvider.db.getCategory(category);

    return (list.isEmpty)?[]:list;
  }*/

  Widget pageViewCategory(String category){

    return Container(
      color: Theme.of(context).backgroundColor,
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.all(10),
            child: Row(
              children: [
                Text(category+"'S TASKS",style: TextStyle(color:Color(0xFF979DB0),fontSize: 20,),),
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
                        child:(items.isEmpty)?Center(
                          child: Text("Take a break now you have no tasks",  style: TextStyle(fontWeight: FontWeight.normal , color: Color(0xFF979DB0)),),)
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

                                    ListTile(
                                      title: Text(
                                        "Note : ",
                                        style: TextStyle(fontWeight: FontWeight.normal , color: Color(0xFF979DB0)),
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

                    return Center(child: Text("Take a break now you have no tasks",  style: TextStyle(fontWeight: FontWeight.normal , color: Color(0xFF979DB0)),),);
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
