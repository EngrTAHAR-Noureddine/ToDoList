import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todolist/ModelView/today_tasks.dart';
import 'package:todolist/Models/data_variable.dart';
import 'package:todolist/Models/provider_class.dart';
import 'package:todolist/View/category_view.dart';

class ToDoList extends StatefulWidget {

  @override
  _ToDoListState createState() => _ToDoListState();
}

class _ToDoListState extends State<ToDoList> {
  @override
  Widget build(BuildContext context) {


    return ChangeNotifierProvider<ProviderClass>(
        create: (context) => ProviderClass(),
        child: Builder(
        builder: (context) {

          return OrientationBuilder(builder: (context, orientation) {
            Variables().isLarge =  (orientation == Orientation.portrait);
            return (Variables().isLarge)?
            Column(
              children: [
                CategoryLayout(),
                Expanded(child: TodayTasks()),
              ],
            )
                :
            Row(
              children: [
                CategoryLayout(),
                Expanded(child: TodayTasks()),
              ],
            )
            ;

    });}
    ));
  }
}
