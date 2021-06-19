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
        return Icon(Icons.radio_button_off_rounded,color: Color(0xFFC00000),);
        break;
      case "Less important": /* ff4500 */
        return Icon(Icons.radio_button_off_rounded,color: Color(0xFFFF4500));
              break;
      case "Finished"://00B98C
        return Icon(Icons.task_alt_rounded,color: Color(0xFF6D6E70));
        break;
      case "Voluntary": /* 6D6E70 */
        return Icon(Icons.radio_button_off_rounded,color: Color(0xFF6D6E70));
          break;
      default : /* In progress  0269CA */
        return Icon(Icons.radio_button_off_rounded,color: Color(0xFF0269CA));
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
  }
///******************************************************************* TOMORROW **********************
  Future<List<Task>> getListTaskTomorrow()async{

    DateTime dateNow = DateTime.now();
    DateTime tomorrow = DateTime(dateNow.year, dateNow.month, dateNow.day + 1);
    String date = tomorrow.day.toString()+"/"+tomorrow.month.toString()+"/"+tomorrow.year.toString();

    List<Task> list = await DBProvider.db.getByDate(date, date);

    return (list.isEmpty)?[]:list;
  }
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


  ///***************************** get with category ************************************
  Future<List<Task>> getListTaskCategory(String category)async{


    List<Task> list = await DBProvider.db.getCategory(category);

    return (list.isEmpty)?[]:list;
  }

  Widget pageViewCategory(String category){
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
                  future: getListTaskCategory(category),
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
 ///*************************************************************************************
  //PageController _controller=PageController(initialPage: 0);
 bool _ishe=false;
 String category;
  @override
  Widget build(BuildContext context) {

//TODO na7i provider se  dir setState
/// provider tchangi we tfawet les variables sans changer the widgets
    /// tsema ra7 tna7iha men l7sab , makhadmetlekch
    ///
    return ChangeNotifierProvider<ProviderClass>(
        create: (context) => ProviderClass(),
        child: Builder(
        builder: (context) {

                 return   PageView.builder(
                   itemCount: ProviderClass().listWidgets.length,

                   scrollDirection: Axis.horizontal,
                   onPageChanged: (index){
                           print("inside pageview : "+ ProviderClass().categoryName());

                       if(ProviderClass().categoryName()!="click_button"){

                         ProviderClass().removewidget();
                        // ProviderClass().controller.jumpToPage(0);
                         print("length in set widget : "+ProviderClass().listWidgets.length.toString());
                       }
                       
                   },
                   controller: ProviderClass().controller,
                   itemBuilder: (context, index){
                     return ProviderClass().listWidgets[index];
                   },
             /*      children: <Widget>[
                     if(ProviderClass().categoryName()!="click_button")Container(color:Colors.blue),//pageViewCategory(category),
                     pageViewToDay(),
                     pageViewTomorrow(),

                   ],*/
                 );
        }
        )
    );


  }
}
