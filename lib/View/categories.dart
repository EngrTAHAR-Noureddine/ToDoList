import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todolist/Models/ProvidersClass/task_button.dart';
import 'package:todolist/Models/category_class.dart';
import 'package:todolist/Models/Data/data_variable.dart';
import 'package:todolist/Models/Data/task_model.dart';


class Categories extends StatefulWidget {


  @override
  _CategoriesState createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {

  bool _isLarge;
  @override
  // ignore: must_call_super
  void initState() {
    _isLarge = Variables().isLarge;
  }
  @override
  Widget build(BuildContext context) {
    initState();
    return StreamBuilder(
        stream: CategoryFunction().getCategories(),
        builder: (context, AsyncSnapshot snapshot) {
          List<Category> list = (snapshot.hasData)?snapshot.data:[];
          if(list.isNotEmpty){
            List<String> cats= [];
            list.forEach((element) {cats.add(element.category);});
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
                                    return CategoryFunction().categoryWidget(context, list[index]);
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