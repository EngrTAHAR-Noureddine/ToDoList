import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:todolist/DataBase/database.dart';
import 'package:todolist/Models/Data/data_variable.dart';
import 'package:todolist/Models/Data/draft_model.dart';
import 'package:todolist/Models/Data/task_model.dart';
import 'package:todolist/Models/ProvidersClass/task_button.dart';
import 'package:todolist/main.dart';
import 'package:workmanager/workmanager.dart';


class AddNewTasks extends StatefulWidget {
  int id;
  String task;
  String category;
  String note;
  String status;
  String frequency;
  String date;
  String time;
  String dateReminder;
  String timeReminder;
  String goal;
  AddNewTasks({ this.goal,
    this.category,this.note,
    this.task,this.date,
    this.status,this.frequency,
    this.dateReminder,this.timeReminder,
    this.time, this.id
  });
  @override
  _AddNewTasksState createState() => _AddNewTasksState();
}

class _AddNewTasksState extends State<AddNewTasks> {


  Future<void> showDialogToAddCategory(BuildContext context) async {
    final TextEditingController _textEditingController = TextEditingController();
    final GlobalKey<FormState> _formKeyDialogCat = GlobalKey<FormState>();

    return await showDialog(
        context: context,
        builder: (context) {
          return   Center(
            child: SingleChildScrollView(

              child: AlertDialog(
                backgroundColor:Theme.of(context).floatingActionButtonTheme.hoverColor,

                shape: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                content: GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () {
                    FocusScope.of(context).requestFocus(new FocusNode());
                  },
                  child:   Form(
                      key: _formKeyDialogCat,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          TextFormField(
                            controller: _textEditingController,
                            validator: (value) {
                              return value.isNotEmpty ? null : "Enter category";
                            },
                            decoration:
                            InputDecoration(hintText: "Please Enter category",hintStyle: TextStyle(color: Color(0xFFB8B8B8))),
                          ),

                        ],
                      )),

                ),
                title: Text('Add Category',style: TextStyle(color: Color(0xFF979DB0) ),),
                actions: <Widget>[
                  MaterialButton(

                    onPressed:() {
                      if (_formKeyDialogCat.currentState.validate()) {
                        setState((){
                          itemCategories.add(_textEditingController.text);
                          _categorySelected = _textEditingController.text;
                        });
                        Navigator.of(context).pop();

                      }
                    },

                    child: Text('OK',style: TextStyle(color:Color(0xFF979DB0)),),
                  ),

                  MaterialButton(
                    child: Text('Cancel',style:TextStyle(color: Color(0xFF979DB0) )),
                    onPressed: () {
                      Navigator.of(context).pop();

                    },
                  ),
                ],
              ),
            ),
          );

        });


  }

  List<String> itemCategories =["Add New Category","Temporary"];

  final _formKey = GlobalKey<FormState>();
  FocusScopeNode currentFocus =new FocusScopeNode();//Goal
  TextEditingController _taskName = new TextEditingController();
  TextEditingController _addFrequencyText =new TextEditingController();
  TextEditingController _addNoteText =new TextEditingController();
  TextEditingController _addGoal =new TextEditingController();

  bool enabled = true;
  String _categorySelected;

  String _frequencySelected;

  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay(hour: 00, minute: 00);
  String  _time= DateTime.now().hour.toString()+":"+DateTime.now().minute.toString();
  String _statusSelected;
  DateTime selectedReminder = DateTime.now();
  TimeOfDay selectedTimeReminder = TimeOfDay(hour: 00, minute: 00);
  String  _timeR= DateTime.now().hour.toString()+":"+DateTime.now().minute.toString();


  Future<Null> _selectTimeReminder(BuildContext context) async {
    String _hour, _minute;
    final TimeOfDay picked = await showTimePicker(
      builder: (BuildContext context, Widget child) {
        return Theme(
          data: Variables().mode(context),
          child: child,
        );
      },
      context: context,
      initialTime: selectedTimeReminder,
    );
    if (picked != null)
      setState(() {
        selectedTimeReminder = picked;
        _hour = selectedTimeReminder.hour.toString();
        _minute = selectedTimeReminder.minute.toString();
        _timeR = _hour + ':' + _minute;

      });
  }



  _selectReminder(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      builder: (BuildContext context, Widget child) {
        return Theme(
          data: Variables().mode(context),
          child: child,
        );
      },
      context: context,
      initialDate: selectedReminder, // Refer step 1
      firstDate: DateTime(2000),
      lastDate: DateTime(3000),
    );
    // DateTime dt ;
    if (picked != null && picked != selectedReminder)
      //dt = DateTime(picked.year,picked.month,picked.day,0,0,0,0,0);
      setState(() {
        selectedReminder = picked;
      });
  }

  Future<Null> _selectTime(BuildContext context) async {
    String _hour, _minute;
    final TimeOfDay picked = await showTimePicker(

      builder: (BuildContext context, Widget child) {
        return Theme(
          data: Variables().mode(context),
          child: child,
        );
      },
      context: context,
      initialTime: selectedTime,
    );
    if (picked != null)
      setState(() {
        selectedTime = picked;
        _hour = selectedTime.hour.toString();
        _minute = selectedTime.minute.toString();
        _time = _hour + ':' + _minute;

      });
  }



  _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      builder: (BuildContext context, Widget child) {
        return Theme(
          data: Variables().mode(context),
          child: child,
        );
      },
      context: context,
      initialDate: selectedDate, // Refer step 1
      firstDate: DateTime(2000),
      lastDate: DateTime(3000),
    );
    //   DateTime dt ;
    if (picked != null && picked != selectedDate)
      // dt = DateTime(picked.year,picked.month,picked.day,0,0,0,0,0);
      setState(() {
        selectedDate = picked;
      });
  }
  List<String> _part =[];

  @override
  void initState() {

    if((widget.task!=null)&&(widget.task.isNotEmpty))_taskName.text = widget.task;
    if((widget.timeReminder!=null)&&(widget.timeReminder.isNotEmpty)) _timeR = widget.timeReminder;

    _categorySelected =((widget.category!=null)&&(widget.category.isNotEmpty))? widget.category:(_categorySelected!=null && _categorySelected.isNotEmpty)?_categorySelected:"Category";

    _frequencySelected =((widget.frequency!=null)&&(widget.frequency.isNotEmpty))? widget.frequency:(_frequencySelected!=null && _frequencySelected.isNotEmpty)?_frequencySelected:Variables().frequency[0];

    if((widget.dateReminder!=null)&&(widget.dateReminder.isNotEmpty)){
      _part= widget.dateReminder.split("/");
      selectedReminder = DateTime(int.parse(_part[2]),int.parse(_part[1]),int.parse(_part[0]));
    }

    if((widget.date!=null)&&(widget.date.isNotEmpty)){
      _part= widget.date.split("/");
      selectedDate = DateTime(int.parse(_part[2]),int.parse(_part[1]),int.parse(_part[0]));
    }

    if((widget.note!=null)&&(widget.note.isNotEmpty)) _addNoteText.text = widget.note;

     _statusSelected =((widget.status!=null)&&(widget.status.isNotEmpty))? widget.status:Variables().status[3];

    if((widget.goal!=null)&&(widget.goal.isNotEmpty))_addGoal.text = widget.goal;
    if((widget.time!=null)&&(widget.time.isNotEmpty)) _time =widget.time ;
  }

  List<bool> _checkdate =[false,false,false]; /* test date selected with time now and the second for reminder date if before or after selecter date*/

  @override
  Widget build(BuildContext context) {
    initState();
    return WillPopScope (
      onWillPop: () async{

        if(widget.task!=null && widget.task.isNotEmpty) {
          Task task = new Task(
              task:widget.task,
              timeReminder: widget.timeReminder,
              dateReminder:widget.dateReminder,
              category: widget.category,
              frequency: widget.frequency,
              date: widget.date,
              note: widget.note,
              status: widget.status,
              goal: widget.goal,
              time: widget.time
          );

          if(task.task!=null && task.task.isNotEmpty) DBProvider.db.newTask(task);
        }


        if(_categorySelected =="Category") _categorySelected = "Temporary";
        Draft taskAsDraft = new Draft(
            task:_taskName.text,
            timeReminder: _timeR,
            dateReminder:selectedReminder.day.toString()+"/"+selectedReminder.month.toString()+"/"+selectedReminder.year.toString(),
            category: _categorySelected,
            frequency: _frequencySelected,
            date: selectedDate.day.toString()+"/"+selectedDate.month.toString()+"/"+selectedDate.year.toString(),
            note: _addNoteText.text,
            status: _statusSelected,
            goal: _addGoal.text,
            time: _time
        );
        if((taskAsDraft.task.isNotEmpty) && (taskAsDraft.task!=null)) DBProvider.db.newDraft(taskAsDraft);

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
            onPressed: ()async{
              if(widget.task!=null && widget.task.isNotEmpty) {
                Task task = new Task(
                    task: widget.task,
                    timeReminder: widget.timeReminder,
                    dateReminder: widget.dateReminder,
                    category: widget.category,
                    frequency: widget.frequency,
                    date: widget.date,
                    note: widget.note,
                    status: widget.status,
                    goal: widget.goal,
                    time: widget.time
                );

                if (task.task != null && task.task.isNotEmpty) {
                  await DBProvider.db.newTask(task);

                  WidgetsFlutterBinding.ensureInitialized();
                    await Workmanager().initialize(callbackDispatcher);
                    await Workmanager().registerOneOffTask(
                        DateTime.now().toString(), "task",
                        inputData: {
                          "data": "init",
                          "title":" ",
                          "body":" ",
                          "time":" ",
                          "idTask":0,
                          "date":" ",
                          "status":" ",
                          "frequency":" ",
                          "isReminder":"no"},
                        initialDelay: Duration(seconds: 1)
                    );

                }
              }


              if(_categorySelected =="Category") _categorySelected = "Temporary";
              Draft taskAsDraft = new Draft(
                  task:_taskName.text,
                  timeReminder: _timeR,
                  dateReminder:selectedReminder.day.toString()+"/"+selectedReminder.month.toString()+"/"+selectedReminder.year.toString(),
                  category: _categorySelected,
                  frequency: _frequencySelected,
                  date: selectedDate.day.toString()+"/"+selectedDate.month.toString()+"/"+selectedDate.year.toString(),
                  note: _addNoteText.text,
                  status: _statusSelected,
                  goal: _addGoal.text,
                  time: _time
              );

              if((taskAsDraft.task.isNotEmpty) && (taskAsDraft.task!=null)) DBProvider.db.newDraft(taskAsDraft);

              Navigator.pop(context);
            },
          ),
          actions: [
            Container(

              child: MaterialButton(
                onPressed: ()async{
                  if (_formKey.currentState.validate()) {
                    DateTime yesterday= DateTime(DateTime.now().year,DateTime.now().month,DateTime.now().day-1);
                    if(selectedDate.isBefore(yesterday)){
                      setState(() {
                        _checkdate[0] = true;
                        print("************* _checkdate[0] : "+_checkdate[0].toString());
                      });
                    }else{
                      setState(() {
                        _checkdate[0] = false;
                        print("************* _checkdate[0] : "+_checkdate[0].toString());
                      });
                    }
                    if(selectedReminder.isBefore(selectedDate)){
                      setState(() {
                        _checkdate[1] = true;
                        print("************* _checkdate[1] inside isbefore  : "+_checkdate[1].toString());
                      });
                    }else {

                      if((selectedDate.year == selectedReminder.year)&&(selectedDate.month == selectedReminder.month)&&(selectedDate.day == selectedReminder.day)){

                        List<String> time1 = _time.split(":");
                        List<String> time2 = _timeR.split(":");

                        if((int.parse(time1[0])*60+int.parse(time1[1]))<(int.parse(time2[0])*60+int.parse(time2[1]))){

                          setState(() {
                            _checkdate[1] = false;
                            _checkdate[2] = true;
                            print("************* _checkdate[2] inside intparse : "+_checkdate[2].toString());
                          });

                        }else{

                          setState(() {
                            _checkdate[1] = false;
                            _checkdate[2] = false;
                            print("************* _checkdate[2] else intparse: "+_checkdate[2].toString());
                          });

                        }

                      }else{

                        setState(() {
                          _checkdate[1] = false;
                          _checkdate[2] = false;
                          print("************* _checkdate[2] inside else not same : "+_checkdate[2].toString());
                        });


                      }


                    }
                    if(!_checkdate[0] && !_checkdate[1] && !_checkdate[2]){

                      _checkdate[0] = false;
                      _checkdate[1] = false;
                      _checkdate[2] = false;
                      print("************* _checkdate[0] : "+_checkdate[0].toString());
                      print("************* _checkdate[1] : "+_checkdate[1].toString());
                      if(_categorySelected =="Category") _categorySelected = "Temporary";

                      Task task = new Task(
                          task:_taskName.text,
                          timeReminder: _timeR,
                          dateReminder:selectedReminder.day.toString()+"/"+selectedReminder.month.toString()+"/"+selectedReminder.year.toString(),
                          category: _categorySelected,
                          frequency: _frequencySelected,
                          date: selectedDate.day.toString()+"/"+selectedDate.month.toString()+"/"+selectedDate.year.toString(),
                          note: _addNoteText.text,
                          status: _statusSelected,
                          goal: _addGoal.text,
                          time: _time
                      );

                      if (task.task != null && task.task.isNotEmpty) {
                        await DBProvider.db.newTask(task);

                          WidgetsFlutterBinding.ensureInitialized();
                          await Workmanager().initialize(callbackDispatcher);
                          await Workmanager().registerOneOffTask(
                              DateTime.now().toString(), "task",
                              inputData: {
                                "data": "init",
                                "title":" ",
                                "body":" ",
                                "time":" ",
                                "idTask":0,
                                "date":" ",
                                "status":" ",
                                "frequency":" ",
                                "isReminder":"no"
                              },
                              initialDelay: Duration(seconds: 1)
                          );

                      }


                      _formKey.currentState.save();

                      ScaffoldMessenger.of(context)
                          .showSnackBar(SnackBar(content: Text('New Task added')));

                      setState(() {});
                      Navigator.pop(context);

                    }



                    TaskButton().setState();
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
          title: Text('Add New Task',style: TextStyle(color:Color(0xFF979DB0)),),
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
                    child:Text("Task name :",style:TextStyle(color:Color(0xFF979DB0),fontWeight:FontWeight.bold ,fontSize:16,fontFamily: "Roboto"),),
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

                      controller: _taskName,
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

                      controller: _addGoal,
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