import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todolist/Models/Data/theme_data.dart';
import 'package:todolist/Models/Data/work_manager.dart';
import 'package:todolist/Models/ProvidersClass/goal_provider.dart';
import 'package:todolist/Models/ProvidersClass/login_provider.dart';
import 'package:todolist/Models/ProvidersClass/new_task_provider.dart';
import 'package:todolist/Models/ProvidersClass/settings_provider.dart';
import 'package:todolist/Models/ProvidersClass/task_list_provider.dart';
import 'package:todolist/Models/ProvidersClass/provider_class.dart';
import 'package:todolist/Models/ProvidersClass/provider_home_class.dart';
import 'package:todolist/View/login.dart';
import 'package:workmanager/workmanager.dart';


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
        providers: [ //NewTaskProvider
                        ChangeNotifierProvider<ProviderClass>(
                          create: (context) => ProviderClass(), ),
                        ChangeNotifierProvider<SwitchViews>(
                          create: (context) => SwitchViews(), ),
                        ChangeNotifierProvider<ToDoListBodyProvider>(
                          create: (context) => ToDoListBodyProvider(), ),
                        ChangeNotifierProvider<SettingsProvider>(
                          create: (context) => SettingsProvider(), ),
                        ChangeNotifierProvider<GoalProvider>(
                          create: (context) => GoalProvider(), ),
                        ChangeNotifierProvider<NewTaskProvider>(
                          create: (context) => NewTaskProvider(), ),
                        ChangeNotifierProvider<LogInProvider>(
                          create: (context) => LogInProvider(), ),
        ],
        child: Builder(
        builder: (context)
              {
                return Consumer<ProviderClass>(
                    builder: (context, value, child) {
                      return MaterialApp(
                                debugShowCheckedModeBanner: false,
                                title: 'ToDo',
                                color: Theme.of(context).backgroundColor,
                                theme: ThemeDataClass().lightMode(),
                                darkTheme: ThemeDataClass().darkMode(),
                                themeMode:  value.themeMode,
                                home: LogIn(),
                              );});
              }
              )
    );
  }
}
