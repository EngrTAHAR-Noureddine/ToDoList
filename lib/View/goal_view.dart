import 'package:flutter/material.dart';
import 'package:todolist/ModelView/goal_model.dart';

class GoalView extends StatefulWidget {
  const GoalView({Key key}) : super(key: key);

  @override
  _GoalViewState createState() => _GoalViewState();
}

class _GoalViewState extends State<GoalView> {
  @override
  Widget build(BuildContext context) {
    return GoalModel();
  }
}
