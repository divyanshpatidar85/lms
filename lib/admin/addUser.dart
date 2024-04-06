import 'package:flutter/material.dart';
import 'package:lms/const/custom-app-bar.dart';
import 'package:lms/const/theme.dart';
import 'package:lms/login-and-sigup.dart/register-screen.dart';

class AddUser extends StatefulWidget {
  const AddUser({super.key});

  @override
  State<AddUser> createState() => _AddUserState();
}

class _AddUserState extends State<AddUser> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        toolbarHeight:toolbarHeight,
        title:const CustomAppBar(title:'Add User', subtitle:'Good luck !!'),
      ),
      body:const RegisterScreen(),
    );
  }
}