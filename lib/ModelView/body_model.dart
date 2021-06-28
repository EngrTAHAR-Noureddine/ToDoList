import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todolist/Models/data_variable.dart';
import 'package:todolist/Models/provider_class.dart';
import 'package:todolist/View/category_view.dart';
import 'package:todolist/View/tasks_view.dart';

class ToDoListBody extends StatefulWidget {

  @override
  _ToDoListBodyState createState() => _ToDoListBodyState();
}

class _ToDoListBodyState extends State<ToDoListBody> {
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
                CategoryView(),
                Expanded(child: TodayTasks()),
              ],
            )
                :
            Row(
              children: [
                CategoryView(),
                Expanded(child: TodayTasks()),
              ],
            )
            ;

    });}
    ));
  }
}
