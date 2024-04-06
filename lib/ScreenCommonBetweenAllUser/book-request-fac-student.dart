// ignore_for_file: use_build_context_synchronously

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lms/backend/book-request.dart';

import 'package:lms/const/custom-app-bar.dart';
import 'package:lms/const/custom-button.dart';
import 'package:lms/const/customAlertDialog.dart';
import 'package:lms/const/overlays.dart';
import 'package:lms/const/theme.dart';
import 'package:lms/student/student-home-screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BookRequestConfermation extends StatefulWidget {
  const BookRequestConfermation({super.key});

  @override
  State<BookRequestConfermation> createState() => _BookRequestConfermationState();
}

class _BookRequestConfermationState extends State<BookRequestConfermation> {
  String? userType;
  String? userId;
  List<Map<String,dynamic>>?requestBookInfo;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserInfo();
    Timer.periodic(const Duration(seconds:30), (Timer t) {
    getUserInfo();
  });
    // getUserInfo();
  }

  void getUserInfo()async{
    SharedPreferences pref=await SharedPreferences.getInstance();
    userType=pref.getString('userType');
    userId=pref.getString('userId');
    
    requestBookInfo=await BookRequested().getInfoOfRequestedBook(userType!,userId!);
    // print('requested book information ${requestBookInfo}');
    // print("length of data is ${requestBookInfo}");
    setState(() {
      
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        title:const CustomAppBar(title:'Requested Book ', subtitle:'Have a great day',screenIcon:FontAwesomeIcons.book,),
        toolbarHeight:toolbarHeight,
        backgroundColor:darkPrimaryColor.withOpacity(0.1),
        // bottom:const TabBar(
        //   tabs:[
        //     Tab(
        //        child:Text('Faculty'),
        //     ),
        //    Tab(
        //        child:Text('Student'),
        //     ),
        //   ]
        //   ),
      ),
      body:requestBookInfo!=null&&requestBookInfo!.isNotEmpty? Container(
        color:darkPrimaryColor.withOpacity(0.1),
        width:double.infinity,
        height:double.infinity,
        
        
        child:FutureBuilder(
          future:BookRequested().getInfoOfRequestedBook(userType!,userId!),
            builder:(context,snapshot){
              if(snapshot.connectionState==ConnectionState.waiting){
                return Text("wait....",style:subHeadingStyle,);
              }else if(snapshot.hasError){
                return Text("none");
              }else{
                requestBookInfo=snapshot.data??[];
             return   ListView.builder(itemBuilder:(BuildContext context,index){
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
              child: Stack(
                children:[
                  Center(
                    child: Container(
                      width:getWidth(context)*0.9,
                      height:550,
                      decoration:BoxDecoration(
                        color:white,
                        border:Border.all(color:red),
                        borderRadius:BorderRadius.circular(6)
                      ),
                      
                      child:SingleChildScrollView(
                        scrollDirection:Axis.vertical,
                        child: Column(
                          children: [
                            const SizedBox(height:10,),
                             Padding(
                               padding: const EdgeInsets.only(left:4,right:4),
                               child: Row(
                                mainAxisAlignment:MainAxisAlignment.spaceBetween,
                                children: [
                                  
                                userType=='Admin'?SizedBox(
                                    width:100,
                                    height:30,
                                    child: CustomButton(onPressed:()async{
                                  AnotherClass.showTransparentDialog(context);
                                   String result=await BookRequested().bookRequestedAccepted(requestBookInfo![index]['bookid'],requestBookInfo![index]['userid'],requestBookInfo![index]['bookname'],15);
                                   if(result=='Success'){
                                     AnotherClass.hideTransparentDialog(context);
                                    CustomAlertDialog().showAlertMyDialog(context,'Book requested is accepted','have i nice day ;)');
                                    getUserInfo();
                                   }else{
                                     AnotherClass.hideTransparentDialog(context);
                                    CustomAlertDialog().showAlertMyDialog(context,'Some error occured ',result);
                                   }
                                  
                                    }, 
                                    text: Text('Accept',style:buttonTextStyle,)
                                    )
                                    ):const SizedBox(
                                    width:100,
                                    height:30,
                                    
                                    ),
                                    SizedBox(
                                    width:100,
                                    height:30,
                                    child: CustomButton(onPressed:()async{
                                      AnotherClass.showTransparentDialog(context);
                                     String res=await BookRequested().bookRequestedDenied(requestBookInfo![index]['bookid'],requestBookInfo![index]['userid']);
                                    if(res=='Success'){
                                      
                                      print('user id ${requestBookInfo![index]['userid']}  and book id ${requestBookInfo![index]['bookid']}');
                                      AnotherClass.hideTransparentDialog(context);
                                     
                                      CustomAlertDialog().showAlertMyDialog(context,"Your book request has been deleted",'hope it is okay');
                                      setState(() {
                                        getUserInfo();
                                      });
                                    }else{
                                      
                                      AnotherClass.hideTransparentDialog(context);
                                      
                                      CustomAlertDialog().showAlertMyDialog(context,"Some error occured",res);
                                    }
                                    }, 
                                    text: Text(userType=='Admin'?'Denied':'Delete', style:buttonTextStyle)
                                    )
                                    ),
                                ],
                               ),
                             ), 
                             const SizedBox(height:10,),
                            Image.network(requestBookInfo![index]['imageurl']),
                            const SizedBox(height:10,),
                            
                            customRowForLableAndValue(labelName: 'Book NAme', labelValue:requestBookInfo![index]['bookname'],),
                            customRowForLableAndValue(labelName: 'Author', labelValue:requestBookInfo![index]['author'],),
                            customRowForLableAndValue(labelName: 'Quantity', labelValue:requestBookInfo![index]['quantity'].toString(),)
                        
                          ],),
                      ),
                    ),
                  ),
                ],
              ),
                      ),
            );
          
          },
          itemCount:requestBookInfo!.length,
          );
              }
            },
        )
      ): Center(child: Text('No data is present',style:subHeadingStyle,)),
    );
  }
}