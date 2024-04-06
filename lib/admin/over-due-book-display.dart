import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lms/admin/display_user_info.dart';
import 'package:lms/backend/due-to-book-info.dart';
import 'package:lms/const/custom-app-bar.dart';
import 'package:lms/const/custom-progress-indicator.dart';
import 'package:lms/const/theme.dart';
import 'package:lms/student/student-home-screen.dart';

class OverDueBookDisplay extends StatefulWidget {
  const OverDueBookDisplay({super.key});

  @override
  State<OverDueBookDisplay> createState() => _OverDueBookDisplayState();
}

class _OverDueBookDisplayState extends State<OverDueBookDisplay> {
  // bool click=false;

  List<Map<String,dynamic>>?overduebook;
  @override
  void initState(){
    super.initState();
    getOverDueBookInfo();

  }

  void getOverDueBookInfo()async{
    overduebook=await DueBookInformation().dueBookInformationAllInfomration();
    print("alll due book are here ${getOverDueBookInfo.toString()}");
    setState(() {
      
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      appBar:AppBar(
        title:const CustomAppBar(title:"OverDueBook", subtitle:"OverDued Book !!!",screenIcon:Icons.book,),
        toolbarHeight:toolbarHeight,
        backgroundColor:darkPrimaryColor.withOpacity(0.1),
      ),
      body:Container(
        color:darkPrimaryColor.withOpacity(0.1),
        child: overduebook!=null?ListView.builder(
        itemBuilder:(BuildContext context,index){
          return Column(
            children: [
              InkWell(
                child: Container(
                  width:getWidth(context)*0.9,
                  height:100,
                  
                  decoration:const BoxDecoration(
                    border:Border(
                      
                    ),
                    borderRadius:BorderRadiusDirectional.all(Radius.elliptical(10, 20)),
                    shape:BoxShape.rectangle,
                    color:white
                  ),
                  child: Column(
                    children: [
                      customRowForLableAndValue(labelName: 'Book-Name', labelValue:overduebook![index]['bookname'],),
                      customRowForLableAndValue(labelName: 'User id', labelValue:overduebook![index]['userid'],),
                      customRowForLableAndValue(labelName: 'Return Date', labelValue:overduebook![index]['returndate'],),
                      
                    ],
                  ),
                ),
                onTap:(){
                  print("dipu us gereef ${overduebook![index]['userid']}");
                   Navigator.push(context,MaterialPageRoute(builder:(context) =>UserInfoToAdmin(userId:overduebook![index]['userid'],)));
        
                },
              ),
             const  SizedBox(
                height:10,
              )
            ],
          );
        },
            itemCount:overduebook!.length,):const CustomIndicator(),
      ),
    );
  }
}
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:lms/admin/display_user_info.dart';
// import 'package:lms/const/custom-app-bar.dart';
// import 'package:lms/const/theme.dart';
// import 'package:lms/student/student-home-screen.dart';

// class OverDueBookDisplay extends StatefulWidget {
//   const OverDueBookDisplay({super.key});

//   @override
//   State<OverDueBookDisplay> createState() => _OverDueBookDisplayState();
// }

// class _OverDueBookDisplayState extends State<OverDueBookDisplay> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar:AppBar(
//         title:const CustomAppBar(title:"OverDueBook", subtitle:"Overdued book",screenIcon:Icons.book,),
//         toolbarHeight:toolbarHeight,
//       ),
//       body:ListView.builder(
//       itemBuilder:(BuildContext context,index){
//         return Column(
//           children: [
//             InkWell(
//               child: Container(
//                 width:getWidth(context)*0.9,
//                 // height:,
//                 decoration:const BoxDecoration(
//                   border:Border(
                    
//                   ),
//                   borderRadius:BorderRadiusDirectional.all(Radius.elliptical(10, 20)),
//                   shape:BoxShape.rectangle,
//                   color:melon
//                 ),
//                 child: Column(
//                   children: [
//                     customRowForLableAndValue(labelName: 'Book-Name', labelValue: 'Name of book',),
//                     customRowForLableAndValue(labelName: 'Book-Author', labelValue: 'Author Name',),
//                     customRowForLableAndValue(labelName: 'Return Date', labelValue: 'dd/mm/yyyy',),
//                   ],
//                 ),
//               ),
//               onTap:(){
//                 Navigator.push(context,MaterialPageRoute(builder:(context) =>const UserInfoToAdmin()),);

//               },
//             ),
//            const  SizedBox(
//               height:10,
//             )
//           ],
//         );
//       },
//     itemCount:5,),
//     );
//   }
// }