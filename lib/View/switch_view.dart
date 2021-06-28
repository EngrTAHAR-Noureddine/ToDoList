import 'package:flutter/material.dart';
import 'package:todolist/Models/provider_home_class.dart';

class ViewSwitch extends StatefulWidget {
  const ViewSwitch({Key key}) : super(key: key);

  @override
  _ViewSwitchState createState() => _ViewSwitchState();
}

class _ViewSwitchState extends State<ViewSwitch> {
  @override
  Widget build(BuildContext context) {
    return ProviderHome().returnWidget();
  }
}
