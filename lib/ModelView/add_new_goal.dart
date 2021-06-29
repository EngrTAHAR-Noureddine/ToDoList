import 'package:flutter/material.dart';
import 'package:todolist/DataBase/database.dart';
import 'package:todolist/Models/goal_model.dart';
import 'package:todolist/Models/task_model.dart';

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
  Widget build(BuildContext context) {
    return WillPopScope (
      onWillPop: () async{

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

              Navigator.pop(context);
            },
          ),
          actions: [
            Container(

              child: MaterialButton(
                onPressed: (){
                  if (_formKey.currentState.validate()) {




                    }



                    Goal newGoal = new Goal(

                      );

                      if(newGoal.goal!=null && newGoal.goal.isNotEmpty) DBProvider.db.newGoal(newGoal);


                      _formKey.currentState.save();

                      ScaffoldMessenger.of(context)
                          .showSnackBar(SnackBar(content: Text('Processing Data')));
                      Navigator.pop(context);






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
                  /* Task Name text */
                  Container(
                    alignment: Alignment.centerLeft,
                    child:Text("Goal name :",style:TextStyle(color:Color(0xFF979DB0),fontWeight:FontWeight.bold ,fontSize:16,fontFamily: "Roboto"),),
                  ),
                  /* Task Name field form text */
                  Container(
                    // height: 70,
                    width: MediaQuery.of(context).size.width,
                    color: Theme.of(context).backgroundColor,
                    margin: EdgeInsets.only(top:5,bottom: 10),
                    padding: EdgeInsets.only(left: 10, right: 10,),
                    child:TextFormField(

                      // focusNode: currentFocus,
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
                        hintText: "Task name",
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
                  /* Category text */
                  Container(
                    child: Text("Category :",style:TextStyle(color:Color(0xFF979DB0),fontWeight:FontWeight.bold ,fontSize:16,fontFamily: "Roboto"),),
                  ),
                  /* Category PopMenuButton  */
                  Container(
                    //  height: 100,
                    width: MediaQuery.of(context).size.width,

                    margin: EdgeInsets.only(top:5,bottom: 10,left:10,right: 10),
                    padding: EdgeInsets.all(10),

                    decoration: ShapeDecoration(
                      //color: Theme.of(context).backgroundColor,
                      color: Theme.of(context).accentColor,//Color(0xFFF4F4F4),

                      shape: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),

                        borderSide: BorderSide(
                          color: Theme.of(context).floatingActionButtonTheme.backgroundColor,
                          width: 1,
                          style: BorderStyle.solid,
                        ),
                      ),
                    ),
                    child:   PopupMenuButton(
                      color: Theme.of(context).cardColor,

                      // padding: EdgeInsets.zero,
                      shape:RoundedRectangleBorder(
                          side: BorderSide(width: 1,style: BorderStyle.solid,color: Theme.of(context).floatingActionButtonTheme.backgroundColor,),
                          borderRadius: BorderRadius.circular(5)),
                      elevation: 4,

                      itemBuilder: (context) {
                        if ((Variables().getCat().isNotEmpty)) {
                          Variables().getCat().forEach((element) {
                            if(!itemCategories.contains(element)){
                              itemCategories.add(element);
                            }
                          });

                        }

                        return itemCategories
                            .map((item) => PopupMenuItem(

                            height: 40,
                            padding:EdgeInsets.all(5),
                            // enabled: false,
                            value: itemCategories.indexOf(item),
                            child: StatefulBuilder(

                                builder: (BuildContext context, StateSetter setState) {
                                  return Container(
                                      width: MediaQuery.of(context).size.width,
                                      height: 40,
                                      margin: EdgeInsets.all(0),
                                      padding: EdgeInsets.only(left:10,top: 5,bottom: 5,right: 5),
                                      alignment: Alignment.centerLeft,
                                      decoration: ShapeDecoration(
                                        color: Theme.of(context).accentColor,

                                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                                      ),
                                      child: Text(
                                        item.toString(),
                                        style: TextStyle(color: Theme.of(context).floatingActionButtonTheme.focusColor,
                                            fontSize: 12,
                                            fontFamily: "Roboto"),
                                      )

                                  );
                                }
                            )
                        )
                        ).toList();
                      },
                      onSelected: (value) async{
                        if(value==0){return await showDialogToAddCategory(context);}
                        if(value!=0){
                          setState(() {
                            _categorySelected = itemCategories[value];
                          });}
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text( _categorySelected , style: TextStyle(fontSize: 14, fontWeight: FontWeight.normal , color: Theme.of(context).floatingActionButtonTheme.backgroundColor,)),
                          Icon(Icons.keyboard_arrow_down_rounded , color:  Theme.of(context).floatingActionButtonTheme.backgroundColor,),

                        ],
                      ),
                    ),


                  ),
                  /* Status Text*/
                  Container(
                    child: Text("Status :",style:TextStyle(color:Color(0xFF979DB0),fontWeight:FontWeight.bold ,fontSize:16,fontFamily: "Roboto"),),
                    alignment: Alignment.centerLeft,
                  ),
                  /* Status PopMenu Button */
                  Container(
                    //height: 100,
                    width: MediaQuery.of(context).size.width,

                    margin: EdgeInsets.only(top:5,bottom: 10,left:10,right: 10),
                    padding: EdgeInsets.all(10),

                    decoration: ShapeDecoration(

                      color: Theme.of(context).accentColor,
                      shape: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),

                        borderSide: BorderSide(
                          color: Theme.of(context).floatingActionButtonTheme.backgroundColor,
                          width: 1,
                          style: BorderStyle.solid,
                        ),
                      ),
                    ),
                    child:   PopupMenuButton(
                      color: Theme.of(context).cardColor,

                      // padding: EdgeInsets.zero,
                      shape:RoundedRectangleBorder(
                          side: BorderSide(width: 1,style: BorderStyle.solid,color: Theme.of(context).floatingActionButtonTheme.backgroundColor,),
                          borderRadius: BorderRadius.circular(5)),
                      elevation: 4,

                      itemBuilder: (context) {
                        List<String> itemStatus = Variables().status;
                        itemStatus.removeWhere((element) => element == "Finished");
                        return itemStatus
                            .map((item) => PopupMenuItem(

                            height: 40,
                            padding:EdgeInsets.all(5),
                            // enabled: false,
                            value: itemStatus.indexOf(item),
                            child: StatefulBuilder(

                                builder: (BuildContext context, StateSetter setState) {
                                  return Container(
                                      width: MediaQuery.of(context).size.width,
                                      height: 40,
                                      margin: EdgeInsets.all(0),
                                      padding: EdgeInsets.only(left:10,top: 5,bottom: 5,right: 5),
                                      alignment: Alignment.centerLeft,
                                      decoration: ShapeDecoration(
                                        color: Theme.of(context).accentColor,

                                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                                      ),
                                      child: Text(
                                        item.toString(),
                                        style: TextStyle(color: Theme.of(context).floatingActionButtonTheme.focusColor,
                                            fontSize: 12,
                                            fontFamily: "Roboto"),
                                      )

                                  );
                                }
                            )
                        )
                        ).toList();
                      },
                      onSelected: (value) async{

                        setState(() {
                          _statusSelected = Variables().status[value];
                        });
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text( _statusSelected , style: TextStyle(fontSize: 14, fontWeight: FontWeight.normal , color: Theme.of(context).floatingActionButtonTheme.backgroundColor,)),
                          Icon(Icons.keyboard_arrow_down_rounded , color:  Theme.of(context).floatingActionButtonTheme.backgroundColor,),

                        ],
                      ),
                    ),

                  ),
                  /* Frequency Text */
                  Container(
                    child: Text("Frequency :",style:TextStyle(color:Color(0xFF979DB0),fontWeight:FontWeight.bold ,fontSize:16,fontFamily: "Roboto"),),
                    alignment: Alignment.centerLeft,
                  ),
                  /* Frequency PopMenu Button */
                  Container(
                    width: MediaQuery.of(context).size.width,

                    margin: EdgeInsets.only(top:5,bottom: 10,left:10,right: 10),
                    padding: EdgeInsets.all(10),

                    decoration: ShapeDecoration(
                      //color: Theme.of(context).backgroundColor,
                      color: Theme.of(context).accentColor,//Color(0xFFF4F4F4),

                      shape: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),

                        borderSide: BorderSide(
                          color: Theme.of(context).floatingActionButtonTheme.backgroundColor,
                          width: 1,
                          style: BorderStyle.solid,
                        ),
                      ),
                    ),
                    child:   PopupMenuButton(
                      color: Theme.of(context).cardColor,

                      // padding: EdgeInsets.zero,
                      shape:RoundedRectangleBorder(
                          side: BorderSide(width: 1,style: BorderStyle.solid,color: Theme.of(context).floatingActionButtonTheme.backgroundColor,),
                          borderRadius: BorderRadius.circular(5)),
                      elevation: 4,

                      itemBuilder: (context) {
                        List<String> itemFrequencies = Variables().frequency;
                        return itemFrequencies
                            .map((item) => PopupMenuItem(

                            height: 40,
                            padding:EdgeInsets.all(5),
                            // enabled: false,
                            value: itemFrequencies.indexOf(item),
                            child: StatefulBuilder(

                                builder: (BuildContext context, StateSetter setState) {
                                  return Container(
                                      width: MediaQuery.of(context).size.width,
                                      height: 40,
                                      margin: EdgeInsets.all(0),
                                      padding: EdgeInsets.only(left:10,top: 5,bottom: 5,right: 5),
                                      alignment: Alignment.centerLeft,
                                      decoration: ShapeDecoration(
                                        color: Theme.of(context).accentColor,

                                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                                      ),
                                      child: Text(
                                        item.toString(),
                                        style: TextStyle(color: Theme.of(context).floatingActionButtonTheme.focusColor,
                                            fontSize: 12,
                                            fontFamily: "Roboto"),
                                      )

                                  );
                                }
                            )
                        )
                        ).toList();
                      },
                      onSelected: (value) {
                        setState(() {
                          _frequencySelected = Variables().frequency[value];
                        });
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text( _frequencySelected , style: TextStyle(fontSize: 14, fontWeight: FontWeight.normal , color: Theme.of(context).floatingActionButtonTheme.backgroundColor,)),
                          Icon(Icons.keyboard_arrow_down_rounded , color:  Theme.of(context).floatingActionButtonTheme.backgroundColor,),

                        ],
                      ),
                    ),
                  ),
                  /* Goal text */
                  Container(
                    alignment: Alignment.centerLeft,
                    child:Text("Goal :",style:TextStyle(color:Color(0xFF979DB0),fontWeight:FontWeight.bold ,fontSize:16,fontFamily: "Roboto"),),
                  ),
                  /* Goal field form text */
                  Container(
                    // height: 70,
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
                  /* Date Of Task Text */
                  Container(
                    child: Text("Date Of Task :",style:TextStyle(color:Color(0xFF979DB0),fontWeight:FontWeight.bold ,fontSize:16,fontFamily: "Roboto"),),
                    alignment: Alignment.centerLeft,
                  ),
                  /* Show Date & Time pickers Widgets */
                  Container(
                    //height: 100,
                      width: MediaQuery.of(context).size.width,
                      color: Theme.of(context).backgroundColor,
                      //margin: EdgeInsets.all(2),
                      margin: EdgeInsets.only(top:5,bottom: 10),
                      padding: EdgeInsets.only(left: 10, right: 10,),
                      child:  Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            flex: 1,
                            child:MaterialButton(
                              height: 40,

                              onPressed: () => _selectDate(context),
                              colorBrightness:Theme.of(context).primaryColorBrightness,
                              //padding: EdgeInsets.only(left: 10),
                              elevation: 2,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5)
                              ),
                              color: Theme.of(context).accentColor,
                              child:
                              Text(selectedDate.day.toString()+"/"+selectedDate.month.toString()+"/"+selectedDate.year.toString() ,style: TextStyle(color: Theme.of(context).floatingActionButtonTheme.backgroundColor ,fontSize:14,fontFamily: "Roboto"),),

                            ),),
                          SizedBox(
                            width: 5,
                            height: 40,
                          ),
                          Expanded(

                            child:MaterialButton(
                              height: 40,
                              onPressed: () => _selectTime(context),
                              colorBrightness:Theme.of(context).primaryColorBrightness,
                              // padding: EdgeInsets.only(left: 10),
                              elevation: 2,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5)
                              ),
                              color: Theme.of(context).accentColor,
                              child:
                              Text(_time.toString() ,style: TextStyle(color: Theme.of(context).floatingActionButtonTheme.backgroundColor ,fontSize:14,fontFamily: "Roboto"),),

                            ),),
                        ],
                      )

                  ),
                  (_checkdate[0])?Text("date selected is false",style:TextStyle(color: Theme.of(context).errorColor,fontSize: 12)):Container(),
                  /* Date Of Reminder Text*/
                  Container(

                      child: Text("Date Of Reminder :",style:TextStyle(color:Color(0xFF979DB0),fontWeight:FontWeight.bold ,fontSize:16,fontFamily: "Roboto"),),
                      alignment: Alignment.centerLeft
                  ),
                  /* Show Date & Time Pickers Widgets */
                  Container(
                      width: MediaQuery.of(context).size.width,
                      color: Theme.of(context).backgroundColor,
                      margin: EdgeInsets.only(top:5,bottom: 10),
                      padding: EdgeInsets.only(left: 10, right: 10,),
                      child:  Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            flex: 1,
                            child:MaterialButton(
                              height: 40,
                              onPressed: () => _selectReminder(context),
                              colorBrightness:Theme.of(context).primaryColorBrightness,
                              //padding: EdgeInsets.only(left: 10),
                              elevation: 2,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5)
                              ),
                              color: Theme.of(context).accentColor,
                              child:
                              Text(selectedReminder.day.toString()+"/"+selectedReminder.month.toString()+"/"+selectedReminder.year.toString()  ,style: TextStyle(color: Theme.of(context).floatingActionButtonTheme.backgroundColor ,fontSize:14,fontFamily: "Roboto"),),

                            ),),
                          SizedBox(
                            width: 5,
                            height: 40,
                          ),
                          Expanded(

                            child:MaterialButton(
                              height: 40,
                              onPressed: () => _selectTimeReminder(context),
                              colorBrightness:Theme.of(context).primaryColorBrightness,
                              // padding: EdgeInsets.only(left: 10),
                              elevation: 2,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5)
                              ),
                              color: Theme.of(context).accentColor,
                              child:
                              Text( _timeR.toString() ,style: TextStyle(color: Theme.of(context).floatingActionButtonTheme.backgroundColor ,fontSize:14,fontFamily: "Roboto"),),

                            ),),
                        ],
                      )

                  ),
                  (_checkdate[1])?Text("date selected is before the selected date of task",style:TextStyle(color: Theme.of(context).errorColor,fontSize: 12))
                      :(_checkdate[2])?Text("Time of reminder is less then the time selected",style:TextStyle(color: Theme.of(context).errorColor,fontSize: 12)):Container(),
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
