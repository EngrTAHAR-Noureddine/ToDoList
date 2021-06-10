import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todolist/ModelView/today_tasks.dart';
import 'package:todolist/View/category_view.dart';

class ToDoList extends StatefulWidget {

  @override
  _ToDoListState createState() => _ToDoListState();
}

class _ToDoListState extends State<ToDoList> {
  @override
  Widget build(BuildContext context) {
    bool isLarge ;

    return OrientationBuilder(builder: (context, orientation) {
            isLarge =  (orientation == Orientation.portrait);
            return (isLarge)?
            Column(
              children: [
                CategoryLayout(isLarge:isLarge),
                Expanded(child: TodayTasks(isLarge:isLarge)),
              ],
            )
                :
            Row(
              children: [
                CategoryLayout(isLarge:isLarge),
                Expanded(child: TodayTasks(isLarge:isLarge)),
              ],
            )
            ;
      /*ListView(
              scrollDirection: Axis.vertical,
              children: [
                CategoryLayout(isLarge:isLarge),
                TodayTasks(isLarge:isLarge),
              ],
            );*/
    });
  }
}
