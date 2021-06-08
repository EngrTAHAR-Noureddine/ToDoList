import 'package:flutter/material.dart';

class Home extends StatefulWidget {

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("to do list "),
        ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: Theme.of(context).splashColor,
        child: Card(
          child: Icon(Icons.ac_unit_outlined,color: Theme.of(context).primaryColorLight,),
          color: Theme.of(context).splashColor,
          elevation: 4,
          margin: EdgeInsets.all(50),
        ),
      ),

    );
  }
}
