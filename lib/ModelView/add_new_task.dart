import 'package:flutter/material.dart';
class AddNewTasks extends StatefulWidget {

  @override
  _AddNewTasksState createState() => _AddNewTasksState();
}

class _AddNewTasksState extends State<AddNewTasks> {
  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        margin: EdgeInsets.all(0),
        padding: EdgeInsets.all(10),

        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(20)),

          color: Theme.of(context).backgroundColor,
        ),


    );
  }
}
