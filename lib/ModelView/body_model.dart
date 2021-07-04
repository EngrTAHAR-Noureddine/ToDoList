import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todolist/Models/Data/data_variable.dart';
import 'package:todolist/View/category_view.dart';
import 'package:todolist/View/list_of_tasks.dart';

class ToDoListBody extends StatefulWidget {

  @override
  _ToDoListBodyState createState() => _ToDoListBodyState();
}

class _ToDoListBodyState extends State<ToDoListBody> {
  @override
  Widget build(BuildContext context) {




          return OrientationBuilder(builder: (context, orientation) {
            Variables().isLarge =  (orientation == Orientation.portrait);
            return (Variables().isLarge)?
            Column(
              children: [
                CategoryView(),
                Expanded(child: ListOfTasks()),
              ],
            )
                :
            Row(
              children: [
                CategoryView(),
                Expanded(child: ListOfTasks()),
              ],
            )
            ;

    });


  }
}
