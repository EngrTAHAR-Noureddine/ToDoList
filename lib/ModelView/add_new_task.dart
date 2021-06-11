import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AddNewTasks extends StatefulWidget {

  @override
  _AddNewTasksState createState() => _AddNewTasksState();
}

class _AddNewTasksState extends State<AddNewTasks> {
  bool b= false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        brightness: Theme.of(context).primaryColorBrightness,
        backgroundColor: Theme.of(context).backgroundColor,
        elevation: 0,
        iconTheme: IconThemeData(color: Color(0xFF8F8FA8) ),
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
      body:Container(
        color: Theme.of(context).backgroundColor,
        child: ListView(
          scrollDirection: Axis.vertical,
          children: [
            Container(
              height: 70,
              width: MediaQuery.of(context).size.width,
              color: Colors.white,
              margin: EdgeInsets.all(2),
              child:TextField(
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
                  hintStyle: TextStyle(color: Theme.of(context).floatingActionButtonTheme.backgroundColor),

                  enabledBorder:  OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),

                    borderSide: BorderSide(
                      color: Theme.of(context).splashColor,
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
            Container(
              height: 70,
              width: MediaQuery.of(context).size.width,
              color:(b)? Colors.blue:Colors.amberAccent,
              margin: EdgeInsets.all(2),
              child:  PopupMenuButton<int>(

                itemBuilder: (context) {
                  var list = List<PopupMenuEntry<int>>();

                  List ItemUnit = [1,2,3,4,6,"7",8,"9","10"];
                  ItemUnit.forEach((element) {

                    list.add(
                      PopupMenuItem(
                        child: Text(element.toString()),
                        value: ItemUnit.indexOf(element),
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
                  print("You have canceled the menu.");
                },

                child: Container(
                  margin: EdgeInsets.only(bottom: 10),
                  decoration: ShapeDecoration(
                    color: Color(0xFFF4F4F4),

                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)
                    ),
                  ),
                  child: ListTile(
                    trailing: Icon(Icons.keyboard_arrow_down_rounded , color: Color(0xFF363636),),
                    title: RichText(
                        softWrap: true,
                        text: TextSpan(text: "fromUnit" , style: TextStyle(fontSize: 20, fontWeight: FontWeight.normal , color: Color(0xFF363636), ))),

                  ),
                ),
              ),

            ),
            Container(
              height: 70,
              width: MediaQuery.of(context).size.width,
              color: Colors.blue,
              margin: EdgeInsets.all(2),

            ),
            Container(
              height: 70,
              width: MediaQuery.of(context).size.width,
              color: Colors.blue,
              margin: EdgeInsets.all(2),
            ),
            Container(
              height: 70,
              width: MediaQuery.of(context).size.width,
              color: Colors.blue,
              margin: EdgeInsets.all(2),
            ),
            Container(
              height: 70,
              width: MediaQuery.of(context).size.width,
              color: Colors.blue,
              margin: EdgeInsets.all(2),
            ),
            Container(
              height: 70,
              width: MediaQuery.of(context).size.width,
              color: Colors.blue,
              margin: EdgeInsets.all(2),
            ),
          ],
        ),
      ),
    );
  }
}
