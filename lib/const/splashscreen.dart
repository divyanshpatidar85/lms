import 'package:flutter/material.dart';
import 'package:lms/admin/adminTabController.dart';
import 'package:lms/backend/bookcatalog.dart';
import 'package:lms/const/pi-chart.dart';
import 'package:lms/faculty/faculty-tab-controller.dart';

import 'package:lms/login-and-sigup.dart/login-screen.dart';
// import 'package:lms/const/pi-chart.dart';
import 'package:lms/login-and-sigup.dart/tab-controller.dart';
import 'package:lms/main.dart';
import 'package:lms/student/student-tab-controller.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:lms/main.dart';

class SplashSceen extends StatefulWidget {
  const SplashSceen({super.key});

  @override
  State<SplashSceen> createState() => _SplashSceenState();
}

class _SplashSceenState extends State<SplashSceen> {
  List<int> Data = [0, 0];
  String userType = '';
  @override
  void initState() {
    super.initState();
    getData();
    Future.delayed(const Duration(seconds: 2)).whenComplete(() {
      
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const MyHomePage(title: '',)),
          (Route<dynamic> route) => false,
        );
      
    });
  }

  void getData() async {
    Data = await BookCatalog().getCatalogData();
    SharedPreferences _pref = await SharedPreferences.getInstance();
    userType = _pref.getString('userType')!;
    print(Data.toString());
  }

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('LMS'),
    );
  }
}
