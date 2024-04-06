import 'package:flutter_local_notifications/flutter_local_notifications.dart' ;
import 'package:rxdart/rxdart.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class LocalNotifications {
  static final FlutterLocalNotificationsPlugin
      _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  static final onClickNotification = BehaviorSubject<String>();

// on tap on any notification
  static void onNotificationTap(NotificationResponse notificationResponse) {
    onClickNotification.add(notificationResponse.payload!);
  }

// initialize the local notifications
  static Future init() async {
    // initialise the plugin. app_icon needs to be a added as a drawable resource to the Android head project
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    final DarwinInitializationSettings initializationSettingsDarwin =
        DarwinInitializationSettings(
      onDidReceiveLocalNotification: (id, title, body, payload) =>null,
    );
    final LinuxInitializationSettings initializationSettingsLinux =
        LinuxInitializationSettings(defaultActionName: 'Open notification');
    final InitializationSettings initializationSettings =
        InitializationSettings(
            android: initializationSettingsAndroid,
            iOS: initializationSettingsDarwin,
            linux: initializationSettingsLinux);
    _flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onDidReceiveNotificationResponse: onNotificationTap,
        onDidReceiveBackgroundNotificationResponse: onNotificationTap);
  }

  // show a simple notification
  static Future showSimpleNotification({
    required String title,
    required String body,
    required String payload,
  }) async {
    const AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails('your channel id', 'your channel name',
            channelDescription: 'your channel description',
            importance: Importance.max,
            priority: Priority.high,
            ticker: 'ticker');
    const NotificationDetails notificationDetails =
        NotificationDetails(android: androidNotificationDetails);
    await _flutterLocalNotificationsPlugin
        .show(0, title, body, notificationDetails, payload: payload);
  }

  // to show periodic notification at regular interval
  static Future showPeriodicNotifications({
    required String title,
    required String body,
    required String payload,
  }) async {
    const AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails('channel 2', 'your channel name',
            channelDescription: 'your channel description',
            importance: Importance.max,
            priority: Priority.high,
            ticker: 'ticker');
    const NotificationDetails notificationDetails =
        NotificationDetails(android: androidNotificationDetails);
    await _flutterLocalNotificationsPlugin.periodicallyShow(
        1, title, body, RepeatInterval.everyMinute, notificationDetails,
        androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
        payload: payload);
  }

  // to schedule a local notification
  static Future showScheduleNotification({
    required int id,
    required String title,
    required String body,
    required String payload,
    required DateTime dueDate,
  }) async {
     // for (DateTime date = startdateTime; date.isBefore(
    //    enddateTime); date = date.add(Duration(minutes: 1))) {
      // Create the notification date-time
      // print("date is time pass here now what to doooooooooooooooooooo $dueDate");
      tz.initializeTimeZones();
      dueDate=dueDate.add(Duration(hours:10)).add(Duration(minutes:30));
      //  print("date is time pass here now what to doooooooooooooooooooo ${dueDate.day}    ${DateTime.now().day}");
      if(true){
                 final tz.TZDateTime scheduledDate = tz.TZDateTime.from(
          dueDate,
          tz.local
      );

       final tz.TZDateTime scheduledDate2 = tz.TZDateTime.from(
          DateTime.now(),
          tz.local
      );
       print("notification      $scheduledDate");
       print("schedule 2    schedule2 $scheduledDate2");


      await _flutterLocalNotificationsPlugin.zonedSchedule(
          id,
          title,
          body,
          scheduledDate,
          const NotificationDetails(
              android: AndroidNotificationDetails(
                  'channel 3', 'your channel name',
                  channelDescription: 'your channel description',
                  importance: Importance.max,
                  priority: Priority.high,
                  ticker: 'ticker')),
          androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
          uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
          payload: payload);
      }
     

      // print("date time is here now what to do ${scheduledDate}");
      

  }
  

  

  // close a specific channel notification
  static Future cancel(int id) async {
    await _flutterLocalNotificationsPlugin.cancel(id);
  }

  // close all the notifications available
  static Future cancelAll() async {
    await _flutterLocalNotificationsPlugin.cancelAll();
  }
}
