import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todolist/Models/Data/queue_model.dart';
import 'package:todolist/Models/ProvidersClass/notification_provider.dart';
import 'package:todolist/Models/custom_list_tile.dart' as custom;

class NotificationView extends StatelessWidget {
  

  @override
  Widget build(BuildContext context) {
    return Consumer<NotificationProvider>(
        builder: (context, value, child){

          return WillPopScope (
              onWillPop: ()async{
                NotificationProvider().isUnread=false;
                Navigator.pop(context);
                return false;
              },
            child:  Scaffold(
                    appBar: AppBar(
                      title: Text("Notification" ,style: TextStyle(color: Color(0xFF8F8FA8)),),
                      backgroundColor: Theme.of(context).backgroundColor,
                      brightness: Theme.of(context).primaryColorBrightness,

                      leading: IconButton(
                        onPressed: (){
                          NotificationProvider().isUnread=false;
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
                      ListView(
                        children: List.generate(NotificationProvider().listQueues.length, (index){
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
                                        onPressed: ()=>NotificationProvider().clickFinished(context,task.idTask),
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
                                        onPressed: ()=>NotificationProvider().clickInProgress(context,task.idTask),
                                        child: Text("In progress"),

                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          );
                          /* ClipRRect(
                            borderRadius: BorderRadius.circular(10),

                            child: ListTile(
                              tileColor: Colors.yellow,
                                contentPadding: EdgeInsets.all(0),
                                title: Container(
                                  padding: EdgeInsets.all(10),
                            height :50,child:Text(task.task), color:Colors.blue),
                                subtitle: Container(
                            color: Colors.grey,
                            padding: EdgeInsets.only(left: 10,right: 10),
                            child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                            MaterialButton(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  side: BorderSide.none

                              ),
                              color: Colors.greenAccent,
                              textColor: Colors.white,
                                onPressed: (){
                                print("click indice :"+index.toString());
                                },
                              child: Text("OK"),

                                ),
                            MaterialButton(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  side: BorderSide.none

                              ),
                              color: Colors.redAccent,
                              textColor: Colors.white,
                              onPressed: (){
                                print("click indice :"+index.toString());
                              },
                              child: Text("OK"),

                            ),
                                  ],
                                )),
                              ),
                          ); */
                        }),
                      ):Container(),
                    ),
                  ),
          );
        });
  }
}
