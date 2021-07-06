import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todolist/Models/Data/task_model.dart';
import 'package:todolist/Models/ProvidersClass/new_task_provider.dart';

class AddNewTask extends StatelessWidget {

  Task editeTask;

  AddNewTask({ this.editeTask });

  begin(){
    NewTaskProvider().setTask(this.editeTask);
  }

  @override
  Widget build(BuildContext context) {
    begin();
    return Consumer<NewTaskProvider>(
        builder: (context, value, child) {
                return WillPopScope (
                    onWillPop: () async{
                      return false;
                    },
                    child:Scaffold(
                      appBar: AppBar(
                        brightness: Theme.of(context).primaryColorBrightness,
                        backgroundColor: Theme.of(context).backgroundColor,
                        elevation: 0,
                        iconTheme: IconThemeData(color: Color(0xFF8F8FA8) ),
                        leading:  CloseButton(
                          color: Color(0xFF8F8FA8),
                          onPressed: ()async{
                            Navigator.pop(context);
                          },
                        ),
                        actions: [
                          Container(

                            child: MaterialButton(
                              onPressed: ()async{

                              },
                              
                              color: Colors.transparent,
                              splashColor: Colors.grey.withOpacity(0.5),
                              highlightElevation: 0,
                              focusElevation: 0,
                              hoverElevation: 0,
                              hoverColor: Colors.transparent,
                              focusColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              elevation: 0,

                              child: Align(
                                  alignment: Alignment.centerRight,
                                  child: Text("Save",
                                    style: TextStyle(
                                        color:Color(0xFF8F8FA8) ,
                                        fontSize:20,
                                        fontFamily: "Roboto"),)
                              ),
                            ),
                          ),

                        ],
                        title: Text('Add New Task',style: TextStyle(color:Color(0xFF979DB0)),),
                      ),
                    ),);
        });
  }
}
