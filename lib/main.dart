import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:todolist/DataBase/database.dart';
import 'package:todolist/Models/Data/TodayTask.dart';
import 'package:todolist/Models/Data/task_model.dart';
import 'package:todolist/Models/ProvidersClass/goal_provider.dart';
import 'package:todolist/Models/ProvidersClass/settings_provider.dart';
import 'package:todolist/Models/ProvidersClass/task_button.dart';
import 'package:todolist/Models/notification_service.dart';
import 'package:todolist/Models/ProvidersClass/provider_class.dart';
import 'package:todolist/Models/ProvidersClass/provider_home_class.dart';
import 'package:workmanager/workmanager.dart';
import 'View/home_view.dart';

void callbackDispatcher() async{
  Workmanager().executeTask((taskName, inputData) async {

    print(inputData["data"]);
    switch(inputData["data"]){
      case "init":
        DateTime now = DateTime.now();
        String date = now.day.toString()+"/"+now.month.toString()+"/"+now.year.toString();
        List<Task> taskToday = await DBProvider.db.getTimeByDateSelected(date);
        List<Task> taskreminder = await DBProvider.db.getTimeByDateSelected(date);
        TodayTask task;
        if(taskToday!=null && taskToday.isNotEmpty){
          for(int i=0; i<taskToday.length;i++){
            task = new TodayTask(
              idTask: taskToday[i].id,
              task: taskToday[i].task,
              category: taskToday[i].category,
              frequency: taskToday[i].frequency,
              goal: taskToday[i].goal,
              status: taskToday[i].status,
              note: taskToday[i].note,
              date: taskToday[i].date,
              hour: int.parse(taskToday[i].time.split(":")[0]),
              minute: int.parse(taskToday[i].time.split(":")[1]),
              inMinute: (int.parse(taskToday[i].time.split(":")[0])*60+int.parse(taskToday[i].time.split(":")[1]))
            );
            await DBProvider.db.newTodayTask(task);
          }
        }
        if(taskreminder!=null && taskreminder.isNotEmpty){
          for(int i=0; i<taskreminder.length;i++){
            task = new TodayTask(
                idTask: taskreminder[i].id,
                task: taskreminder[i].task,
                category: taskreminder[i].category,
                frequency: taskreminder[i].frequency,
                goal: taskreminder[i].goal,
                status: taskreminder[i].status,
                note: taskreminder[i].note,
                date: taskreminder[i].dateReminder,
                hour: int.parse(taskreminder[i].timeReminder.split(":")[0]),
                minute: int.parse(taskreminder[i].timeReminder.split(":")[1]),
                inMinute: (int.parse(taskreminder[i].timeReminder.split(":")[0])*60+int.parse(taskreminder[i].timeReminder.split(":")[1]))
            );
            await DBProvider.db.newTodayTask(task);
          }
        }
        WidgetsFlutterBinding.ensureInitialized();
        await Workmanager().initialize(callbackDispatcher);
        await Workmanager().registerOneOffTask(
            "tomorrow"+now.toString(), "test2",
            inputData: {"data": "init","title":" ","body":" ","time":" "},
            initialDelay: Duration(minutes: ((24*60)-(now.hour*60+now.minute)))
        );
        WidgetsFlutterBinding.ensureInitialized();
        await Workmanager().initialize(callbackDispatcher);
        await Workmanager().registerOneOffTask(
            "today"+now.toString(), "test2",
            inputData: {"data": "notNow","title":" ","body":" ","time":" "},
            initialDelay: Duration(seconds: 1)
        );
        break;
      case "itTime" :
        LocalNotification.Initializer();
        LocalNotification.ShowOneTimeNotification(DateTime.now(),inputData["title"],inputData["body"],inputData["time"]);
        WidgetsFlutterBinding.ensureInitialized();
        await Workmanager().initialize(callbackDispatcher);
        await Workmanager().registerOneOffTask(
            "today"+DateTime.now().toString(), "test",
            inputData: {"data": "notNow","title":" ","body":" ","time":" "},
            initialDelay: Duration(minutes: 1)
        );
        return Future.value(true);
        break;


      default : //"notNow"
        DateTime now = DateTime.now();
        int inMinuteNow = now.hour*60+now.minute;
        TodayTask picker;
        int delay ;
        String date = now.day.toString()+"/"+now.month.toString()+"/"+now.year.toString();
        List<TodayTask> tdt = await DBProvider.db.getAllTodayTask(date);
        print("hello");
        print(tdt);
        if(tdt!=null && tdt.isNotEmpty) {
          print(tdt);
          for(int i=0; i<tdt.length;i++) {
            if (inMinuteNow <= tdt[i].inMinute){
              picker = tdt[i];
              break;
            }else{
              await DBProvider.db.deleteTodayTask(tdt[i].id);

            }

          }

          if(picker != null) {
            print(picker.hour.toString()+":"+picker.minute.toString());

            if (picker.inMinute == inMinuteNow) {
              WidgetsFlutterBinding.ensureInitialized();
              await Workmanager().initialize(callbackDispatcher);
              await Workmanager().registerOneOffTask(
                  picker.id.toString(), "test2",
                  inputData: {"data": "itTime","title":picker.task,"body":(picker.note!=null)?picker.note:"click to show details...","time":picker.date},
                  initialDelay: Duration(seconds: 1)
              );
            } else {
              delay = picker.inMinute - inMinuteNow;
              WidgetsFlutterBinding.ensureInitialized();
              await Workmanager().initialize(callbackDispatcher);
              await Workmanager().registerOneOffTask(
                  picker.id.toString(), "test",
                  inputData: {"data": "itTime","title":picker.task,"body":(picker.note!=null)?picker.note:"click to show details...","time":picker.date},
                  initialDelay: Duration(minutes: delay)
              );
            }
          }
        }
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
      inputData: {"data": "init","title":" ","body":" ","time":" "},
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
