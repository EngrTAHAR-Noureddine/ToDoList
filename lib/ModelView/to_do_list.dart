import 'package:flutter/material.dart';

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
            return Container();
    });
  }
}
