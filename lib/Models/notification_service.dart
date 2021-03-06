
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:todolist/Models/ProvidersClass/provider_class.dart';

class LocalNotification {
  static FlutterLocalNotificationsPlugin flutterNotificationPlugin;
  static AndroidNotificationDetails androidSettings;



  static Initializer() {

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

        ProviderClass().setState();
  }

  static ShowOneTimeNotification(DateTime scheduledDate,String title, String body, String time) async {
    var notificationDetails = NotificationDetails(android: androidSettings);
    await flutterNotificationPlugin.schedule(1,body+" "+time,
        "Task : "+title, scheduledDate, notificationDetails,
        androidAllowWhileIdle: true);
  }
}
