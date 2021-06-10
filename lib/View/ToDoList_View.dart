import 'package:flutter/material.dart';
import 'package:todolist/ModelView/category_layout.dart';
import 'package:todolist/ModelView/add_new_task.dart';
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
          floatingActionButton: FloatingActionButton(
            elevation: 0,
            child: Icon(Icons.add ,color: Theme.of(context).splashColor,),
            backgroundColor: Theme.of(context).primaryColor,
            onPressed: (){
              Navigator.push(
                context,
                MaterialPageRoute<void>(
                  builder: (BuildContext context) => FullScreenDialog(),
                  fullscreenDialog: true,
                ),
              );
             /*return  Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AddNewTasks(),
                ),
              );*/

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

class FullScreenDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        brightness: Theme.of(context).primaryColorBrightness,
        backgroundColor: Theme.of(context).backgroundColor,
        elevation: 0,
        iconTheme: IconThemeData(color: Color(0xFF8F8FA8) ),
        actions: [
          Container(
            margin: EdgeInsets.only(right: 20),
            child: Align(
                alignment: Alignment.center,
                child: Text("Save",
                              style: TextStyle(
                                        color:Color(0xFF8F8FA8) ,
                                        fontSize:20,
                                        fontFamily: "Roboto"),)
            ),
          ),

        ],
        title: Text('Add New Task',style: TextStyle(color:Color(0xFF979DB0)),),
      ),
      body:Container(
        color: Theme.of(context).backgroundColor,
        
      ),
    );
  }
}

