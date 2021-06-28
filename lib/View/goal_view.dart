import 'package:flutter/material.dart';

class GoalView extends StatefulWidget {
  const GoalView({Key key}) : super(key: key);

  @override
  _GoalViewState createState() => _GoalViewState();
}

class _GoalViewState extends State<GoalView> {
  @override
  Widget build(BuildContext context) {
    return Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        color :Colors.green
    );
  }
}
