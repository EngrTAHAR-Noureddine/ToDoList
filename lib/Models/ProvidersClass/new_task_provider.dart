import 'package:flutter/material.dart';
import 'package:todolist/DataBase/database.dart';
import 'package:todolist/Models/Data/data_variable.dart';
import 'package:todolist/Models/Data/draft_model.dart';
import 'package:todolist/Models/Data/task_model.dart';
import 'package:todolist/Models/ProvidersClass/task_list_provider.dart';
import 'package:todolist/main.dart';
import 'package:workmanager/workmanager.dart';

class NewTaskProvider extends ChangeNotifier{
  static final NewTaskProvider _singleton = NewTaskProvider._internal();
  factory NewTaskProvider() {
    return _singleton;
  }
  NewTaskProvider._internal();
  List<String> itemCategories =["Add New Category","Temporary"];
  List<bool> checkDate =[false,false,false];
  final formKey = GlobalKey<FormState>();

  Task task;
  TextEditingController taskName = new TextEditingController();
  TextEditingController addGoal =new TextEditingController();
  TextEditingController addNoteText =new TextEditingController();

  String categorySelected;
  String frequencySelected;
  DateTime selectedDate;
  TimeOfDay selectedTime;
  String  time;
  DateTime selectedReminder;
  TimeOfDay selectedTimeReminder ;
  String  timeR;
  List<String> _part =[];

//NewTaskProvider().init();
  init(){
     taskName.clear();
    addGoal.clear();
    addNoteText.clear();
    categorySelected = "Category";


     selectedDate = DateTime.now();
     selectedReminder = DateTime.now();

    selectedTime = TimeOfDay(hour: DateTime.now().hour, minute: DateTime.now().minute);
    selectedTimeReminder = TimeOfDay(hour: DateTime.now().hour, minute: DateTime.now().minute);
  }



  setTask(task){
    this.task = task;


    if(this.task==null) this.task = new Task(
                                                task: "",
                                                frequency: "",
                                                status: "",
                                                date: "",
                                                note: "",
                                                goal: "",
                                                category: "",
                                                timeReminder: "",
                                                dateReminder: "",
                                                time: ""
                                              );
    if((this.task.task!=null)&&(this.task.task.isNotEmpty))taskName.text = this.task.task;
    if((this.task.timeReminder!=null)&&(this.task.timeReminder.isNotEmpty))
      {
        timeR = this.task.timeReminder;

      }else timeR = selectedTimeReminder.hour.toString()+":"+selectedTimeReminder.minute.toString();

    categorySelected =((this.task.category!=null)&&(this.task.category.isNotEmpty))? this.task.category:(categorySelected!=null && categorySelected.isNotEmpty)?categorySelected:"Category";

    frequencySelected =((this.task.frequency!=null)&&(this.task.frequency.isNotEmpty))? this.task.frequency:(frequencySelected!=null && frequencySelected.isNotEmpty)?frequencySelected:Variables().frequency[0];

    if((this.task.dateReminder!=null)&&(this.task.dateReminder.isNotEmpty)){
      _part= this.task.dateReminder.split("/");
      selectedReminder = DateTime(int.parse(_part[2]),int.parse(_part[1]),int.parse(_part[0]));
    }

    if((this.task.date!=null)&&(this.task.date.isNotEmpty)){
      _part= this.task.date.split("/");
      selectedDate = DateTime(int.parse(_part[2]),int.parse(_part[1]),int.parse(_part[0]));
    }

    if((this.task.note!=null)&&(this.task.note.isNotEmpty)) addNoteText.text = this.task.note;

    if((this.task.status!=null)&&(this.task.status.isNotEmpty)) this.task.status= Variables().status[3];

    if((this.task.goal!=null)&&(this.task.goal.isNotEmpty))addGoal.text = this.task.goal;
    if((this.task.time!=null)&&(this.task.time.isNotEmpty)) {
      time = this.task.time;

    }else  time = selectedTime.hour.toString()+":"+selectedTime.minute.toString();


  }

  Future<void> declineAdding(context)async{
    if(task.task!=null && task.task.isNotEmpty) {
      DBProvider.db.newTask(task);
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
          constraints: Constraints(
            networkType: NetworkType.not_required,
            requiresBatteryNotLow: true,
          ),
          initialDelay: Duration(seconds: 1)
      );
    }



    if(categorySelected =="Category") categorySelected = "Temporary";

    this.task.task = taskName.text;
    this.task.status = Variables().status[3];
    this.task.frequency = frequencySelected;
    this.task.goal = addGoal.text;
    this.task.category = categorySelected;
    this.task.note = addNoteText.text;
    this.task.date = selectedDate.day.toString()+"/"+selectedDate.month.toString()+"/"+selectedDate.year.toString();
    this.task.time = time;
    this.task.timeReminder = timeR;
    this.task.dateReminder = selectedReminder.day.toString()+"/"+selectedReminder.month.toString()+"/"+selectedReminder.year.toString();



    Draft taskAsDraft = Task().convert(this.task);

    if((taskAsDraft.task.isNotEmpty) && (taskAsDraft.task!=null)) DBProvider.db.newDraft(taskAsDraft);

    Navigator.pop(context);
    ToDoListBodyProvider().setState();
    notifyListeners();
  }


  Future<void> saveTask(context)async{
    if (this.formKey.currentState.validate()) {
      DateTime yesterday= DateTime(DateTime.now().year,DateTime.now().month,DateTime.now().day-1);
      if(selectedDate.isBefore(yesterday)){

          checkDate[0] = true;

          notifyListeners();
      }else{

          checkDate[0] = false;
          notifyListeners();
      }
      if(selectedReminder.isBefore(selectedDate)){

          checkDate[1] = true;
          notifyListeners();
      }else {

        if((selectedDate.year == selectedReminder.year)&&(selectedDate.month == selectedReminder.month)&&(selectedDate.day == selectedReminder.day)){

          List<String> time1 = time.split(":");
          List<String> time2 = timeR.split(":");

          if((int.parse(time1[0])*60+int.parse(time1[1]))<(int.parse(time2[0])*60+int.parse(time2[1]))){


              checkDate[1] = false;
              checkDate[2] = true;
              notifyListeners();

          }else{


              checkDate[1] = false;
              checkDate[2] = false;
              notifyListeners();

          }

        }else{


            checkDate[1] = false;
            checkDate[2] = false;
            notifyListeners();


        }


      }
      if(!checkDate[0] && !checkDate[1] && !checkDate[2]){

        checkDate[0] = false;
        checkDate[1] = false;
        checkDate[2] = false;
        if(categorySelected =="Category") categorySelected = "Temporary";

        this.task.task = taskName.text;
        this.task.status = Variables().status[3];
        this.task.frequency = frequencySelected;
        this.task.goal = addGoal.text;
        this.task.category = categorySelected;
        this.task.note = addNoteText.text;
        this.task.date = selectedDate.day.toString()+"/"+selectedDate.month.toString()+"/"+selectedDate.year.toString();
        this.task.time = time;
        this.task.timeReminder = timeR;
        this.task.dateReminder = selectedReminder.day.toString()+"/"+selectedReminder.month.toString()+"/"+selectedReminder.year.toString();

        if (task.task != null && task.task.isNotEmpty) {
          await DBProvider.db.newTask(this.task);

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
              constraints: Constraints(
                networkType: NetworkType.not_required,
                requiresBatteryNotLow: true,
              ),
              initialDelay: Duration(seconds: 1)
          );

        }


        this.formKey.currentState.save();

        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('New Task added')));

        notifyListeners();
        Navigator.pop(context);

      }



     ToDoListBodyProvider().setState();
    }




  }


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
                        
                          itemCategories.add(_textEditingController.text);
                          categorySelected = _textEditingController.text;
                        
                        Navigator.of(context).pop();
                          notifyListeners();
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
    if (picked != null && picked != selectedDate) {
      selectedDate = picked;

    }
  //  this.task.date = selectedDate.day.toString()+"/"+selectedDate.month.toString()+"/"+selectedDate.year.toString();
      notifyListeners();
  }

  Future<Null> _selectTime(BuildContext context) async {

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
    if (picked != null) {
      selectedTime = picked;

      time = selectedTime.hour.toString() + ':' + selectedTime.minute.toString();

    }
    //this.task.time = selectedTime.hour.toString() + ':' + selectedTime.minute.toString();
      notifyListeners();
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

    if (picked != null && picked != selectedReminder) {
      selectedReminder = picked;
        }
  //  this.task.dateReminder = selectedReminder.day.toString()+"/"+selectedReminder.month.toString()+"/"+selectedReminder.year.toString();
    notifyListeners();
  }
  Future<Null> _selectTimeReminder(BuildContext context) async {

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
    if (picked != null) {
      selectedTimeReminder = picked;
      timeR = selectedTimeReminder.hour.toString() + ':' + selectedTimeReminder.minute.toString();

    }
   // this.task.timeReminder = selectedTimeReminder.hour.toString() + ':' + selectedTimeReminder.minute.toString();
      notifyListeners();
  }

   titleText(String title){
    return Container(
      alignment: Alignment.centerLeft,
      child:Text(title,style:TextStyle(color:Color(0xFF979DB0),fontWeight:FontWeight.bold ,fontSize:16,fontFamily: "Roboto"),),
    );
  }

   inputTaskName(context){
    return  Container(
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

        controller: this.taskName,
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
    );
  }


  categoryChoice(context){
    return Container(
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
          
              categorySelected = itemCategories[value];
           notifyListeners();
          }
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text( categorySelected , style: TextStyle(fontSize: 14, fontWeight: FontWeight.normal , color: Theme.of(context).floatingActionButtonTheme.backgroundColor,)),
            Icon(Icons.keyboard_arrow_down_rounded , color:  Theme.of(context).floatingActionButtonTheme.backgroundColor,),

          ],
        ),
      ),


    );
  }


  frequencyPopMenu(context){
    return Container(
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
          
            frequencySelected = Variables().frequency[value];
         notifyListeners();
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text( frequencySelected , style: TextStyle(fontSize: 14, fontWeight: FontWeight.normal , color: Theme.of(context).floatingActionButtonTheme.backgroundColor,)),
            Icon(Icons.keyboard_arrow_down_rounded , color:  Theme.of(context).floatingActionButtonTheme.backgroundColor,),

          ],
        ),
      ),
    );
  }
  goalField(context){
    return  Container(
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

        controller: addGoal,
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
    );
  }

  showDateTimeSelected(context){
    return  Container(

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

                onPressed: () => _selectDate(context),
                colorBrightness:Theme.of(context).primaryColorBrightness,
                //padding: EdgeInsets.only(left: 10),
                elevation: 2,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5)
                ),
                color: Theme.of(context).accentColor,
                child:
                Text(this.selectedDate.day.toString()+"/"+this.selectedDate.month.toString()+"/"+this.selectedDate.year.toString() ,style: TextStyle(color: Theme.of(context).floatingActionButtonTheme.backgroundColor ,fontSize:14,fontFamily: "Roboto"),),

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
                Text(this.time.toString() ,style: TextStyle(color: Theme.of(context).floatingActionButtonTheme.backgroundColor ,fontSize:14,fontFamily: "Roboto"),),

              ),),
          ],
        )

    );
  }

  showDateTimeReminder(context){
    return Container(
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
                Text(this.selectedReminder.day.toString()+"/"+this.selectedReminder.month.toString()+"/"+this.selectedReminder.year.toString()  ,style: TextStyle(color: Theme.of(context).floatingActionButtonTheme.backgroundColor ,fontSize:14,fontFamily: "Roboto"),),

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
                Text( this.timeR.toString() ,style: TextStyle(color: Theme.of(context).floatingActionButtonTheme.backgroundColor ,fontSize:14,fontFamily: "Roboto"),),

              ),),
          ],
        )

    );
  }

  noteField(context){
    return Container(
      width: MediaQuery.of(context).size.width,
      color: Theme.of(context).backgroundColor,
      margin: EdgeInsets.only(top:5,bottom: 10),
      padding: EdgeInsets.only(left: 10, right: 10,),
      child: TextField(
        textAlign: TextAlign.left,
        style: TextStyle(fontSize: 14,color: Theme.of(context).floatingActionButtonTheme.backgroundColor ),
        maxLines: 5,
        maxLength: 100,
        showCursor: true,

        controller: this.addNoteText,
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
    );
  }



}
