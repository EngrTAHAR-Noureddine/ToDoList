import 'package:flutter/material.dart';
import 'package:todolist/DataBase/database.dart';
import 'package:todolist/Models/Data/user_model.dart';
import 'package:todolist/Models/ProvidersClass/goal_provider.dart';

class SettingsProvider extends ChangeNotifier{
  static final SettingsProvider _singleton = SettingsProvider._internal();
  factory SettingsProvider() {
    return _singleton;
  }
  SettingsProvider._internal();
  User user ;

  Future<User> getUser()async{
    User user = await DBProvider.db.getUser(1);
    this.user = user;
    return user;
  }
  Future<void> showDialogToHideGoals(BuildContext context,) async {
    final TextEditingController _textEditingController = TextEditingController();
    final GlobalKey<FormState> _formKeyDialogCat = GlobalKey<FormState>();
    String title = "Enter Password";
    String hintText = "Enter password";
    String validButton ="Enter";

    return await showDialog(
        barrierDismissible: false,
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
                            style: TextStyle(color: Theme.of(context).floatingActionButtonTheme.focusColor),
                            controller: _textEditingController,
                            validator: (value) {
                              return (value.isNotEmpty) ? (value!=user.passWord )?"incorrect password":null: "Enter passowrd";
                            },
                            decoration:
                            InputDecoration(hintText: hintText,hintStyle: TextStyle(color: Color(0xFFB8B8B8))),
                          ),

                        ],
                      )),

                ),
                title: Text(title,style: TextStyle(color: Color(0xFF979DB0) ),),
                actions: <Widget>[
                  MaterialButton(

                    onPressed:()async{
                      if (_formKeyDialogCat.currentState.validate()) {

                        user.hideGoal ="no";
                        await DBProvider.db.updateUser(user);
                       // GoalProvider().setState();
                        notifyListeners();
                        Navigator.of(context).pop();

                      }
                    },

                    child: Text(validButton,style: TextStyle(color:Color(0xFF979DB0)),),
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

  Future<void> showDialogToAddPassword(BuildContext context,String text) async {
    final TextEditingController _textEditingController = TextEditingController();
    final GlobalKey<FormState> _formKeyDialogCat = GlobalKey<FormState>();
    String title = (text=="add")?"Add Password":"Remove Password";
    String hintText = (text=="add")?"Enter new password":"Enter password";
    String validButton =text;
    return await showDialog(
        barrierDismissible: false,
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
                            style: TextStyle(color: Theme.of(context).floatingActionButtonTheme.focusColor),
                            controller: _textEditingController,
                            validator: (value) {
                              return value.isNotEmpty ? (value!=user.passWord && text =="remove")?"incorrect password":null: "Enter passowrd";
                            },
                            decoration:
                            InputDecoration(hintText: hintText,hintStyle: TextStyle(color: Color(0xFFB8B8B8))),
                          ),

                        ],
                      )),

                ),
                title: Text(title,style: TextStyle(color: Color(0xFF979DB0) ),),
                actions: <Widget>[
                  MaterialButton(

                    onPressed:()async{
                      if (_formKeyDialogCat.currentState.validate()) {
                        user.passWord =(text=="add")? _textEditingController.text:"";
                        await DBProvider.db.updateUser(user);
                        notifyListeners();
                        Navigator.of(context).pop();

                      }
                    },

                    child: Text(validButton,style: TextStyle(color:Color(0xFF979DB0)),),
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

  Future<void> showDialogToAddLink(BuildContext context,String text) async {
    final TextEditingController _textEditingController = TextEditingController();
    final GlobalKey<FormState> _formKeyDialogCat = GlobalKey<FormState>();
    String title = "Add Link Google Calendar";
    String hintText = "Enter new Link";
    String validButton =text;
    return await showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return   Center(
            child: SingleChildScrollView(

              child: AlertDialog(
                backgroundColor:Theme.of(context).floatingActionButtonTheme.hoverColor,
                contentTextStyle: TextStyle(color: Theme.of(context).floatingActionButtonTheme.focusColor),
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
                            style: TextStyle(color: Theme.of(context).floatingActionButtonTheme.focusColor),
                            controller: _textEditingController,
                            validator: (value) {
                              return value.isNotEmpty ? null: "Enter Link";
                            },
                            decoration:
                            InputDecoration(hintText: hintText,hintStyle: TextStyle(color: Color(0xFFB8B8B8))),
                          ),

                        ],
                      )),

                ),
                title: Text(title,style: TextStyle(color: Color(0xFF979DB0) ),),
                actions: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      (validButton!="add")?  MaterialButton(

                        onPressed:()async{

                          user.linkAgenda = "none";
                          await DBProvider.db.updateUser(user);
                          notifyListeners();
                          Navigator.of(context).pop();


                        },

                        child: Text("remove",style: TextStyle(color:Color(0xFF979DB0)),),
                      ):Container(),

                      MaterialButton(

                        onPressed:()async{
                          if (_formKeyDialogCat.currentState.validate()) {
                            user.linkAgenda = _textEditingController.text;
                            await DBProvider.db.updateUser(user);
                            notifyListeners();
                            Navigator.of(context).pop();

                          }
                        },

                        child: Text(validButton,style: TextStyle(color:Color(0xFF979DB0)),),
                      ),

                      MaterialButton(
                        child: Text('Cancel',style:TextStyle(color: Color(0xFF979DB0) )),
                        onPressed: () {
                          Navigator.of(context).pop();

                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );

        });


  }

  setState(){notifyListeners();}
}