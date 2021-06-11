import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:todolist/Models/data_variable.dart';

class AddNewTasks extends StatefulWidget {

  @override
  _AddNewTasksState createState() => _AddNewTasksState();
}

class _AddNewTasksState extends State<AddNewTasks> {
  String _categorySelected = "Category";
  String _statusSelected = "Status";
  bool _addCategory = false;
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
                  TextField(
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
                        hintStyle: TextStyle(color: Theme.of(context).floatingActionButtonTheme.backgroundColor),

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
