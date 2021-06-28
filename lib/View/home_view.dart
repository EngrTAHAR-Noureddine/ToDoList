import 'package:flutter/material.dart';
import 'package:todolist/ModelView/add_new_task.dart';
import 'dart:math' as math;

import 'package:todolist/ModelView/body_model.dart';



class Home extends StatefulWidget {

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
 // final GlobalKey<FormState> _formKey = GlobalKey<FormState>();




  @override
  Widget build(BuildContext context) {

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
        body: ToDoListBody(),

          floatingActionButton: FloatingActionButton(
            elevation: 0,
            child: Icon(Icons.add ,color: Theme.of(context).splashColor,),
            backgroundColor: Theme.of(context).primaryColor,
            onPressed: () async {

              Navigator.push(
                context,
                MaterialPageRoute<void>(
                  builder: (BuildContext context) => AddNewTasks(),
                  fullscreenDialog: true,
                ),
              );


            },
          ),
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



