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
          leading: Builder(builder: (BuildContext context) {
            return IconButton(
                icon: Icon(Icons.ac_unit),
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                });
          })),
          body: Container(color: Colors.red,),
          drawer: ClipRRect(
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(10), bottomRight: Radius.circular(10)),

            child: Drawer(
              elevation: 2,
              child: Container(
                decoration: BoxDecoration(
                   // borderRadius: BorderRadius.all(Radius.circular(10)),
                  color: Colors.white
                ),
                ),
                ),
          ),

    );
  }
}
