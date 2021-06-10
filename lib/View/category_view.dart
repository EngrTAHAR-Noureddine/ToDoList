import 'package:flutter/material.dart';
import 'package:todolist/DataBase/database.dart';
import 'package:todolist/Models/data_variable.dart';
import 'package:todolist/Models/task_model.dart';

class CategoryLayout extends StatefulWidget {

  bool isLarge;

  CategoryLayout({this.isLarge});
  @override
  _CategoryLayoutState createState() => _CategoryLayoutState();
}

class _CategoryLayoutState extends State<CategoryLayout> {
  bool _isLarge;

  Future<bool> getTask()async{
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final tomorrow = DateTime(now.year, now.month, now.day + 1);

    String dateToday =
        today.year.toString()+"-"+today.month.toString()+"-"+today.day.toString();
    String dateTomorrow =
        tomorrow.year.toString()+"-"+tomorrow.month.toString()+"-"+tomorrow.day.toString();
    List<Task> tasksToday = await DBProvider.db.getByDate(dateToday);
    List<Task> tasktomorrow= await DBProvider.db.getByDate(dateTomorrow);
    List<Task> tasktemporary =await DBProvider.db.getTemporary("temporary");
    bool isExist;
    if(tasksToday.isNotEmpty||tasktomorrow.isNotEmpty||tasktemporary.isNotEmpty){
      Variables().setTask("today", tasksToday.length);
      Variables().setTask("tomorrow", tasktomorrow.length);
      Variables().setTask("temporary", tasktemporary.length);
    isExist = true;
    }else isExist = false;

    return isExist;
  }

  Future<List<Category>> getCategories()async{

    List<Map> list = await DBProvider.db.getCategories();

    List<Category> listCat = list.map((c) => Category.fromMap(c)).toList();

    return (listCat.isNotEmpty)?listCat:[];
  }

  @override
  void initState() {
    _isLarge = widget.isLarge;
  }
  @override
  Widget build(BuildContext context) {
    initState();
    return FutureBuilder(
        future: getCategories(),
        builder: (context, AsyncSnapshot snapshot) {
          List<Category> list = (snapshot.hasData)?snapshot.data:[];
          if(list.isNotEmpty){
            List<String> cats= [];
            list.forEach((element) {cats.add(element.category); });
            Variables().setCat(cats);
          }
          return Container(
            color: Theme.of(context).backgroundColor,
            width:(_isLarge)?MediaQuery.of(context).size.width:220,
            height: (_isLarge)?170:MediaQuery.of(context).size.width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  color: Colors.transparent,
                  height: 50,
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.only(left: 10),
                  child: Text("Categories",style: TextStyle(color:Color(0xFF979DB0) ,fontSize:20,fontFamily: "Roboto"),),
                ),
                Expanded(
                  child: Container(

                    color: Colors.transparent,
                    child: ListView(
                        scrollDirection:(_isLarge)? Axis.horizontal:Axis.vertical,
                      children:[
                       FutureBuilder(
                           future: getTask(),
                           builder:(context,AsyncSnapshot snapshot){
                             bool isExistTasks = (snapshot.hasData)?snapshot.data:false;
                             print("dakhel getTAsk");
                             print(snapshot.error);
                             print("_______________");
                             List<String> listTask;
                             (isExistTasks)?listTask=Variables().getKeys():listTask=[];
                             return (isExistTasks)?
                             Container(
                                 child: ListView.builder(
                                     shrinkWrap: true,
                                     scrollDirection:(_isLarge)? Axis.horizontal:Axis.vertical,
                                     physics: ScrollPhysics(),
                                     itemCount: listTask.length,

                                     itemBuilder: (BuildContext context, int index) {
                                       return Container(
                                         width: 200,
                                         height: 100,
                                         margin: EdgeInsets.all(10),
                                         padding: EdgeInsets.all(0),

                                         decoration: BoxDecoration(
                                           borderRadius: BorderRadius.all(Radius.circular(20)),
                                           boxShadow: [

                                             BoxShadow(
                                               color: Color(0x40000000),//.withOpacity(0.5),
                                               spreadRadius: 0,
                                               blurRadius: 4,
                                               offset: Offset(0, 4), // changes position of shadow
                                             ),
                                           ],
                                           color: Theme.of(context).cardColor,
                                         ),
                                         child: MaterialButton(

                                           onPressed: (){},
                                           colorBrightness:Theme.of(context).primaryColorBrightness,
                                           padding: EdgeInsets.only(left: 10),
                                           elevation: 3,
                                           shape: RoundedRectangleBorder(
                                               borderRadius: BorderRadius.circular(20)
                                           ),
                                           color: Theme.of(context).accentColor,
                                           child: Column(
                                             mainAxisAlignment: MainAxisAlignment.spaceAround,
                                             crossAxisAlignment: CrossAxisAlignment.start,

                                             children: [
                                               Align(
                                                   alignment: Alignment.topLeft,
                                                   child: Text("Task: "+Variables().getNum(listTask[index]).toString(),style:TextStyle(color:Theme.of(context).bottomAppBarColor ,fontSize:16,fontFamily: "Roboto") ,)
                                               ),
                                               Text(listTask[index] ,style: TextStyle(color:Theme.of(context).floatingActionButtonTheme.focusColor ,fontSize:20,fontFamily: "Roboto"),),
                                             ],
                                           ),
                                         ),
                                       );
                                     }
                                 )
                             ):Container();
                           }),


                        (snapshot.hasData)?
                      Container(
                          child: ListView.builder(
                              shrinkWrap: true,
                              scrollDirection:(_isLarge)? Axis.horizontal:Axis.vertical,
                              physics: ScrollPhysics(),
                              itemCount: list.length,

                              itemBuilder: (BuildContext context, int index) {
                                return Container(
                                  width: 200,
                                  height: 100,
                                  margin: EdgeInsets.all(10),
                                  padding: EdgeInsets.all(0),

                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(Radius.circular(20)),
                                    boxShadow: [

                                      BoxShadow(
                                        color: Color(0x40000000),//.withOpacity(0.5),
                                        spreadRadius: 0,
                                        blurRadius: 4,
                                        offset: Offset(0, 4), // changes position of shadow
                                      ),
                                    ],
                                    color: Theme.of(context).cardColor,
                                  ),
                                  child: MaterialButton(

                                    onPressed: (){},
                                    colorBrightness:Theme.of(context).primaryColorBrightness,
                                    padding: EdgeInsets.only(left: 10),
                                    elevation: 3,
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(20)
                                    ),
                                    color: Theme.of(context).accentColor,
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                                      crossAxisAlignment: CrossAxisAlignment.start,

                                      children: [
                                        Align(
                                            alignment: Alignment.topLeft,
                                            child: Text("Task: "+list[index].count.toString(),style:TextStyle(color:Theme.of(context).bottomAppBarColor ,fontSize:16,fontFamily: "Roboto") ,)
                                        ),
                                        Text(list[index].category ,style: TextStyle(color:Theme.of(context).floatingActionButtonTheme.focusColor ,fontSize:20,fontFamily: "Roboto"),),
                                      ],
                                    ),
                                  ),
                                );
                              }
                          )
                      ):Text("not exist categories",style:TextStyle(color:Theme.of(context).bottomAppBarColor ,fontSize:14,fontFamily: "Roboto") ,),
                    ]
                    ),
                  ),
                ),
              ],
            ),

          );

        }

    );
  }
}
