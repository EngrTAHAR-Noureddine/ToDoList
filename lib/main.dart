import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:todolist/Models/Data/work_manager.dart';
import 'package:todolist/Models/ProvidersClass/goal_provider.dart';
import 'package:todolist/Models/ProvidersClass/notification_provider.dart';
import 'package:todolist/Models/ProvidersClass/settings_provider.dart';
import 'package:todolist/Models/ProvidersClass/task_button.dart';
import 'package:todolist/Models/ProvidersClass/provider_class.dart';
import 'package:todolist/Models/ProvidersClass/provider_home_class.dart';
import 'package:workmanager/workmanager.dart';

import 'View/home_view.dart';

void callbackDispatcher() async{
  Workmanager().executeTask((taskName, inputData) async {

    print(inputData["data"]);
    switch(inputData["data"]){
      case "init":
        await WorkManagerProvider().initialWork();
        break;

      case "itTime" :
        await WorkManagerProvider().itTimeToWork(inputData);
        return Future.value(true);
        break;

      default : //"notNow"
        await WorkManagerProvider().notNowToWork();
        break;

    }


    return Future.value(true);
  });

}

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Workmanager().initialize(callbackDispatcher);
  await Workmanager().registerOneOffTask(
      "1", "task",
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
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
                        ChangeNotifierProvider<ProviderClass>(
                          create: (context) => ProviderClass(), ),
                        ChangeNotifierProvider<SwitchViews>(
                          create: (context) => SwitchViews(), ),
                        ChangeNotifierProvider<TaskButton>(
                          create: (context) => TaskButton(), ),
                        ChangeNotifierProvider<SettingsProvider>(
                          create: (context) => SettingsProvider(), ),
                        ChangeNotifierProvider<GoalProvider>(
                          create: (context) => GoalProvider(), ),
                          ChangeNotifierProvider<NotificationProvider>(
                            create: (context) => NotificationProvider(), ),
        ],
        child: Builder(
        builder: (context)
              {
                return Consumer<ProviderClass>(
                    builder: (context, value, child) {
                      return MaterialApp(
                                debugShowCheckedModeBanner: false,
                                title: 'ToDoList',
                                color: Theme.of(context).backgroundColor,
                                theme: ThemeData(
                                  primaryColor: Color(0xFF2643C4),
                                  //1
                                  primaryColorLight: Colors.white,
                                  //2
                                  primaryColorDark: Color(0xFFE6FFFB),
                                  //3
                                  backgroundColor: Color(0xFFF4F6FD),
                                  //4
                                  splashColor: Colors.white,
                                  //5
                                  errorColor: Color(0xFFFF6272),
                                  //6
                                  cardColor: Colors.white,
                                  //7
                                  accentColor: Colors.white,
                                  //8
                                  buttonColor: Color(0xFFE6FFFB),
                                  //9
                                  focusColor: Color(0xFF979DB0),
                                  //10

                                  floatingActionButtonTheme: FloatingActionButtonThemeData(
                                    backgroundColor: Color(0xFF000000), //11
                                    focusColor: Color(0xFF020417), //12
                                      foregroundColor:Color(0xFF2643C4),
                                    hoverColor: Color(0xFFF4F6FD),

                                  ),
                                  canvasColor: Color(0xFFF53948),
                                  //13
                                  dividerColor: Color(0xFF9D9AFF),
                                  //14
                                  bottomAppBarColor: Color(0xFF707070),
                                  //15


                                  primaryColorBrightness: Brightness.light,


                                ),
                                darkTheme: ThemeData(
                                  primaryColor: Color(0xFF93A1E2),
                                  //1
                                  primaryColorLight: Color(0x17FFFFFF),
                                  //2
                                  primaryColorDark: Color(0xFF121212),
                                  //3
                                  backgroundColor: Color(0xFF121212),
                                  //4
                                  //primarySwatch: Colors.black, //5
                                  splashColor: Colors.black,
                                  errorColor: Color(0xFFFF4A5D),
                                  //6
                                  cardColor: Color(0xFF121212),
                                  //7
                                  accentColor: Color(0x1FFFFFFF),
                                  //8
                                  buttonColor: Color(0x12FFFFFF),
                                  //9
                                  focusColor: Color(0xFFE6FFFB),
                                  //10

                                  floatingActionButtonTheme: FloatingActionButtonThemeData(
                                    backgroundColor: Color(0xFFADADAD), //11
                                    focusColor: Color(0xDEFFFFFF), //12
                                    hoverColor: Color(0xFF262626),
                                    foregroundColor: Color(0xFF2643C4)

                                  ),
                                  canvasColor: Color(0xFFF99FA6),
                                  //13
                                  dividerColor: Color(0xFFB5B3FF),
                                  //14
                                  bottomAppBarColor: Color(0x99FFFFFF),
                                  //15


                                  primaryColorBrightness: Brightness.dark,


                                ),
                                themeMode:  value.themeMode,
                                home: Home(),
                              );});
              }
              )
    );
  }
}
