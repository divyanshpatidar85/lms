import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class hello extends StatefulWidget {
  final type;
  const hello({super.key, this.type});

  @override
  State<hello> createState() => _helloState();
}

class _helloState extends State<hello> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text(widget.type),),
    );
  }
}