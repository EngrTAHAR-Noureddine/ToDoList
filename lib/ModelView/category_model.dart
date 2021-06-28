import 'package:flutter/material.dart';
import 'package:todolist/DataBase/database.dart';
import 'package:todolist/Models/data_variable.dart';
import 'package:todolist/Models/provider_class.dart';
import 'package:todolist/Models/task_model.dart';
class CategoryBuilder extends StatefulWidget {

  @override
  _CategoryBuilderState createState() => _CategoryBuilderState();
}

class _CategoryBuilderState extends State<CategoryBuilder> {

  Future<List<Category>> getCategories()async{

    List<Map> list = await DBProvider.db.getCategories();

    List<Category> listCat = list.map((c) => Category.fromMap(c)).toList();
    List<String> categoriesList = [];
    listCat.forEach((element) { categoriesList.add(element.category); });
    Variables().setCat(categoriesList);
    setState(() {});
    return (listCat.isNotEmpty)?listCat:[];
  }


  bool _isLarge;
  @override
  // ignore: must_call_super
  void initState() {
    _isLarge = Variables().isLarge;
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

                                        onPressed: (){

                                          ProviderClass().setWidget(list[index].category);

                                        },
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
                          ):Container(
                              width: MediaQuery.of(context).size.width,

                              alignment: Alignment.center,
                              child: Text("not exist categories",style:TextStyle(color:Theme.of(context).bottomAppBarColor ,fontSize:14,fontFamily: "Roboto") ,)),
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
