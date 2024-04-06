
import 'package:flutter/material.dart';
import 'package:lms/ScreenCommonBetweenAllUser/book-request-fac-student.dart';

import 'package:lms/const/theme.dart';

class RequestBookByUser extends StatefulWidget {
  const RequestBookByUser({super.key});

  @override
  State<RequestBookByUser> createState() => _RequestBookByUserState();
}

class _RequestBookByUserState extends State<RequestBookByUser> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height:400,
      width:getWidth(context)*0.9,
      color:red,
      child: ListView.builder(itemBuilder:(BuildContext context, index){
        return const BookRequestConfermation();
      },
      itemCount:5,),
    );
  }
}