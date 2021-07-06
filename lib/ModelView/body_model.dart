import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todolist/Models/Data/data_variable.dart';
import 'package:todolist/Models/ProvidersClass/task_list_provider.dart';
import 'package:todolist/View/categories.dart';
import 'package:todolist/View/list_of_tasks.dart';

class ToDoListBody extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return Consumer<ToDoListBodyProvider>(
        builder: (context, value, child) {
      return OrientationBuilder(builder: (context, orientation) {
      Variables().isLarge =  (orientation == Orientation.portrait);
      return (Variables().isLarge)?
      Column(
        children: [
          Categories(),
          Expanded(child: ListOfTasks()),
        ],
      )
          :
      Row(
        children: [
          Categories(),
          Expanded(child: ListOfTasks()),
        ],
      );

    });
        });
  }
}
