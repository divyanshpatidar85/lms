// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lms/backend/book-enquires.dart';
import 'package:lms/backend/get-book-equires.dart';
import 'package:lms/backend/getUserInformation.dart';
import 'package:lms/const/custom-app-bar.dart';
import 'package:lms/const/custom-button.dart';
import 'package:lms/const/custom-drop-down-menu.dart';

import 'package:lms/const/customAlertDialog.dart';
import 'package:lms/const/overlays.dart';
import 'package:lms/const/theme.dart';

class ReturnBookByUser extends StatefulWidget {
  const ReturnBookByUser({super.key});

  @override
  State<ReturnBookByUser> createState() => _ReturnBookByUserState();
}

class _ReturnBookByUserState extends State<ReturnBookByUser> {
  List<dynamic>?userInfo;
  RxBool hover=false.obs;
  int selectedIndex=0;
  String selectedValue='Select Book';
  TextEditingController userId=TextEditingController();
  List<String> bookList=['Select Book'];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // getData();
    
  }
  Future<void> getData(String userId)async{
    //  print('user information ${userInfo.toString()}');
    userInfo= await GetUserInformation().getUserInfoFromId(userId.trim());
    bookList=['Select Book'];
    // print('user information ${userInfo.toString()}');
    setState(() {
      
    });
  }
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar:AppBar(
        backgroundColor:darkPrimaryColor.withOpacity(0.1),
        title:const CustomAppBar(title:'Return Book', subtitle:'Thanks, Returned!',screenIcon:Icons.book_online,),
        toolbarHeight:toolbarHeight,
      ),
      body:Container(
        color:darkPrimaryColor.withOpacity(0.1),
        height:double.infinity,
        width: double.infinity,
        child:Column(
          children: [
           const  SizedBox(height:20,),
            SizedBox(
              width:getWidth(context)*0.9,
              height:50,
              child: TextField(
                controller:userId,
                // enableInteractiveSelection:false,
                decoration:const InputDecoration(
                  border:OutlineInputBorder(
                    borderSide:BorderSide(color:white),
                    borderRadius:BorderRadius.all(Radius.circular(10))
                  ),
                  label: Text('User Id'),
                  enabledBorder: OutlineInputBorder(
                    borderSide:BorderSide(color:red),
                    borderRadius:BorderRadius.all(Radius.circular(10)),
                    
                  ),
                  disabledBorder:OutlineInputBorder(
                    borderRadius:BorderRadius.all(Radius.circular(10))
                  ),
                ),
                
                onChanged:(e)async{
                  // print("divyansh is hare with date ${userInfo![6]['issuebook']}");
                 await  getData(e);
                  //  print('bookList is waiting ${userInfo![0]}');
                  if(userInfo!=null){
                    // print('bookList is waiting ${userInfo![0]['issuebook']}');
                     bookList=await GetAllBookInfo().getOnlyThoseBookThatUserHave(userInfo![0]);
                    //  print('book id for user ${bookList.toString()}');
                  }else{
                    bookList=['Select Book'];
                    
                  }
                 setState(() {
                      
                    });
                
                },
                
                
                onEditingComplete:(){
                  AnotherClass.showTransparentDialog(context);
                  Future.delayed(const Duration(seconds:1)).whenComplete(() =>AnotherClass.hideTransparentDialog(context));
                },
              ),
            ),
            const  SizedBox(height:20,),
            SizedBox(
              width:getWidth(context)*0.9,
              child: CustomDropDownMenu(selectedValue:selectedValue, option:bookList,
               onSelectedChanged:(val){
                            
                          selectedIndex = bookList.indexOf(val);
                          selectedValue=val;
                          if(selectedIndex!=0){
                          print('book id of issued book is : ${userInfo![0][selectedIndex-1]}');
                          }
                          
               })),
             const  SizedBox(height:20,),
            SizedBox(
              width:getWidth(context)*0.9,
              child: CustomButton(onPressed:()async{
                AnotherClass.showTransparentDialog(context);
                 if(selectedIndex!=0 && selectedValue!='No book issued'){
                  print('i am herrrrrrrrrr ${selectedValue}');
                        String res=await BookEnquires().returnBook(userInfo![0][selectedIndex-1],userId.text.trim());
                        if(res=="Success"){
                          bookList.clear();
                          print('book list is here after updateing $bookList');
                          await getData(userId.text.trim());
                          print('book list is here after updateing $bookList');
                          selectedValue='Select Book';
                          selectedIndex=0;

                          AnotherClass.hideTransparentDialog(context);

                         setState(() {
                           
                         });
                          CustomAlertDialog().showAlertMyDialog(context,'Book is succesfully returned','Good to see you again');
                          
                        }
                          
                 }else{
                  AnotherClass.hideTransparentDialog(context);
                    CustomAlertDialog().showAlertMyDialog(context,'Some error occured','Please try again');
                 }
                
                //  AnotherClass.hideTransparentDialog(context);
              }, text:Text('Submit',style:buttonTextStyle,)))
          ],
        ),
      ),);
    // :const CustomIndicator();
  }
}