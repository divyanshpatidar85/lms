// ignore_for_file: non_constant_identifier_names

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:lms/admin/adminTabController.dart';
import 'package:lms/api/firebase-api.dart';
import 'package:lms/backend/bookcatalog.dart';
import 'package:lms/backend/due-to-book-info.dart';
import 'package:lms/const/custom-progress-indicator.dart';

// import 'package:lms/const/overlays.dart';
import 'package:lms/const/splashscreen.dart';
import 'package:lms/const/theme.dart';
import 'package:lms/faculty/faculty-tab-controller.dart';
import 'package:lms/login-and-sigup.dart/tab-controller.dart';
import 'package:lms/student/student-tab-controller.dart';
import 'package:notification_permissions/notification_permissions.dart';
import 'package:shared_preferences/shared_preferences.dart';

final navigatorKey = GlobalKey<NavigatorState>();
// FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
//     FlutterLocalNotificationsPlugin();
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (kIsWeb) {
    await Firebase.initializeApp(
        options: const FirebaseOptions(
            apiKey: "AIzaSyDFtsZIVS4asgY3SfQmuWPRRoDCUNS_EUA",
            appId: "1:161776174529:web:4e51a68603beacf1425b40",
            messagingSenderId: "161776174529",
            storageBucket: "major-lms.appspot.com",
            projectId: "major-lms"));
  } else {
    await Firebase.initializeApp();
  }

  await LocalNotifications.init();
  // var initialNotification =
  // await flutterLocalNotificationsPlugin.getNotificationAppLaunchDetails();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Library Managment System',
      debugShowCheckedModeBanner: false,
      theme: Themes.light,
      home: const SplashSceen(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with WidgetsBindingObserver {
  String? userType;
  List? Data;
  late Future<String> permissionStatusFuture;

  var permGranted = "granted";
  var permDenied = "denied";
  var permUnknown = "unknown";
  var permProvisional = "provisional";
  @override
  void initState() {
    super.initState();
    getData();
    // permissionStatusFuture = getCheckNotificationPermStatus();
    // WidgetsBinding.instance.addObserver(this);
    // NotificationPermissions.requestNotificationPermissions(
    //         iosSettings: const NotificationSettingsIos(
    //             sound: true, badge: true, alert: true))
    //     .then((_) {
    //   // when finished, check the permission status
    //   setState(() {
    //     permissionStatusFuture = getCheckNotificationPermStatus();
    //   });
    // });
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      setState(() {
        permissionStatusFuture = getCheckNotificationPermStatus();
      });
    }
  }

  /// Checks the notification permission status
  Future<String> getCheckNotificationPermStatus() {
    return NotificationPermissions.getNotificationPermissionStatus()
        .then((status) {
      switch (status) {
        case PermissionStatus.denied:
          return permDenied;
        case PermissionStatus.granted:
          return permGranted;
        case PermissionStatus.unknown:
          return permUnknown;
        case PermissionStatus.provisional:
          return permProvisional;
        default:
          return permDenied;
      }
    });
  }

  void getData() async {
    Data = await BookCatalog().getCatalogData();
    SharedPreferences pref = await SharedPreferences.getInstance();
    // print("i am called iiiiiiiiiiiiiiiiiiii");
    await DueBookInformation().dueBookInformationAllInfomration();
    setState(() {
      userType = pref.getString('userType');
      // print("user type is hare $userType");
    });
    // print(Data.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: StreamBuilder(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.active) {
                if (snapshot.hasData) {
                  if (userType == 'Student') {
                    return const StudentTabController(
                      userType: 'Student',
                    );
                  } else if (userType == 'Faculty') {
                    return const FacultyTabController(userType: 'Faculty');
                  } else if (userType == 'Admin') {
                    return const AdminTabControllerScreen();
                  } else if (userType == null) {
                   
                    return const CustomIndicator();
                  }
                } else {
                  Text('${snapshot.error}');
                }
              } else if (snapshot.connectionState == ConnectionState.waiting) {
                
                return const CustomIndicator();
              }

              return const TabControllerScreen();
            }));
  
  }
}
