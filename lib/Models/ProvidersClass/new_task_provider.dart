import 'package:flutter/material.dart';
import 'package:todolist/Models/Data/data_variable.dart';
import 'package:todolist/Models/Data/task_model.dart';

class NewTaskProvider extends ChangeNotifier{
  static final NewTaskProvider _singleton = NewTaskProvider._internal();
  factory NewTaskProvider() {
    return _singleton;
  }
  NewTaskProvider._internal();
  List<String> itemCategories =["Add New Category","Temporary"];
  List<bool> checkdate =[false,false,false];

  Task task;
  TextEditingController _taskName = new TextEditingController();
  TextEditingController _addGoal =new TextEditingController();
  TextEditingController _addNoteText =new TextEditingController();

  String _categorySelected;
  String _frequencySelected;
  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay(hour: 00, minute: 00);
  String  _time= DateTime.now().hour.toString()+":"+DateTime.now().minute.toString();
  DateTime selectedReminder = DateTime.now();
  TimeOfDay selectedTimeReminder = TimeOfDay(hour: 00, minute: 00);
  String  _timeR= DateTime.now().hour.toString()+":"+DateTime.now().minute.toString();

  setTask(task){
    this.task = task;
  }

  Future<void> declineAdding(context)async{
    Navigator.pop(context);
  }


  Future<void> saveTask(context)async{
    Navigator.pop(context);
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
                          _categorySelected = _textEditingController.text;
                        
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
    if (picked != null && picked != selectedDate)
      // dt = DateTime(picked.year,picked.month,picked.day,0,0,0,0,0);

        selectedDate = picked;
      notifyListeners();
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

        selectedTime = picked;
        _hour = selectedTime.hour.toString();
        _minute = selectedTime.minute.toString();
        _time = _hour + ':' + _minute;

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
    // DateTime dt ;
    if (picked != null && picked != selectedReminder)
      //dt = DateTime(picked.year,picked.month,picked.day,0,0,0,0,0);

        selectedReminder = picked;
     notifyListeners();
  }
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

        selectedTimeReminder = picked;
        _hour = selectedTimeReminder.hour.toString();
        _minute = selectedTimeReminder.minute.toString();
        _timeR = _hour + ':' + _minute;

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

        controller: this._taskName,
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
          
              _categorySelected = itemCategories[value];
           notifyListeners();
          }
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
          
            _frequencySelected = Variables().frequency[value];
         notifyListeners();
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
    );
  }


  



}