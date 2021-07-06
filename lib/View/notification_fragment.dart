import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:todolist/DataBase/database.dart';
import 'package:todolist/Models/Data/queue_model.dart';
import 'package:todolist/Models/ProvidersClass/notification_provider.dart';
import 'package:todolist/Models/custom_list_tile.dart' as custom;

class NotificationView extends StatefulWidget {


  @override
  _NotificationViewState createState() => _NotificationViewState();
}

class _NotificationViewState extends State<NotificationView> {
  Stream<List<Queue>> getList()async*{
    yield await DBProvider.db.getAllQueue();
  }
  @override
  Widget build(BuildContext context) {
    return WillPopScope (
      onWillPop: ()async{
        await NotificationProvider().cancelNotification();
        Navigator.pop(context);
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text("Notification" ,style: TextStyle(color: Color(0xFF8F8FA8)),),
          backgroundColor: Theme.of(context).backgroundColor,
          brightness: Theme.of(context).primaryColorBrightness,

          leading: IconButton(
            onPressed: ()async{
              await NotificationProvider().cancelNotification();
              Navigator.pop(context);
            },
            icon:  Icon(
              Icons.arrow_back,
              color: Color(0xFF8F8FA8),

            ),
          ),

        ),
        body: Consumer<NotificationProvider>(
                      builder: (context, value, child){
                  print(NotificationProvider().listQueues);
                  return Container(
                        padding: EdgeInsets.only(left: 10,right: 10,bottom: 10,top: 20),
                        color: Colors.white,
                        child: StreamBuilder(
                          stream: getList(),
                          builder: (context,snapshot){
                            if(snapshot.hasData){
                              if(snapshot.data!=null){
                                List<Queue> listnotif= snapshot.data;
                                return ListView.builder(
                                  itemCount: listnotif.length,
                                  itemBuilder: (context,index){
                                    Queue task = listnotif[index];
                                    return Container(
                                      margin: EdgeInsets.only(bottom: 10),
                                      child: custom.ExpansionTile(
                                        backgroundColor: Theme.of(context).backgroundColor,
                                        headerBackgroundColor: Theme.of(context).primaryColorLight,


                                        title: Text(
                                          task.task,
                                          style: TextStyle(fontSize: 18.0,color: Theme.of(context).floatingActionButtonTheme.focusColor,),
                                        ),
                                        children: [
                                          Container(
                                            padding: EdgeInsets.all(10),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.end,

                                              children: [
                                                MaterialButton(
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius: BorderRadius.circular(10),
                                                      side: BorderSide.none

                                                  ),
                                                  color: Color(0xFF00B98C),
                                                  textColor: Colors.white,
                                                  onPressed: ()async{return await NotificationProvider().clickFinished(context,task.idTask,task.id);},
                                                  child: Text("Finished"),

                                                ),
                                                SizedBox(width: 20,),
                                                MaterialButton(
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius: BorderRadius.circular(10),
                                                      side: BorderSide.none

                                                  ),
                                                  color: Color(0xFF0269CA),
                                                  textColor: Colors.white,
                                                  onPressed:  ()async{return await NotificationProvider().clickInProgress(context,task.idTask,task.id);},
                                                  child: Text("In progress"),

                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  },


                                );
                              }else {
                                return Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(

                                      child: Text("is Empty",  style: TextStyle(fontWeight: FontWeight.normal , color: Color(0xFF979DB0)),),
                                      alignment: Alignment.center,



                                    ),
                                  ],
                                );
                              }
                            }else{
                              return Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(

                                    child: Text("is Empty",  style: TextStyle(fontWeight: FontWeight.normal , color: Color(0xFF979DB0)),),
                                    alignment: Alignment.center,



                                  ),
                                ],
                              );
                            }

                          },
                        ),
                      );}),
      ),
    );
  }
}

/*
class NotificationView extends StatelessWidget {
  

  @override
  Widget build(BuildContext context) {
    return Consumer<NotificationProvider>(
        builder: (context, value, child){
          print(NotificationProvider().listQueues);
          return WillPopScope (
              onWillPop: ()async{
                await NotificationProvider().cancelNotification();
                Navigator.pop(context);
                return false;
              },
            child:  Scaffold(
                    appBar: AppBar(
                      title: Text("Notification" ,style: TextStyle(color: Color(0xFF8F8FA8)),),
                      backgroundColor: Theme.of(context).backgroundColor,
                      brightness: Theme.of(context).primaryColorBrightness,

                      leading: IconButton(
                        onPressed: ()async{
                         await NotificationProvider().cancelNotification();
                          Navigator.pop(context);
                        },
                        icon:  Icon(
                         Icons.arrow_back,
                          color: Color(0xFF8F8FA8),

                        ),
                      ),

                    ),
                    body: Container(
                      padding: EdgeInsets.only(left: 10,right: 10,bottom: 10,top: 20),
                      color: Colors.white,
                      child:(NotificationProvider().listQueues!=null&&NotificationProvider().listQueues.isNotEmpty)?
                      ListView.builder(
                        itemCount: NotificationProvider().listQueues.length,
                        itemBuilder: (context,index){
                          Queue task = NotificationProvider().listQueues[index];
                          return Container(
                            margin: EdgeInsets.only(bottom: 10),
                            child: custom.ExpansionTile(
                              backgroundColor: Theme.of(context).backgroundColor,
                              headerBackgroundColor: Theme.of(context).primaryColorLight,


                              title: Text(
                                task.task,
                                style: TextStyle(fontSize: 18.0,color: Theme.of(context).floatingActionButtonTheme.focusColor,),
                              ),
                              children: [
                                Container(
                                  padding: EdgeInsets.all(10),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,

                                    children: [
                                      MaterialButton(
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(10),
                                            side: BorderSide.none

                                        ),
                                        color: Color(0xFF00B98C),
                                        textColor: Colors.white,
                                        onPressed: ()async{return await NotificationProvider().clickFinished(context,task.idTask,task.id);},
                                        child: Text("Finished"),

                                      ),
                                      SizedBox(width: 20,),
                                      MaterialButton(
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(10),
                                            side: BorderSide.none

                                        ),
                                        color: Color(0xFF0269CA),
                                        textColor: Colors.white,
                                        onPressed:  ()async{return await NotificationProvider().clickInProgress(context,task.idTask,task.id);},
                                        child: Text("In progress"),

                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          );
                        },


                      ):Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(

                            child: Text("is Empty",  style: TextStyle(fontWeight: FontWeight.normal , color: Color(0xFF979DB0)),),
                            alignment: Alignment.center,



                          ),
                        ],
                      ),
                    ),
                  ),
          );
        });
  }
}
*/