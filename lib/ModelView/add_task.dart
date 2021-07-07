import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todolist/Models/Data/task_model.dart';
import 'package:todolist/Models/ProvidersClass/new_task_provider.dart';

class AddNewTask extends StatelessWidget {

  Task editTask;
 
  AddNewTask({ this.editTask });

  begin(){
    NewTaskProvider().setTask(this.editTask);
  }

  @override
  Widget build(BuildContext context) {
    begin();
    return Consumer<NewTaskProvider>(
        builder: (context, value, child) {
                return WillPopScope (
                    onWillPop: () async{
                      await NewTaskProvider().declineAdding(context);
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
                          onPressed: ()=>NewTaskProvider().declineAdding(context),
                        ),
                        actions: [
                          Container(

                            child: MaterialButton(
                              onPressed: ()=>NewTaskProvider().saveTask(context),

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

                        body:  GestureDetector(

                          onTap: () => FocusManager.instance.primaryFocus?.unfocus(),

                          child:Form(
                                key: NewTaskProvider().formKey,
                                child:Container(
                                      color: Theme.of(context).backgroundColor,
                                      padding: EdgeInsets.all(10),
                                      child: ListView(
                                            scrollDirection: Axis.vertical,
                                            children: [
                                                   /* Task Name text */
                                                  NewTaskProvider().titleText("Task name :"),
                                                   /* Task Name field form text */
                                                  NewTaskProvider().inputTaskName(context),
                                                   /* Category text */
                                                  NewTaskProvider().titleText("Category :"),
                                                  /* Category PopMenuButton  */
                                                  NewTaskProvider().categoryChoice(context),
                                                   /* Frequency Text */
                                                  NewTaskProvider().titleText("Frequency :"),
                                                   /* Frequency PopMenu Button */
                                                  NewTaskProvider().frequencyPopMenu(context),
                                                    /* Goal text */
                                                  NewTaskProvider().titleText("Goal :"),
                                                   /* Goal field form text */
                                                  NewTaskProvider().goalField(context),
                                                   /* Date Of Task Text */
                                                  NewTaskProvider().titleText("Date Of Task :"),
                                                   /* Show Date & Time pickers Widgets */
                                                  NewTaskProvider().showDateTimeSelected(context),
                                                  (NewTaskProvider().checkDate[0])?Text("date selected is false",style:TextStyle(color: Theme.of(context).errorColor,fontSize: 12)):Container(),
                                                  /* Date Of Reminder Text*/
                                                  NewTaskProvider().titleText("Date Of Reminder :"),
                                                  /* Show Date & Time Pickers Widgets */
                                                  NewTaskProvider().showDateTimeReminder(context),
                                                  (NewTaskProvider().checkDate[1])?Text("date selected is before the selected date of task",style:TextStyle(color: Theme.of(context).errorColor,fontSize: 12))
                                                      :(NewTaskProvider().checkDate[2])?Text("Time of reminder is less then the time selected",style:TextStyle(color: Theme.of(context).errorColor,fontSize: 12)):Container(),
                                                   /* Note  Text */
                                                   NewTaskProvider().titleText("Note :"),
                                                   /* Note Text Form Field */
                                                    NewTaskProvider().noteField(context),

                                                      ],
                                       ),
                          ),
                        ),
                    ),
          ),
                );
        }
        );
  }
}
