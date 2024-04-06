
import 'package:flutter/material.dart';
import 'package:lms/ScreenCommonBetweenAllUser/book-req-bs.dart';
import 'package:lms/const/theme.dart';
import 'package:lms/student/student-home-screen.dart';

class DisplayedBookIndormation extends StatelessWidget {
  final String bookid;
  final String bookName;
  final String bookAuthor;
  final int bookquantity;
  final String userType;
  final String bookImageUrl;
   const DisplayedBookIndormation({super.key, required this.bookName, required this.bookAuthor, required this.bookquantity,required this.userType,required this.bookImageUrl, required this.bookid});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        height:100,
        decoration:BoxDecoration(
          border:Border.all(color:red),
          color:white,
          borderRadius:const BorderRadius.only(topLeft:Radius.elliptical(10,10),topRight:Radius.elliptical(10,10),bottomLeft:Radius.elliptical(10,10),bottomRight:Radius.elliptical(10,10))
        ),
        child:Stack(
          children: [
            Column(
          crossAxisAlignment:CrossAxisAlignment.start,
          children: [
            customRowForLableAndValue(labelName:'Book-Name', labelValue:bookName,),
            customRowForLableAndValue(labelName:'Author-Name', labelValue:bookAuthor,),
            customRowForLableAndValue(labelName:'Quantity', labelValue:bookquantity.toString(),),
            
          ],
        ),
          ],
        )
      ),
      onTap:(){
        Navigator.push(context,MaterialPageRoute(builder:(BuildContext context) =>BookRequestWindow(userType:userType, bookName:bookName, author:bookAuthor, quantity:bookquantity.toString(), imageurl:bookImageUrl, bookid:bookid,))
        
        
        );
      },
    );
  }
}