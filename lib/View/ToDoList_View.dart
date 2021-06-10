import 'package:flutter/material.dart';
import 'package:todolist/ModelView/category_layout.dart';
import 'dart:math' as math;

import 'package:todolist/ModelView/to_do_list.dart';



class Home extends StatefulWidget {

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
   /* SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      //Lets make the Status Bar Transparent
      statusBarColor: Colors.blue,//Theme.of(context).backgroundColor,
     systemNavigationBarColor: Colors.white,
      //systemNavigationBarDividerColor: Colors.blue,

      //Lets make the status bar icon brightness to bright
      statusBarIconBrightness: Brightness.dark,
    ));*/
    return Scaffold(

        appBar: AppBar(
          brightness: Theme.of(context).primaryColorBrightness,

          backgroundColor: Theme.of(context).backgroundColor,
          leading: Builder(builder: (BuildContext context) {
            return IconButton(
                icon: Icon(Icons.menu,color:Color(0xFF8F8FA8)),
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                });
          }),
        elevation: 0,
          actions: [
            IconButton(
              icon: Icon(
                Icons.search,
                color: Color(0xFF8F8FA8),
              ),
              onPressed: (){},
            ),
            Transform.rotate(
              angle: 20 * math.pi / 180,
              child: IconButton(
                icon: Icon(
                  Icons.notifications_none_outlined,
                  color: Color(0xFF8F8FA8),
                ),
                onPressed: (){},
              ),
            ),
          ],
        ),
          body: ToDoList(),

          drawer: ClipRRect(
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(10), bottomRight: Radius.circular(10)),

            child: Drawer(
              elevation: 2,
              child: Container(
                decoration: BoxDecoration(
                   // borderRadius: BorderRadius.all(Radius.circular(10)),
                  color: Theme.of(context).backgroundColor
                ),
                ),
                ),
          ),

    );
  }
}
