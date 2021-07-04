import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:todolist/DataBase/database.dart';
import 'package:todolist/Models/ProvidersClass/provider_class.dart';
import 'package:todolist/Models/Data/user_model.dart';

class SettingsModel extends StatefulWidget {
  const SettingsModel({Key key}) : super(key: key);

  @override
  _SettingsModelState createState() => _SettingsModelState();
}

class _SettingsModelState extends State<SettingsModel> {


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
                        setState((){});
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
                        setState((){});
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
                            setState((){});
                            Navigator.of(context).pop();


                        },

                        child: Text("remove",style: TextStyle(color:Color(0xFF979DB0)),),
                      ):Container(),

                      MaterialButton(

                        onPressed:()async{
                          if (_formKeyDialogCat.currentState.validate()) {
                            user.linkAgenda = _textEditingController.text;
                            await DBProvider.db.updateUser(user);
                            setState((){});
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

  User user ;

  Future<User> getUser()async{
    User user = await DBProvider.db.getUser(1);

    return user;
  }
  List<bool> _switches =[false,false,false,false];
  @override
  Widget build(BuildContext context) {
    return Container(
        color: Theme.of(context).backgroundColor,
      child: FutureBuilder(
        future: getUser(),
        builder: (context,snapshot){
          if(snapshot.hasData){
            user=snapshot.data;
            print("******************inside ***************");
            print("_switches[0] = "+_switches[0].toString());
            print("_switches[1] = "+_switches[1].toString());
            print("_switches[2] = "+_switches[2].toString());
            print("_switches[3] = "+_switches[3].toString());
            print("*********************************");

          }else{print("error = "+ snapshot.hasError.toString() +" is : "+snapshot.error.toString());}
              if(user!=null) {
                _switches[0] =
                (user.darkMode != null && user.darkMode == "Dark")
                    ? true
                    : false;
                _switches[1] =
                (user.passWord != null && user.passWord.isNotEmpty)
                    ? true
                    : false;
                _switches[2] = (user.hideGoal != null && user.hideGoal == "yes")
                    ? true
                    : false;
                _switches[3] =
                (user.linkAgenda != null && user.linkAgenda != "none")
                    ? true
                    : false;
              }

          return Container(
            padding: EdgeInsets.all(10),
            child: ListView(
              children: [
                SwitchListTile(
                  activeColor: Colors.blue,
                  inactiveThumbColor: Colors.grey,
                  inactiveTrackColor: Colors.grey,
                  activeTrackColor: Colors.blue,
                  title:  Text('Dark mode',style: TextStyle(color: Theme.of(context).floatingActionButtonTheme.focusColor)),
                  value: _switches[0],
                  onChanged: (bool value) async{

                   await ProviderClass().setAppMode(value, user);
                   setState(() {
                     _switches[0] = value;
                   });

                  },
                  secondary:  Icon(Icons.dark_mode_outlined,color: Theme.of(context).floatingActionButtonTheme.focusColor),
                ),
                SwitchListTile(
                  activeColor: Colors.blue,
                  inactiveThumbColor: Colors.grey,
                  inactiveTrackColor: Colors.grey,
                  activeTrackColor: Colors.blue,
                  title:  Text('Password for app',style: TextStyle(color: Theme.of(context).floatingActionButtonTheme.focusColor)),

                  value: _switches[1],
                  onChanged: (bool value) async{
                    _switches[1] = value;
                    if(value){
                      return await showDialogToAddPassword(context,"add");
                    }else{
                      return await showDialogToAddPassword(context,"remove");
                    }

                  },
                  secondary:  Icon(Icons.lock,color: Theme.of(context).floatingActionButtonTheme.focusColor),
                ),
                (user !=null && user.passWord!=null&&user.passWord.isNotEmpty)? SwitchListTile(
                  activeColor: Colors.blue,
                  inactiveThumbColor: Colors.grey,
                  inactiveTrackColor: Colors.grey,
                  activeTrackColor: Colors.blue,
                  title:  Text('Password for goal',style: TextStyle(color: Theme.of(context).floatingActionButtonTheme.focusColor)),

                  value: _switches[2],
                  onChanged: (bool value) async{

                    if(!value){return await showDialogToHideGoals(context);}else{
                      user.hideGoal="yes";
                      await DBProvider.db.updateUser(user);
                      setState(() {_switches[2] = value;});
                    }

                  },
                  secondary:  Icon(Icons.visibility_off,color: Theme.of(context).floatingActionButtonTheme.focusColor),
                ):Container(),
                ListTile(

                  title: (user!=null && user.linkAgenda!="none")? Text("Change Link of google Calendar",style: TextStyle(color: Theme.of(context).floatingActionButtonTheme.focusColor)):
                  Text('Add Link of google Calendar',style: TextStyle(color: Theme.of(context).floatingActionButtonTheme.focusColor)),
                  leading:  Icon(Icons.calendar_today,color: Theme.of(context).floatingActionButtonTheme.focusColor),
                  trailing:  IconButton(
                        onPressed: ()async{
                          String text = (user !=null && user.linkAgenda!="none")?"change":"add";
                          return await showDialogToAddLink(context,text);
                          },
                      padding: EdgeInsets.all(0),
                      icon:(user !=null && user.linkAgenda!="none")?Icon(Icons.change_circle,color: Theme.of(context).floatingActionButtonTheme.focusColor): Icon(Icons.add_circle,color: Theme.of(context).floatingActionButtonTheme.focusColor)),
                ),
              ],
            ),
          );
        },
      ),


    );
  }
}
