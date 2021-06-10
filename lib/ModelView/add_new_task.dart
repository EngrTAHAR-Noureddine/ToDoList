import 'package:flutter/material.dart';
class AddNewTasks extends StatefulWidget {

  @override
  _AddNewTasksState createState() => _AddNewTasksState();
}

class _AddNewTasksState extends State<AddNewTasks> {
  @override
  Widget build(BuildContext context) {
    return Container(
        width: 150.0,
        height: 150.0,
        child: new Stack(

        children: <Widget>[

        new Container(
        alignment: Alignment.center,
        color: Colors.redAccent,
        child: Text('Hello'),
    )]
    ));
  }
}
