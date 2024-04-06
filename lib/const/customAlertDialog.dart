// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:lms/backend/book-enquires.dart';
import 'package:lms/const/custom-textfield.dart';
import 'package:lms/const/theme.dart';

class CustomAlertDialog{
 void showAlertMyDialog(
      BuildContext context, String alertTitle, String alertNotes) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext ctx) {
        return Theme(
          data: ThemeData(
            colorScheme: ColorScheme.fromSeed(
              seedColor: Colors.white,
            ),
          ),
          child: AlertDialog(
            title: Text(alertTitle,style:headingStyle(context),),
            
            content:  SingleChildScrollView(
              child: Column(
                children: [
                  Text(alertNotes,style:subHeadingStyle,),
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: const Text('Ok'),
                onPressed: () {
                  Navigator.pop(ctx); // Close the dialog
                },
              )
            ],
          ),
        );
      },
    ).timeout(
      const Duration(seconds: 5),
      onTimeout: () {
        Navigator.pop(context);
      },
    );
  }

  //update book quantity
  void updateBookQuantity(
      BuildContext context, String alertTitle,String bookId) async {
        TextEditingController newBookQuantity=TextEditingController();
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext ctx) {
        return Theme(
          data: ThemeData(
            colorScheme: ColorScheme.fromSeed(
              seedColor: Colors.white,
            ),
          ),
          child: AlertDialog(
            title: Text(alertTitle,style:headingStyle(context),),
            
            content:  SingleChildScrollView(
              child: Column(
                children: [
                  Text('Enter new quantity of book ',style:subHeadingStyle,),
                 const SizedBox(
                    height:10,
                  ),
                  CustomTextField(controller:newBookQuantity, hintText:'Enter new book quantity', alternateHintText:'Enter book quantity', keyboardType:TextInputType.number)
                ],
              ),
            ),
            actions: <Widget>[
              Row(
                mainAxisAlignment:MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                child: const Text('Update'),
                onPressed: () async{
                 String res=await BookEnquires().updateBookQuantity(bookId,int.parse(newBookQuantity.text));
                 if(res=="Success"){
                  showAlertMyDialog(context,'Book qunatity is updated','ohh great to hear you added new stock');
                  Future.delayed(const Duration(seconds:3)).whenComplete(() =>Navigator.pop(context));
                 }else{
                   showAlertMyDialog(context,'Error',res);
                 }
                },
              ),
               TextButton(
                child: const Text('Cancel'),
                onPressed: () async{
                 Navigator.pop(context);
                },
              )
                ],
              )
            ],
          ),
        );
      },
    );
  }
}