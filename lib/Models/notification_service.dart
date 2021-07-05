import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class LocalNotification {
  static FlutterLocalNotificationsPlugin flutterNotificationPlugin;
  static AndroidNotificationDetails androidSettings;



  static Initializer() {
    /*
    *   var initializationSettingsAndroid =
  new AndroidInitializationSettings('app_icon');
  *
  var initializationSettingsIOS = new IOSInitializationSettings();
  var initializationSettings = new InitializationSettings(android: initializationSettingsAndroid, iOS: initializationSettingsIOS);
  flutterLocalNotificationsPlugin = new FlutterLocalNotificationsPlugin();
  flutterLocalNotificationsPlugin.initialize(initializationSettings,
      onSelectNotification: onSelectNotification);
    *
    * */

    flutterNotificationPlugin = FlutterLocalNotificationsPlugin();
    androidSettings = AndroidNotificationDetails(
        "111", "Background_task_Channel", "Channel to test background task",
        importance: Importance.high, priority: Priority.max);
    var androidInitialization = AndroidInitializationSettings('app_icon');
    var initializationSettings =
    InitializationSettings(android: androidInitialization);
    flutterNotificationPlugin.initialize(initializationSettings,
        onSelectNotification: onNotificationSelect);
  }

  static Future<dynamic> onNotificationSelect(String payload) async {


        return NewScreen(
          payload: payload,
        );


  }

  static ShowOneTimeNotification(DateTime scheduledDate,String title, String body, String time) async {
    var notificationDetails = NotificationDetails(android: androidSettings);
    await flutterNotificationPlugin.schedule(1, "Task : "+title,
        time+":"+body, scheduledDate, notificationDetails,
        androidAllowWhileIdle: true);
  }
}

class NewScreen extends StatelessWidget {
  String payload;

  NewScreen({
    @required this.payload,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      appBar: AppBar(
        title: Text(payload),

      ),
      body: Container(
        color: Colors.red,
      ),
    );
  }
}