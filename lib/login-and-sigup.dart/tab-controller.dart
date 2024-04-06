import 'package:flutter/material.dart';
import 'package:lms/const/theme.dart';
import 'package:lms/login-and-sigup.dart/login-screen.dart';
import 'package:lms/login-and-sigup.dart/register-screen.dart';

class TabControllerScreen extends StatefulWidget {
  const TabControllerScreen({super.key});

  @override
  State<TabControllerScreen> createState() => _TabControllerScreenState();
  // void updateBl(String value) {
  //   TabControllerScreen state = const TabControllerScreen();
  //   state.updateBl(value);

  // }
}

class _TabControllerScreenState extends State<TabControllerScreen> {
  String userIdSharedPref = '';
  @override
  void initState() {
    // updateBl('');
    super.initState();
    // loadBl();
  }

  // Future<void> loadBl() async {
  //   final SharedPreferences prefs = await SharedPreferences.getInstance();
  //   setState(() {
  //     userIdSharedPref = prefs.getString('userId') ??
  //         ''; // Load the value from storage or use false if not found
  //   });
  //   print('user id with shared pref ${userIdSharedPref}');
  // }

  // Future<void> updateBl(String value) async {
  //   final SharedPreferences prefs = await SharedPreferences.getInstance();
  //   await prefs.setString('userId', value); // Save the value to SharedPreferences
  //   setState(() {
  //     userIdSharedPref = value;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: getHeight(context) * 0.3,
          title: Container(
            alignment: Alignment.center,
            height: 250,
            child: Image.asset(
              'assets/app-logo/lmslogog.png',
              fit: BoxFit.contain,
            ),
          ),
          bottom: const TabBar(
            tabs: [
              Tab(
                child: Text('Login'),
              ),
              Tab(
                child: Text('Register'),
              ),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            LoginScreen(),
            RegisterScreen(),
          ],
        ),
      ),
    );
  }
}
