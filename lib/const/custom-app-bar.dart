import 'package:flutter/material.dart';
import 'package:lms/const/theme.dart';


class CustomAppBar extends StatefulWidget {
  final String title;
  final String subtitle;
  
  final IconData screenIcon;
  const CustomAppBar(
      {super.key,
      required this.title,
      required this.subtitle,

      this.screenIcon = Icons.menu});

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();
}

// ignore: camel_case_types
class _CustomAppBarState extends State<CustomAppBar> {
  @override
  Widget build(BuildContext context) {
    var width = getWidth(context);
    return Padding(
      padding: EdgeInsets.only(top:15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        // crossAxisAlignment:CrossAxisAlignment.center,
        children: [
          Column(
            crossAxisAlignment:CrossAxisAlignment.start,
            children: [
              Text(widget.title,style:subHeadingStyle,),
              
              Text(widget.subtitle,style:headingStyle(context),),
            ],
          ),
          const SizedBox(width:10,),
          Icon(widget.screenIcon,size:50,color:red,)
          
        ],
      ),
    );
  }

  
}
