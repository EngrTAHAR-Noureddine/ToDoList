import 'package:flutter/material.dart';
import 'package:todolist/DataBase/database.dart';
import 'package:todolist/Models/goal_model.dart';

class AddGoal extends StatefulWidget {

  int id;
  String goal;
  String note;
  String reason;
  AddGoal({this.id,this.reason,this.goal,this.note});

  @override
  _AddGoalState createState() => _AddGoalState();
}

class _AddGoalState extends State<AddGoal> {
  final _formKey = GlobalKey<FormState>();
  
  FocusScopeNode currentFocus =new FocusScopeNode();
  TextEditingController _goalName = new TextEditingController();
  TextEditingController _addNoteText =new TextEditingController();
  TextEditingController _addReason =new TextEditingController();

  bool enabled = true;


  @override
  void initState() {

    if((widget.goal!=null)&&(widget.goal.isNotEmpty))_goalName.text = widget.goal;


    if((widget.note!=null)&&(widget.note.isNotEmpty)) _addNoteText.text = widget.note;


    if((widget.reason!=null)&&(widget.reason.isNotEmpty))_addReason.text = widget.reason;
  }
 



  @override
  Widget build(BuildContext context) {
    initState();
    return WillPopScope (
      onWillPop: () async{
        if(widget.goal!=null && widget.goal.isNotEmpty) {
          Goal newGoal = new Goal(
              goal: widget.goal,
              note: widget.note,
              reason: widget.reason
          );

          if (newGoal.goal != null && newGoal.goal.isNotEmpty) DBProvider
              .db.newGoal(newGoal);
        }
        Navigator.pop(context);
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          brightness: Theme.of(context).primaryColorBrightness,
          backgroundColor: Theme.of(context).backgroundColor,
          elevation: 0,
          iconTheme: IconThemeData(color: Color(0xFF8F8FA8) ),
          leading:  CloseButton(
            color: Color(0xFF8F8FA8),
            onPressed: (){
              if(widget.goal!=null && widget.goal.isNotEmpty) {
                Goal newGoal = new Goal(
                    goal: widget.goal,
                    note: widget.note,
                    reason: widget.reason
                );

                if (newGoal.goal != null && newGoal.goal.isNotEmpty) DBProvider
                    .db.newGoal(newGoal);
              }
              Navigator.pop(context);
            },
          ),
          actions: [
            Container(

              child: MaterialButton(
                onPressed: (){
                  if (_formKey.currentState.validate()) {

                    Goal newGoal = new Goal(
                        goal: _goalName.text,
                        note: _addNoteText.text,
                        reason: _addReason.text
                                   );

                    if(newGoal.goal!=null && newGoal.goal.isNotEmpty) DBProvider.db.newGoal(newGoal);


                    _formKey.currentState.save();

                    ScaffoldMessenger.of(context)
                        .showSnackBar(SnackBar(content: Text('new Goal added')));
                    Navigator.pop(context);


                    }
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
          title: Text('Add New Goal',style: TextStyle(color:Color(0xFF979DB0)),),
        ),
        body: GestureDetector(

          onTap: () => FocusManager.instance.primaryFocus?.unfocus(),

          child: Form(
            key: _formKey,
            child: Container(
              color: Theme.of(context).backgroundColor,
              padding: EdgeInsets.all(10),
              child: ListView(

                scrollDirection: Axis.vertical,
                children: [
                  /* Goal Name text */
                  Container(
                    alignment: Alignment.centerLeft,
                    child:Text("Goal name :",style:TextStyle(color:Color(0xFF979DB0),fontWeight:FontWeight.bold ,fontSize:16,fontFamily: "Roboto"),),
                  ),
                  /* Goal Name field form text */
                  Container(

                    width: MediaQuery.of(context).size.width,
                    color: Theme.of(context).backgroundColor,
                    margin: EdgeInsets.only(top:5,bottom: 10),
                    padding: EdgeInsets.only(left: 10, right: 10,),
                    child:TextFormField(


                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter some text';
                        }
                        return null;
                      },
                      textAlign: TextAlign.left,
                      style: TextStyle(fontSize: 14,color: Theme.of(context).floatingActionButtonTheme.backgroundColor ),
                      maxLines: 1,
                      maxLength: 100,
                      showCursor: true,

                      controller: _goalName,
                      autofocus: false,


                      minLines: 1,
                      keyboardType: TextInputType.text,

                      decoration: InputDecoration(
                        isDense: true,
                        contentPadding: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                        alignLabelWithHint: false,
                        prefixIcon: Icon(Icons.task,color: Theme.of(context).floatingActionButtonTheme.backgroundColor),
                        labelText: null,

                        counterStyle: TextStyle(
                          height: double.minPositive,
                        ),
                        counterText: "",
                        focusedBorder:OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),

                          borderSide: BorderSide(
                            color: Theme.of(context).floatingActionButtonTheme.backgroundColor,
                            width: 1,
                            style: BorderStyle.solid,
                          ),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),

                          borderSide: BorderSide(
                            color: Theme.of(context).errorColor,
                            width: 1,
                            style: BorderStyle.solid,
                          ),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),

                          borderSide: BorderSide(
                            color: Theme.of(context).errorColor,
                            width: 1,
                            style: BorderStyle.solid,
                          ),
                        ),
                        hintText: "Goal name",
                        hintStyle: TextStyle(color: Color(0xFFB8B8B8)),

                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),

                          borderSide: BorderSide(
                            color: Theme.of(context).floatingActionButtonTheme.backgroundColor,
                            width: 1,
                            style: BorderStyle.solid,
                          ),
                        ),

                      ),
                      toolbarOptions: ToolbarOptions(
                        cut: true,
                        copy: true,
                        selectAll: true,
                        paste: true,
                      ),
                    ),
                  ),

                  /* Reason text */
                  Container(
                    alignment: Alignment.centerLeft,
                    child:Text("Reason :",style:TextStyle(color:Color(0xFF979DB0),fontWeight:FontWeight.bold ,fontSize:16,fontFamily: "Roboto"),),
                  ),
                  /* Reason field form text */
                  Container(

                    width: MediaQuery.of(context).size.width,
                    color: Theme.of(context).backgroundColor,
                    margin: EdgeInsets.only(top:5,bottom: 10),
                    padding: EdgeInsets.only(left: 10, right: 10,),
                    child:TextFormField(

                      textAlign: TextAlign.left,
                      style: TextStyle(fontSize: 14,color: Theme.of(context).floatingActionButtonTheme.backgroundColor ),
                      maxLines: 1,
                      maxLength: 100,
                      showCursor: true,

                      controller: _addReason,
                      autofocus: false,


                      minLines: 1,
                      keyboardType: TextInputType.text,

                      decoration: InputDecoration(
                        isDense: true,
                        contentPadding: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                        alignLabelWithHint: false,
                        prefixIcon: Icon(Icons.adjust,color: Theme.of(context).floatingActionButtonTheme.backgroundColor),
                        labelText: null,

                        counterStyle: TextStyle(
                          height: double.minPositive,
                        ),
                        counterText: "",
                        focusedBorder:OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),

                          borderSide: BorderSide(
                            color: Theme.of(context).floatingActionButtonTheme.backgroundColor,
                            width: 1,
                            style: BorderStyle.solid,
                          ),
                        ),
                        hintText: "for reason..!",
                        hintStyle: TextStyle(color: Color(0xFFB8B8B8)),

                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),

                          borderSide: BorderSide(
                            color: Theme.of(context).floatingActionButtonTheme.backgroundColor,
                            width: 1,
                            style: BorderStyle.solid,
                          ),
                        ),

                      ),
                      toolbarOptions: ToolbarOptions(
                        cut: true,
                        copy: true,
                        selectAll: true,
                        paste: true,
                      ),
                    ),
                  ),
                  /* Note  Text */
                  Container(

                      child: Text("Note :",style:TextStyle(color:Color(0xFF979DB0),fontWeight:FontWeight.bold ,fontSize:16,fontFamily: "Roboto"),),
                      alignment: Alignment.centerLeft
                  ),
                  /* Note Text Form Field */
                  Container(
                    width: MediaQuery.of(context).size.width,
                    color: Theme.of(context).backgroundColor,
                    //margin: EdgeInsets.all(2),
                    margin: EdgeInsets.only(top:5,bottom: 10),
                    padding: EdgeInsets.only(left: 10, right: 10,),
                    child: TextField(
                      textAlign: TextAlign.left,
                      style: TextStyle(fontSize: 14,color: Theme.of(context).floatingActionButtonTheme.backgroundColor ),
                      maxLines: 5,
                      maxLength: 100,
                      showCursor: true,

                      controller: _addNoteText,
                      autofocus: false,
                      minLines: 5,
                      keyboardType: TextInputType.text,

                      decoration: InputDecoration(

                        labelText: null,


                        counterStyle: TextStyle(
                          height: double.minPositive,
                        ),
                        counterText: "",
                        focusedBorder:OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),

                          borderSide: BorderSide(
                            color: Theme.of(context).floatingActionButtonTheme.backgroundColor,
                            width: 1,
                            style: BorderStyle.solid,
                          ),
                        ),
                        hintText: "Note...",
                        hintStyle: TextStyle(color: Color(0xFFB8B8B8)),

                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),

                          borderSide: BorderSide(
                            color: Theme.of(context).floatingActionButtonTheme.backgroundColor,
                            width: 1,
                            style: BorderStyle.solid,
                          ),
                        ),

                      ),
                      toolbarOptions: ToolbarOptions(
                        cut: true,
                        copy: true,
                        selectAll: true,
                        paste: true,
                      ),
                    ),
                  ),


                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
