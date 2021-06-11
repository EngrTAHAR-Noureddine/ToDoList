import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:todolist/Models/data_variable.dart';

class AddNewTasks extends StatefulWidget {

  @override
  _AddNewTasksState createState() => _AddNewTasksState();
}

class _AddNewTasksState extends State<AddNewTasks> {
  final _formKey = GlobalKey<FormState>();
  String _categorySelected = "Category";
  String _statusSelected = "Status";
  String _frequencySelected = "Once";
  bool _addCategory = false;
  bool _addDaysfrequency = false;
  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay(hour: 00, minute: 00);
  String  _time= DateTime.now().hour.toString()+":"+DateTime.now().minute.toString();

  DateTime selectedReminder = DateTime.now();
  TimeOfDay selectedTimeReminder = TimeOfDay(hour: 00, minute: 00);
  String  _timeR= DateTime.now().hour.toString()+":"+DateTime.now().minute.toString();


  Future<Null> _selectTimeReminder(BuildContext context) async {
    String _hour, _minute;
    final TimeOfDay picked = await showTimePicker(
      context: context,
      initialTime: selectedTimeReminder,
    );
    if (picked != null)
      setState(() {
        selectedTimeReminder = picked;
        _hour = selectedTimeReminder.hour.toString();
        _minute = selectedTimeReminder.minute.toString();
        _timeR = _hour + ' : ' + _minute;

      });
  }



  _selectReminder(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: selectedReminder, // Refer step 1
      firstDate: DateTime(2000),
      lastDate: DateTime(2025),
    );
    if (picked != null && picked != selectedReminder)
      setState(() {
        selectedReminder = picked;
      });
  }

  Future<Null> _selectTime(BuildContext context) async {
    String _hour, _minute;
    final TimeOfDay picked = await showTimePicker(
      context: context,
      initialTime: selectedTime,
    );
    if (picked != null)
      setState(() {
        selectedTime = picked;
        _hour = selectedTime.hour.toString();
        _minute = selectedTime.minute.toString();
        _time = _hour + ' : ' + _minute;

  });
        }



  _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: selectedDate, // Refer step 1
      firstDate: DateTime(2000),
      lastDate: DateTime(2025),
    );
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
      });
  }

  @override
  Widget build(BuildContext context) {

    return WillPopScope (
      onWillPop: () async{
        print("close add ok -------------");
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
            color: Colors.blue,
            onPressed: (){print("close widget ;) coco"); Navigator.pop(context);},
          ),
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
        body:Form(
          key: _formKey,
          child: Container(
            color: Theme.of(context).backgroundColor,
            child: ListView(
              scrollDirection: Axis.vertical,
              children: [
                Container(
                  height: 100,
                  width: MediaQuery.of(context).size.width,
                  color: Colors.white,
                  margin: EdgeInsets.all(2),
                  padding: EdgeInsets.only(left: 10),
                  child:Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Align(

                          child: Text("Task name :",style:TextStyle(color:Color(0xFF979DB0),fontWeight:FontWeight.bold ,fontSize:20,fontFamily: "Roboto"),),
                          alignment: Alignment.centerLeft
                      ),
                      TextFormField(

                        textAlign: TextAlign.left,
                        style: TextStyle(fontSize: 18,color: Theme.of(context).floatingActionButtonTheme.backgroundColor ),
                        maxLines: 1,
                        maxLength: 100,
                        showCursor: true,

                        controller: TextEditingController(),
                        autofocus: false,
                        minLines: 1,
                        keyboardType: TextInputType.text,

                        decoration: InputDecoration(

                          alignLabelWithHint: true,
                            prefixIcon: Icon(Icons.task),
                            labelText: "Task name",
                          labelStyle: TextStyle(fontSize: 16,color: Theme.of(context).floatingActionButtonTheme.backgroundColor ),

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
                    ],
                  ),
                ),
                Container(
                  height: 100,
                  width: MediaQuery.of(context).size.width,
                  color: Theme.of(context).backgroundColor,
                  margin: EdgeInsets.all(2),
                  padding: EdgeInsets.only(left: 10),
                  child:  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Align(

                          child: Text("Category :",style:TextStyle(color:Color(0xFF979DB0),fontWeight:FontWeight.bold ,fontSize:20,fontFamily: "Roboto"),),
                      alignment: Alignment.centerLeft
                      ),
                      ListTile(
                        contentPadding: EdgeInsets.symmetric(vertical: 0.0, horizontal:
                        0.0),
                        dense: true,
                        trailing: CircleAvatar(
                          backgroundColor: (!_addCategory)?Colors.blue:Colors.redAccent,

                          radius: 25,

                          child: IconButton(
                              icon:Icon((!_addCategory)?Icons.add_rounded:Icons.close_rounded),
                              color : Colors.white,
                              iconSize:25,

                            padding: EdgeInsets.all(0),
                            onPressed: (){
                                setState(() {
                                  _addCategory = !_addCategory;

                                });
                            },
                            alignment: Alignment.center,


                          ),
                        ),
                        horizontalTitleGap: null,
                        visualDensity: VisualDensity.standard,
                        title: (!_addCategory)?PopupMenuButton<int>(
                                  color: Theme.of(context).cardColor,
                          padding: EdgeInsets.zero,
                          elevation: 4,

                          itemBuilder: (context) {
                            var list = List<PopupMenuEntry<int>>();

                            List<String> itemCategories = (Variables().getCat().isNotEmpty)?Variables().getCat():[" "];
                            setState(() {
                              _categorySelected = itemCategories[0];
                            });
                            itemCategories.forEach((element) {

                              list.add(
                                PopupMenuItem(
                                  padding: EdgeInsets.all(0),

                                  child: Container(
                                      width: MediaQuery.of(context).size.width,
                                      height: 50,
                                      margin: EdgeInsets.all(10),
                                      padding: EdgeInsets.all(10),
                                      alignment: Alignment.centerLeft,
                                      decoration: ShapeDecoration(
                                        color: Theme.of(context).accentColor,

                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(20)
                                        ),
                                      ),
                                      child: Text(element.toString(),style:TextStyle(color:Theme.of(context).floatingActionButtonTheme.focusColor ,fontSize:16,fontFamily: "Roboto"),)),
                                  value: itemCategories.indexOf(element),
                                ),
                              );

                            });

                            return list;
                          },
                          // initialValue: indexFromUnit,
                          onCanceled: () {
                            print("You have canceled the menu.");
                          },
                          onSelected: (value) {
                          setState(() {
                            _categorySelected = Variables().getCat()[value];
                          });
                          },

                          child: Container(
                            margin: EdgeInsets.all(0),
                            decoration: ShapeDecoration(
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
                            child: ListTile(

                              trailing: Icon(Icons.keyboard_arrow_down_rounded , color: Color(0xFF363636),),
                              title: RichText(
                                  softWrap: true,
                                  text: TextSpan(text: _categorySelected , style: TextStyle(fontSize: 20, fontWeight: FontWeight.normal , color: Color(0xFF363636), ))),

                            ),
                          ),
                        ):TextField(
                          textAlign: TextAlign.left,
                          style: TextStyle(fontSize: 18,color: Theme.of(context).floatingActionButtonTheme.backgroundColor ),
                          maxLines: 1,
                          maxLength: 20,
                          showCursor: true,

                          controller: TextEditingController(),
                          autofocus: false,
                          minLines: 1,
                          keyboardType: TextInputType.text,

                          decoration: InputDecoration(
                            alignLabelWithHint: true,
                            prefixIcon: Icon(Icons.category),
                            labelText: "Category name",
                            labelStyle: TextStyle(fontSize: 16,color: Theme.of(context).floatingActionButtonTheme.backgroundColor ),

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
                            hintText: "Category name",
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
                Container(
                  height: 100,
                  width: MediaQuery.of(context).size.width,
                  color: Theme.of(context).backgroundColor,
                  margin: EdgeInsets.all(2),
                  padding: EdgeInsets.only(left: 10),
                  child:  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Align(

                          child: Text("Status :",style:TextStyle(color:Color(0xFF979DB0),fontWeight:FontWeight.bold ,fontSize:20,fontFamily: "Roboto"),),
                          alignment: Alignment.centerLeft
                      ),
                       PopupMenuButton<int>(
                          color: Theme.of(context).cardColor,
                          padding: EdgeInsets.zero,
                          elevation: 4,

                          itemBuilder: (context) {
                            var list = List<PopupMenuEntry<int>>();

                            List<String> itemStatus = Variables().status;
                            itemStatus.removeWhere((element) => element == "Finished");
                            itemStatus.forEach((element) {

                              list.add(
                                PopupMenuItem(
                                  padding: EdgeInsets.all(0),

                                  child: Container(
                                      width: MediaQuery.of(context).size.width,
                                      height: 50,
                                      margin: EdgeInsets.all(10),
                                      padding: EdgeInsets.all(10),
                                      alignment: Alignment.centerLeft,
                                      decoration: ShapeDecoration(
                                        color: Theme.of(context).accentColor,

                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(20)
                                        ),
                                      ),
                                      child: Text(element.toString(),style:TextStyle(color:Theme.of(context).floatingActionButtonTheme.focusColor ,fontSize:16,fontFamily: "Roboto"),)),
                                  value: itemStatus.indexOf(element),
                                ),
                              );

                            });

                            return list;
                          },
                          // initialValue: indexFromUnit,
                          onCanceled: () {
                            print("You have canceled the menu.");
                          },
                          onSelected: (value) {
                            setState(() {
                              _statusSelected = Variables().status[value];
                            });
                          },

                          child: Container(
                            margin: EdgeInsets.all(0),
                            decoration: ShapeDecoration(
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
                            child: ListTile(

                              trailing: Icon(Icons.keyboard_arrow_down_rounded , color: Color(0xFF363636),),
                              title: RichText(
                                  softWrap: true,
                                  text: TextSpan(text: _statusSelected , style: TextStyle(fontSize: 20, fontWeight: FontWeight.normal , color: Color(0xFF363636), ))),

                            ),
                          ),
                        )

                    ],
                  ),

                ),
                Container(
                  height: 100,
                  width: MediaQuery.of(context).size.width,
                  color: Theme.of(context).backgroundColor,
                  margin: EdgeInsets.all(2),
                  padding: EdgeInsets.only(left: 10),
                  child:  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Align(

                          child: Text("Frequency :",style:TextStyle(color:Color(0xFF979DB0),fontWeight:FontWeight.bold ,fontSize:20,fontFamily: "Roboto"),),
                          alignment: Alignment.centerLeft
                      ),
                      ListTile(
                        contentPadding: EdgeInsets.symmetric(vertical: 0.0, horizontal:
                        0.0),
                        dense: true,
                        trailing: CircleAvatar(
                          backgroundColor: (!_addDaysfrequency)?Colors.blue:Colors.redAccent,

                          radius: 25,

                          child: IconButton(
                            icon:Icon((!_addDaysfrequency)?Icons.date_range:Icons.close_rounded),
                            color : Colors.white,
                            iconSize:25,

                            padding: EdgeInsets.all(0),
                            onPressed: (){
                              setState(() {
                                _addDaysfrequency = !_addDaysfrequency;

                              });
                            },
                            alignment: Alignment.center,


                          ),
                        ),
                        horizontalTitleGap: null,
                        visualDensity: VisualDensity.standard,
                        title: (!_addDaysfrequency)?PopupMenuButton<int>(
                          color: Theme.of(context).cardColor,
                          padding: EdgeInsets.zero,
                          elevation: 4,

                          itemBuilder: (context) {
                            var list = List<PopupMenuEntry<int>>();

                            List<String> itemCategories = Variables().frequency;
                            setState(() {
                              _frequencySelected = itemCategories[0];
                            });
                            itemCategories.forEach((element) {

                              list.add(
                                PopupMenuItem(
                                  padding: EdgeInsets.all(0),

                                  child: Container(
                                      width: MediaQuery.of(context).size.width,
                                      height: 50,
                                      margin: EdgeInsets.all(10),
                                      padding: EdgeInsets.all(10),
                                      alignment: Alignment.centerLeft,
                                      decoration: ShapeDecoration(
                                        color: Theme.of(context).accentColor,

                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(20)
                                        ),
                                      ),
                                      child: Text(element.toString(),style:TextStyle(color:Theme.of(context).floatingActionButtonTheme.focusColor ,fontSize:16,fontFamily: "Roboto"),)),
                                  value: itemCategories.indexOf(element),
                                ),
                              );

                            });

                            return list;
                          },
                          // initialValue: indexFromUnit,
                          onCanceled: () {
                            print("You have canceled the menu.");
                          },
                          onSelected: (value) {
                            setState(() {
                              _frequencySelected = Variables().frequency[value];
                            });
                          },

                          child: Container(
                            margin: EdgeInsets.all(0),
                            decoration: ShapeDecoration(
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
                            child: ListTile(

                              trailing: Icon(Icons.keyboard_arrow_down_rounded , color: Color(0xFF363636),),
                              title: RichText(
                                  softWrap: true,
                                  text: TextSpan(text: _frequencySelected , style: TextStyle(fontSize: 20, fontWeight: FontWeight.normal , color: Color(0xFF363636), ))),

                            ),
                          ),
                        ):TextField(
                          textAlign: TextAlign.left,
                          style: TextStyle(fontSize: 18,color: Theme.of(context).floatingActionButtonTheme.backgroundColor ),
                          maxLines: 1,
                          maxLength: 20,
                          showCursor: true,

                          controller: TextEditingController(),
                          autofocus: false,
                          minLines: 1,
                          keyboardType: TextInputType.number,

                          decoration: InputDecoration(
                            alignLabelWithHint: true,
                            prefixIcon: Icon(Icons.category),
                            labelText: "Days number",
                            labelStyle: TextStyle(fontSize: 16,color: Theme.of(context).floatingActionButtonTheme.backgroundColor ),

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
                            hintText: "Days number",
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
                Container(
                        height: 100,
                        width: MediaQuery.of(context).size.width,
                        color: Theme.of(context).backgroundColor,
                        margin: EdgeInsets.all(2),
                        padding: EdgeInsets.only(left: 10),
                        child:  Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Align(

                              child: Text("Date Of Task :",style:TextStyle(color:Color(0xFF979DB0),fontWeight:FontWeight.bold ,fontSize:20,fontFamily: "Roboto"),),
                              alignment: Alignment.centerLeft
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                  flex: 1,
                                  child:MaterialButton(
                                      height: 50,
                                    onPressed: () => _selectDate(context),
                                    colorBrightness:Theme.of(context).primaryColorBrightness,
                                    padding: EdgeInsets.only(left: 10),
                                    elevation: 2,
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(5)
                                    ),
                                    color: Theme.of(context).accentColor,
                                    child:
                                    Text(selectedDate.day.toString()+"/"+selectedDate.month.toString()+"/"+selectedDate.year.toString() ,style: TextStyle(color:Theme.of(context).floatingActionButtonTheme.focusColor ,fontSize:20,fontFamily: "Roboto"),),

                                  ),),
                              SizedBox(
                                width: 5,
                                height: 50,
                              ),
                              Expanded(

                                child:MaterialButton(
                                  height: 50,
                                  onPressed: () => _selectTime(context),
                                  colorBrightness:Theme.of(context).primaryColorBrightness,
                                  padding: EdgeInsets.only(left: 10),
                                  elevation: 2,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5)
                                  ),
                                  color: Theme.of(context).accentColor,
                                  child:
                                  Text(_time.toString() ,style: TextStyle(color:Theme.of(context).floatingActionButtonTheme.focusColor ,fontSize:20,fontFamily: "Roboto"),),

                                ),),
                            ],
                          )

                        ])

                ),
                Container(
                    height: 100,
                    width: MediaQuery.of(context).size.width,
                    color: Theme.of(context).backgroundColor,
                    margin: EdgeInsets.all(2),
                    padding: EdgeInsets.only(left: 10),
                    child:  Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Align(

                              child: Text("Date Of Reminder :",style:TextStyle(color:Color(0xFF979DB0),fontWeight:FontWeight.bold ,fontSize:20,fontFamily: "Roboto"),),
                              alignment: Alignment.centerLeft
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                flex: 1,
                                child:MaterialButton(
                                  height: 50,
                                  onPressed: () => _selectReminder(context),
                                  colorBrightness:Theme.of(context).primaryColorBrightness,
                                  padding: EdgeInsets.only(left: 10),
                                  elevation: 2,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5)
                                  ),
                                  color: Theme.of(context).accentColor,
                                  child:
                                  Text(selectedReminder.day.toString()+"/"+selectedReminder.month.toString()+"/"+selectedReminder.year.toString() ,style: TextStyle(color:Theme.of(context).floatingActionButtonTheme.focusColor ,fontSize:20,fontFamily: "Roboto"),),

                                ),),
                              SizedBox(
                                width: 5,
                                height: 50,
                              ),
                              Expanded(

                                child:MaterialButton(
                                  height: 50,
                                  onPressed: () => _selectTimeReminder(context),
                                  colorBrightness:Theme.of(context).primaryColorBrightness,
                                  padding: EdgeInsets.only(left: 10),
                                  elevation: 2,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5)
                                  ),
                                  color: Theme.of(context).accentColor,
                                  child:
                                  Text(_timeR.toString() ,style: TextStyle(color:Theme.of(context).floatingActionButtonTheme.focusColor ,fontSize:20,fontFamily: "Roboto"),),

                                ),),
                            ],
                          )

                        ])

                ),
                Container(
                    height: 20,
                    width: MediaQuery.of(context).size.width,
                    color: Theme.of(context).backgroundColor,
                    margin: EdgeInsets.all(10),
                    padding: EdgeInsets.only(left: 10),
                    child: Text("Note :",style:TextStyle(color:Color(0xFF979DB0),fontWeight:FontWeight.bold ,fontSize:20,fontFamily: "Roboto"),),
                    alignment: Alignment.centerLeft
                ),
                Container(
                  height: 100,
                  width: MediaQuery.of(context).size.width,
                  color: Theme.of(context).backgroundColor,
                  margin: EdgeInsets.all(2),
                  padding: EdgeInsets.only(left: 10),
                  child: TextField(
                    textAlign: TextAlign.left,
                    style: TextStyle(fontSize: 18,color: Theme.of(context).floatingActionButtonTheme.backgroundColor ),
                    maxLines: 5,
                    maxLength: 100,
                    showCursor: true,

                    controller: TextEditingController(),
                    autofocus: false,
                    minLines: 5,
                    keyboardType: TextInputType.text,

                    decoration: InputDecoration(
                      alignLabelWithHint: true,
                      prefixIcon: Icon(Icons.note_add),
                      labelText: "Note",
                      labelStyle: TextStyle(fontSize: 16,color: Theme.of(context).floatingActionButtonTheme.backgroundColor ),

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
                      hintText: "Note",
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
    );
  }
}
