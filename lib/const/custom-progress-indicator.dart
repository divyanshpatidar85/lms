import 'package:flutter/material.dart';
import 'package:lms/const/theme.dart';

class CustomIndicator extends StatelessWidget {
  const CustomIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color:white,
      child:const Center(
      
      child: CircularProgressIndicator(color:red,)),
    );
  }
}