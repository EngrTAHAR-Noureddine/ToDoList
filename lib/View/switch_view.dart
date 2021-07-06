import 'package:flutter/material.dart';

import 'package:todolist/Models/ProvidersClass/provider_home_class.dart';

class ViewSwitch extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return SwitchViews().returnWidget();
  }
}


/*
class ViewSwitch extends StatefulWidget {


  @override
  _ViewSwitchState createState() => _ViewSwitchState();
}

class _ViewSwitchState extends State<ViewSwitch> {

  @override
  Widget build(BuildContext context) {
    return  SwitchViews().returnWidget();

  }
}*/
