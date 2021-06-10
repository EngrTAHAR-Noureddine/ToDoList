import 'package:flutter/material.dart';
import 'package:todolist/DataBase/database.dart';
import 'package:todolist/Models/task_model.dart';

class CategoryLayout extends StatefulWidget {

  bool isLarge;

  CategoryLayout({this.isLarge});
  @override
  _CategoryLayoutState createState() => _CategoryLayoutState();
}

class _CategoryLayoutState extends State<CategoryLayout> {
  bool _isLarge;
  Future<List<Category>> getCategories()async{

    List<Map> list = await DBProvider.db.getCategories();

    List<Category> listCat = list.map((c) => Category.fromMap(c)).toList();

    return (listCat.isNotEmpty)?list:[];
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
          return Container(
            color: Theme.of(context).backgroundColor,
            child: ListView(
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              children: [
                Text("Categories",style: TextStyle(color:Color(0xFF979DB0) ,fontSize:20,fontFamily: "Roboto"),),
                Container(
                  height:(_isLarge)? 100:300,//MediaQuery.of(context).size.width,
                  width:(_isLarge)? MediaQuery.of(context).size.width:300,
                  /*child: ListView(
                   shrinkWrap: true,

                    scrollDirection:(_isLarge)? Axis.horizontal:Axis.vertical,
                    children: [

                      Container(
                        width: 200,
                        height: 100,
                        padding: EdgeInsets.all(0),
                        color: Theme.of(context).cardColor,
                        child: Card(
                          color: Theme.of(context).accentColor,
                          child: Icon(Icons.add,color: Theme.of(context).floatingActionButtonTheme.focusColor,size: 30,),
                        ),
                      ),
                      Container(
                        width: 200,
                        height: 100,
                        padding: EdgeInsets.all(0),
                        color: Theme.of(context).cardColor,
                        child: Card(
                          color: Theme.of(context).accentColor,
                          child: Icon(Icons.add,color: Theme.of(context).floatingActionButtonTheme.focusColor,size: 30,),
                        ),
                      ),
                     /* (snapshot.hasData)?
                      Container(
                          child: ListView.builder(
                              shrinkWrap: true,
                              scrollDirection:(_isLarge)? Axis.horizontal:Axis.vertical,
                              itemCount: list.length,

                              itemBuilder: (BuildContext context, int index) {
                                return Container(
                                  width: 200,
                                  height: 100,
                                  color: Theme.of(context).cardColor,
                                  padding: EdgeInsets.all(0),
                                  child: Card(
                                    color: Theme.of(context).accentColor,
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        Text("Task: "+list[index].count.toString(),style:TextStyle(color:Theme.of(context).bottomAppBarColor ,fontSize:16,fontFamily: "Roboto") ,),
                                        Text(list[index].category ,style: TextStyle(color:Theme.of(context).floatingActionButtonTheme.focusColor ,fontSize:20,fontFamily: "Roboto"),),
                                      ],
                                    ),
                                  ),
                                );
                              }
                          )
                      ):Container(),*/



                    ],
                  ),*/
                ),
              ],
            ),
          );

        }

    );
  }
}
