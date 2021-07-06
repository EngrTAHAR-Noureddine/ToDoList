import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'package:todolist/DataBase/database.dart';
import 'package:todolist/Models/ProvidersClass/provider_class.dart';
import 'package:todolist/Models/ProvidersClass/settings_provider.dart';

class SettingsModel extends StatelessWidget {
  List<bool> _switches =[false,false,false,false];
  @override
  Widget build(BuildContext context) {
    return Consumer<SettingsProvider>(
        builder: (context, value, child){
          return Container(
            color: Theme
                .of(context)
                .backgroundColor,
            child: FutureBuilder(
              future: SettingsProvider().getUser(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  SettingsProvider().user = snapshot.data;
                } else {
                  print("error = " + snapshot.hasError.toString() + " is : " +
                      snapshot.error.toString());
                }
                if (SettingsProvider().user != null) {
                  _switches[0] =
                  (SettingsProvider().user.darkMode != null && SettingsProvider().user.darkMode == "Dark")
                      ? true
                      : false;
                  _switches[1] =
                  (SettingsProvider().user.passWord != null && SettingsProvider().user.passWord.isNotEmpty)
                      ? true
                      : false;
                  _switches[2] = (SettingsProvider().user.hideGoal != null && SettingsProvider().user.hideGoal == "yes")
                      ? true
                      : false;
                  _switches[3] =
                  (SettingsProvider().user.linkAgenda != null && SettingsProvider().user.linkAgenda != "none")
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
                        title: Text('Dark mode', style: TextStyle(color: Theme
                            .of(context)
                            .floatingActionButtonTheme
                            .focusColor)),
                        value: _switches[0],
                        onChanged: (bool value) async {
                          await ProviderClass().setAppMode(value, SettingsProvider().user);

                            _switches[0] = value;
                          SettingsProvider().setState();
                        },
                        secondary: Icon(Icons.dark_mode_outlined, color: Theme
                            .of(context)
                            .floatingActionButtonTheme
                            .focusColor),
                      ),
                      SwitchListTile(
                        activeColor: Colors.blue,
                        inactiveThumbColor: Colors.grey,
                        inactiveTrackColor: Colors.grey,
                        activeTrackColor: Colors.blue,
                        title: Text(
                            'Password for app', style: TextStyle(color: Theme
                            .of(context)
                            .floatingActionButtonTheme
                            .focusColor)),

                        value: _switches[1],
                        onChanged: (bool value) async {
                          _switches[1] = value;
                          if (value) {
                            return await SettingsProvider().showDialogToAddPassword(context, "add");
                          } else {
                            return await SettingsProvider().showDialogToAddPassword(context, "remove");
                          }
                        },
                        secondary: Icon(Icons.lock, color: Theme
                            .of(context)
                            .floatingActionButtonTheme
                            .focusColor),
                      ),
                      (SettingsProvider().user != null && SettingsProvider().user.passWord != null &&
                          SettingsProvider().user.passWord.isNotEmpty) ? SwitchListTile(
                        activeColor: Colors.blue,
                        inactiveThumbColor: Colors.grey,
                        inactiveTrackColor: Colors.grey,
                        activeTrackColor: Colors.blue,
                        title: Text(
                            'Password for goal', style: TextStyle(color: Theme
                            .of(context)
                            .floatingActionButtonTheme
                            .focusColor)),

                        value: _switches[2],
                        onChanged: (bool value) async {
                          if (!value) {
                            return await SettingsProvider().showDialogToHideGoals(context);
                          } else {
                            SettingsProvider().user.hideGoal = "yes";
                            await DBProvider.db.updateUser(SettingsProvider().user);

                              _switches[2] = value;
                              SettingsProvider().setState();
                          }
                        },
                        secondary: Icon(Icons.visibility_off, color: Theme
                            .of(context)
                            .floatingActionButtonTheme
                            .focusColor),
                      ) : Container(),
                      ListTile(

                        title: (SettingsProvider().user != null && SettingsProvider().user.linkAgenda != "none") ? Text(
                            "Change Link of google Calendar",
                            style: TextStyle(color: Theme
                                .of(context)
                                .floatingActionButtonTheme
                                .focusColor)) :
                        Text('Add Link of google Calendar',
                            style: TextStyle(color: Theme
                                .of(context)
                                .floatingActionButtonTheme
                                .focusColor)),
                        leading: Icon(Icons.calendar_today, color: Theme
                            .of(context)
                            .floatingActionButtonTheme
                            .focusColor),
                        trailing: IconButton(
                            onPressed: () async {
                              String text = (SettingsProvider().user != null && SettingsProvider().user.linkAgenda !=
                                  "none") ? "change" : "add";
                              return await SettingsProvider().showDialogToAddLink(context, text);
                            },
                            padding: EdgeInsets.all(0),
                            icon: (SettingsProvider().user != null && SettingsProvider().user.linkAgenda != "none")
                                ? Icon(Icons.change_circle, color: Theme
                                .of(context)
                                .floatingActionButtonTheme
                                .focusColor)
                                : Icon(Icons.add_circle, color: Theme
                                .of(context)
                                .floatingActionButtonTheme
                                .focusColor)),
                      ),
                    ],
                  ),
                );
              },
            ),


          );
        });
  }
}




/*
class SettingsModel extends StatefulWidget {
  const SettingsModel({Key key}) : super(key: key);

  @override
  _SettingsModelState createState() => _SettingsModelState();
}

class _SettingsModelState extends State<SettingsModel> {



  List<bool> _switches =[false,false,false,false];
  @override
  Widget build(BuildContext context) {
    return Consumer<SettingsProvider>(
        builder: (context, value, child){
          return Container(
            color: Theme
                .of(context)
                .backgroundColor,
            child: FutureBuilder(
              future: SettingsProvider().getUser(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  SettingsProvider().user = snapshot.data;
                } else {
                  print("error = " + snapshot.hasError.toString() + " is : " +
                      snapshot.error.toString());
                }
                if (SettingsProvider().user != null) {
                  _switches[0] =
                  (SettingsProvider().user.darkMode != null && SettingsProvider().user.darkMode == "Dark")
                      ? true
                      : false;
                  _switches[1] =
                  (SettingsProvider().user.passWord != null && SettingsProvider().user.passWord.isNotEmpty)
                      ? true
                      : false;
                  _switches[2] = (SettingsProvider().user.hideGoal != null && SettingsProvider().user.hideGoal == "yes")
                      ? true
                      : false;
                  _switches[3] =
                  (SettingsProvider().user.linkAgenda != null && SettingsProvider().user.linkAgenda != "none")
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
                        title: Text('Dark mode', style: TextStyle(color: Theme
                            .of(context)
                            .floatingActionButtonTheme
                            .focusColor)),
                        value: _switches[0],
                        onChanged: (bool value) async {
                          await ProviderClass().setAppMode(value, SettingsProvider().user);
                          setState(() {
                            _switches[0] = value;
                          });
                        },
                        secondary: Icon(Icons.dark_mode_outlined, color: Theme
                            .of(context)
                            .floatingActionButtonTheme
                            .focusColor),
                      ),
                      SwitchListTile(
                        activeColor: Colors.blue,
                        inactiveThumbColor: Colors.grey,
                        inactiveTrackColor: Colors.grey,
                        activeTrackColor: Colors.blue,
                        title: Text(
                            'Password for app', style: TextStyle(color: Theme
                            .of(context)
                            .floatingActionButtonTheme
                            .focusColor)),

                        value: _switches[1],
                        onChanged: (bool value) async {
                          _switches[1] = value;
                          if (value) {
                            return await SettingsProvider().showDialogToAddPassword(context, "add");
                          } else {
                            return await SettingsProvider().showDialogToAddPassword(context, "remove");
                          }
                        },
                        secondary: Icon(Icons.lock, color: Theme
                            .of(context)
                            .floatingActionButtonTheme
                            .focusColor),
                      ),
                      (SettingsProvider().user != null && SettingsProvider().user.passWord != null &&
                          SettingsProvider().user.passWord.isNotEmpty) ? SwitchListTile(
                        activeColor: Colors.blue,
                        inactiveThumbColor: Colors.grey,
                        inactiveTrackColor: Colors.grey,
                        activeTrackColor: Colors.blue,
                        title: Text(
                            'Password for goal', style: TextStyle(color: Theme
                            .of(context)
                            .floatingActionButtonTheme
                            .focusColor)),

                        value: _switches[2],
                        onChanged: (bool value) async {
                          if (!value) {
                            return await SettingsProvider().showDialogToHideGoals(context);
                          } else {
                            SettingsProvider().user.hideGoal = "yes";
                            await DBProvider.db.updateUser(SettingsProvider().user);
                            setState(() {
                              _switches[2] = value;
                            });
                          }
                        },
                        secondary: Icon(Icons.visibility_off, color: Theme
                            .of(context)
                            .floatingActionButtonTheme
                            .focusColor),
                      ) : Container(),
                      ListTile(

                        title: (SettingsProvider().user != null && SettingsProvider().user.linkAgenda != "none") ? Text(
                            "Change Link of google Calendar",
                            style: TextStyle(color: Theme
                                .of(context)
                                .floatingActionButtonTheme
                                .focusColor)) :
                        Text('Add Link of google Calendar',
                            style: TextStyle(color: Theme
                                .of(context)
                                .floatingActionButtonTheme
                                .focusColor)),
                        leading: Icon(Icons.calendar_today, color: Theme
                            .of(context)
                            .floatingActionButtonTheme
                            .focusColor),
                        trailing: IconButton(
                            onPressed: () async {
                              String text = (SettingsProvider().user != null && SettingsProvider().user.linkAgenda !=
                                  "none") ? "change" : "add";
                              return await SettingsProvider().showDialogToAddLink(context, text);
                            },
                            padding: EdgeInsets.all(0),
                            icon: (SettingsProvider().user != null && SettingsProvider().user.linkAgenda != "none")
                                ? Icon(Icons.change_circle, color: Theme
                                .of(context)
                                .floatingActionButtonTheme
                                .focusColor)
                                : Icon(Icons.add_circle, color: Theme
                                .of(context)
                                .floatingActionButtonTheme
                                .focusColor)),
                      ),
                    ],
                  ),
                );
              },
            ),


          );
        });
  }
}

 */