import 'package:flutter/material.dart';
import 'package:todolist/Models/ProvidersClass/task_list_provider.dart';
import 'package:todolist/Models/Data/data_variable.dart';
import 'package:todolist/Models/Data/task_model.dart';

class Categories extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: ToDoListBodyProvider().getCategories(),
        builder: (context, AsyncSnapshot snapshot) {
          List<Category> list = (snapshot.hasData) ? snapshot.data : [];
          if (list.isNotEmpty) {
            List<String> cats = [];
            list.forEach((element) {
              cats.add(element.category);
            });
            Variables().setCat(cats);
          }
          return Container(
            color: Theme
                .of(context)
                .backgroundColor,
            width: (Variables().isLarge) ? MediaQuery
                .of(context)
                .size
                .width : 220,
            height: (Variables().isLarge) ? 170 : MediaQuery
                .of(context)
                .size
                .width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  color: Colors.transparent,
                  height: 50,
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.only(left: 10),
                  child: Text("Categories", style: TextStyle(
                      color: Color(0xFF979DB0),
                      fontSize: 20,
                      fontFamily: "Roboto"),),
                ),
                Expanded(
                  child: Container(

                    color: Colors.transparent,
                    child: ListView(
                        scrollDirection: (Variables().isLarge) ? Axis.horizontal : Axis
                            .vertical,
                        children: [

                          (snapshot.hasData) ?
                          Container(
                              child: ListView.builder(
                                  shrinkWrap: true,
                                  scrollDirection: (Variables().isLarge) ? Axis
                                      .horizontal : Axis.vertical,
                                  physics: ScrollPhysics(),
                                  itemCount: list.length,

                                  itemBuilder: (BuildContext context,
                                      int index) {
                                    return ToDoListBodyProvider().categoryWidget(
                                        context, list[index]);
                                  }
                              )
                          ) : Container(
                              width: MediaQuery
                                  .of(context)
                                  .size
                                  .width,

                              alignment: Alignment.center,
                              child: Text("not exist categories",
                                style: TextStyle(color: Theme
                                    .of(context)
                                    .bottomAppBarColor,
                                    fontSize: 14,
                                    fontFamily: "Roboto"),)),
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
