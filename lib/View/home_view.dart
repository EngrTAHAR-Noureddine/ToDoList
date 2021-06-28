import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:provider/provider.dart';
import 'package:todolist/ModelView/add_new_task.dart';
import 'dart:math' as math;

import 'package:todolist/ModelView/body_model.dart';
import 'package:todolist/Models/provider_home_class.dart';
import 'package:todolist/View/switch_view.dart';



class Home extends StatefulWidget {

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final _advancedDrawerController = AdvancedDrawerController();
  void _handleMenuButtonPressed() {
    _advancedDrawerController.showDrawer();
  }


  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarIconBrightness: Theme.of(context).brightness,
    ));
      return  AdvancedDrawer(
      backdropColor: Theme.of(context).primaryColor,
      controller: _advancedDrawerController,
      animationCurve: Curves.easeInOut,
      animationDuration: const Duration(milliseconds: 300),
      animateChildDecoration: true,
      childDecoration: const BoxDecoration(

        borderRadius: const BorderRadius.all(Radius.circular(16)),
      ),
      drawer: OrientationBuilder(builder: (context, orientation) {
        return SafeArea(
        child: Container(

          alignment: Alignment.center,
          padding: EdgeInsets.all(20),
          child: ListTileTheme(
            textColor: Theme.of(context).splashColor,
            iconColor: Theme.of(context).splashColor,
            child: Column(

              children: [
                (orientation == Orientation.portrait)?Container(
                    width: 128.0,
                    height: 128.0,



                ):Container(),
                ListTile(

                  onTap: () {

                    setState(() {
                      ProviderHome().index=0;
                    });
                  },
                  leading: Icon(Icons.task_alt_rounded),
                  title: Text('Tasks'),
                ),
                ListTile(
                  onTap: () {

                    setState(() {
                      ProviderHome().index=1;
                    });
                    },
                  leading: Icon(Icons.delete),
                  title: Text('Drafts'),
                ),
                ListTile(
                  onTap: () {
                    setState(() {
                      ProviderHome().index=2;
                    });
                    },
                  leading: Image.asset('assets/images/goal.png',color: Theme.of(context).splashColor,),
                  title: Text('Goals'),
                ),
                ListTile(
                  onTap: () {},
                  leading: Icon(Icons.settings),
                  title: Text('Settings'),
                ),
                Spacer(),
                MaterialButton(
                  onPressed: (){},
                  child: DefaultTextStyle(
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.white54,
                    ),
                    child: Container(
                      margin: const EdgeInsets.symmetric(
                        vertical: 16.0,
                      ),
                      child: Text('About The App'),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
      }),
      child: Scaffold(

          appBar: AppBar(
            brightness: Theme.of(context).primaryColorBrightness,

            backgroundColor: Theme.of(context).backgroundColor,
            leading: IconButton(
            onPressed: _handleMenuButtonPressed,
            icon: ValueListenableBuilder<AdvancedDrawerValue>(
              valueListenable: _advancedDrawerController,
              builder: (_, value, __) {
                return AnimatedSwitcher(
                  duration: Duration(milliseconds: 250),
                  child: Icon(
                    value.visible ? Icons.clear : Icons.menu,
                    key: ValueKey<bool>(value.visible),
                  ),
                );
              },
            ),
          ), /*Builder(builder: (BuildContext context) {
              return IconButton(
                  icon: Icon(Icons.menu,color:Color(0xFF8F8FA8)),
                  onPressed: () {
                    Scaffold.of(context).openDrawer();
                  });
            }),*/
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
          body:ViewSwitch(),


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


      ),
    );
  }
}



