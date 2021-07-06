import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:provider/provider.dart';
import 'package:todolist/DataBase/database.dart';
import 'package:todolist/ModelView/add_new_goal.dart';
import 'package:todolist/ModelView/add_new_task.dart';
import 'package:todolist/Models/Data/queue_model.dart';
import 'package:todolist/Models/ProvidersClass/notification_provider.dart';
import 'package:todolist/Models/ProvidersClass/provider_class.dart';
import 'dart:math' as math;

import 'package:todolist/Models/ProvidersClass/provider_home_class.dart';
import 'package:todolist/Models/Data/user_model.dart';
import 'package:todolist/View/notification_fragment.dart';
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
  TextEditingController _searchItem = new TextEditingController();
 bool _bigger = false;

  Stream<bool> setUser()async*{
   User user = await DBProvider.db.getUser(1);

   await ProviderClass().setAppMod(user);
   List<Queue> listQueue = await DBProvider.db.getAllQueue();

  if(listQueue!=null && listQueue.isNotEmpty){ NotificationProvider().setList(listQueue);  print(listQueue);}

 }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarIconBrightness: Theme.of(context).brightness,
    ));
      return Consumer<NotificationProvider>(
          builder: (context, value, child){
      return  StreamBuilder(
          stream: setUser(),
          builder: (context,snapshot){

            return AdvancedDrawer(
              backdropColor:Color(0xFF2643C4),
              controller: _advancedDrawerController,
              animationCurve: Curves.easeInOut,
              animationDuration: const Duration(milliseconds: 300),

              animateChildDecoration: true,
              childDecoration: const BoxDecoration(

                borderRadius: const BorderRadius.all(Radius.circular(10)),
              ),
              drawer: OrientationBuilder(builder: (context, orientation) {
                return SafeArea(
                  child: Container(

                    alignment: Alignment.center,
                    padding: EdgeInsets.fromLTRB(10,40,10,10),
                    child: ListTileTheme(
                      textColor: Colors.white,
                      iconColor: Colors.white,
                      child: Column(

                        children: [
                          (orientation == Orientation.portrait)?Container(
                            width: 128.0,
                            height: 128.0,



                          ):Container(),
                          ListTile(
                            contentPadding:  EdgeInsets.only(left : 20.0),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                                side: (SwitchViews().index==0)? BorderSide(width: 0,color: Colors.white,style: BorderStyle.solid):BorderSide.none

                            ),
                            onTap: () {
                              setState(() {

                                SwitchViews().index=0;
                                _advancedDrawerController.hideDrawer();
                              });



                            },
                            leading: Icon(Icons.task_alt_rounded,color:Colors.white,),
                            title: Text('Tasks'),
                          ),
                          SizedBox(height: 10,),
                          ListTile(
                            contentPadding:  EdgeInsets.only(left : 20.0),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                                side: (SwitchViews().index==1)? BorderSide(width: 0,color: Colors.white,style: BorderStyle.solid):BorderSide.none

                            ),
                            onTap: () {

                              setState(() {

                                SwitchViews().index=1;
                                _advancedDrawerController.hideDrawer();
                              });


                            },
                            leading: Icon(Icons.delete,color: Colors.white,),
                            title: Text('Drafts'),
                          ),
                          SizedBox(height: 10,),
                          ListTile(
                            contentPadding:  EdgeInsets.only(left : 20.0),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                                side: (SwitchViews().index==2)? BorderSide(width: 0,color:Colors.white,style: BorderStyle.solid):BorderSide.none

                            ),
                            onTap: () {
                              setState(() {

                                SwitchViews().index=2;
                                _advancedDrawerController.hideDrawer();
                              });


                            },
                            leading: Image.asset('assets/images/goal.png',color: Colors.white,),
                            title: Text('Goals'),
                          ),
                          SizedBox(height: 10,),
                          ListTile(
                            contentPadding:  EdgeInsets.only(left : 20.0),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                                side: (SwitchViews().index==3)? BorderSide(width: 0,color: Colors.white,style: BorderStyle.solid):BorderSide.none

                            ),
                            onTap: () {setState(() {
                              SwitchViews().index=3;
                              _advancedDrawerController.hideDrawer();
                            });},
                            leading: Icon(Icons.settings,color: Colors.white,),
                            title: Text('Settings'),
                          ),

                          (orientation == Orientation.portrait)? Spacer():Container(),
                          (orientation == Orientation.portrait)? Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              MaterialButton(

                                height: 30,
                                shape: Border(
                                  right: BorderSide(color: Colors.white,width: 0,style: BorderStyle.solid)
                                ),
                                padding: EdgeInsets.all(0),
                                onPressed: (){},
                                child: DefaultTextStyle(
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.white,
                                  ),
                                  child: Container(
                                    margin: EdgeInsets.all(0),
                                    child: Text('About The App'),
                                  ),
                                ),
                              ),
                              MaterialButton(
                                minWidth: 60,
                                height: 30,
                                padding: EdgeInsets.all(0),
                                onPressed: (){},
                                child: DefaultTextStyle(
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.white,
                                  ),
                                  child: Container(

                                    margin: EdgeInsets.all(0),
                                    child: Text('FeedBack'),
                                  ),
                                ),
                              ),
                            ],
                          ):Container(),
                        ],
                      ),
                    ),
                  ),
                );
              }),
              child: Scaffold(
                backgroundColor: Theme.of(context).backgroundColor,

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
                            color: Color(0xFF8F8FA8),
                            key: ValueKey<bool>(value.visible),
                          ),
                        );
                      },
                    ),
                  ),
                  elevation: 0,
                  actions: [

                    (SwitchViews().index!=3)?    IconButton(
                      icon: Icon(
                        Icons.search,
                        color: Color(0xFF8F8FA8),
                      ),
                      onPressed: (){
                        setState(() {
                          _bigger = !_bigger;
                        });
                      },
                    ):Container(),
                    (SwitchViews().index!=3)? AnimatedContainer(
                      width: !_bigger ? 0 : MediaQuery.of(context).size.width*0.55,
                      margin: EdgeInsets.only(right: !_bigger ?0:10),
                      color: Colors.transparent,
                      child: TextField(

                        textAlign: TextAlign.left,
                        style: TextStyle(fontSize: 14,color: Theme.of(context).floatingActionButtonTheme.backgroundColor ),
                        maxLines: 1,
                        maxLength: 100,
                        showCursor: true,
                        onTap: (){
                          setState(() {
                            SwitchViews().index=5;
                          });
                        },
                        onChanged: (value)=>SwitchViews().onSearch(value),
                        controller: _searchItem,
                        autofocus: false,


                        minLines: 1,
                        keyboardType: TextInputType.text,

                        decoration: InputDecoration(
                          enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color(0xFF8F8FA8),
                                  style: BorderStyle.solid,
                                  width: 1
                              )
                          ),
                          focusedBorder:UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors.blue,
                                  style: BorderStyle.solid,
                                  width: 2
                              )
                          ),
                          focusedErrorBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: Theme.of(context).errorColor,
                                  style: BorderStyle.solid,
                                  width: 1
                              )
                          ),
                          errorBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: Theme.of(context).errorColor,
                                  style: BorderStyle.solid,
                                  width: 1
                              )
                          ),
                          //isDense: true,
                          contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical:0),
                          alignLabelWithHint: false,
                          labelText: null,

                          counterStyle: TextStyle(
                            height: double.minPositive,
                          ),
                          counterText: "",

                          hintText: "Search...",
                          hintStyle: TextStyle(color: Color(0xFFB8B8B8)),



                        ),
                        toolbarOptions: ToolbarOptions(
                          cut: true,
                          copy: true,
                          selectAll: true,
                          paste: true,
                        ),
                      ),
                      duration: Duration(milliseconds: 200),
                    ):Container(),
                    CircleAvatar(
                      backgroundColor:Colors.transparent,
                      child: Stack(

                        children: [
                          Transform.rotate(
                            angle: 20 * math.pi / 180,
                            child: IconButton(
                                  splashColor: Colors.transparent,
                              icon: Icon(
                                Icons.notifications_none_outlined,
                                color: Color(0xFF8F8FA8),
                              ),
                              onPressed: (){
                                Navigator.push(
                                  context,
                                  MaterialPageRoute<void>(
                                    builder: (BuildContext context) => NotificationView(),
                                    fullscreenDialog: true,
                                  ),
                                );
                              },
                            ),
                          ),
                          (NotificationProvider().isUnread!=null && NotificationProvider().isUnread=="true")?Positioned(  // draw a red marble
                              top: 15,
                              left: 10,
                              child:Icon(Icons.brightness_1, size: 10.0,
                                  color: Colors.redAccent),
                          ):Container(),
                        ],
                      ),
                    ),
                  ],
                ),
                body:ViewSwitch(),


                floatingActionButton:(![1,3,5].contains(SwitchViews().index))? FloatingActionButton(
                  elevation: 0,

                  child: Icon(Icons.add ,color: Theme.of(context).splashColor,),
                  backgroundColor: Theme.of(context).primaryColor,
                  onPressed: (){

                    Navigator.push(
                      context,
                      MaterialPageRoute<void>(
                        builder: (BuildContext context) => (SwitchViews().index==2)?AddGoal():AddNewTasks(),
                        fullscreenDialog: true,
                      ),
                    );


                  },
                ):Container(),


              ),
            );
          });});


  }
}



