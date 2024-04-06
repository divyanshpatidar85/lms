// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:lms/backend/book-enquires.dart';
import 'package:lms/backend/check-user-in-lms.dart';
import 'package:lms/backend/issue-book.dart';
import 'package:lms/const/custom-app-bar.dart';
import 'package:lms/const/custom-button.dart';
import 'package:lms/const/custom-textfield.dart';
import 'package:lms/const/customAlertDialog.dart';
import 'package:lms/const/overlays.dart';
import 'package:lms/const/theme.dart';
import 'package:lms/student/student-home-screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ignore: must_be_immutable
class BookRequestWindow extends StatefulWidget {
  final String userType;
  final String bookName;
  final String author;
  String quantity;
  final String imageurl;
  final String bookid;

  BookRequestWindow(
      {super.key,
      required this.userType,
      required this.bookName,
      required this.author,
      required this.quantity,
      required this.imageurl,
      required this.bookid});

  @override
  State<BookRequestWindow> createState() => _BookRequestWindowState();
}

class _BookRequestWindowState extends State<BookRequestWindow> {
  // String userType =widget.userType;
  TextEditingController studentid = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: toolbarHeight - 10,
        backgroundColor: darkPrimaryColor.withOpacity(0.1),
        elevation: 0,
        title: const CustomAppBar(
          title: 'Reuqest Book',
          subtitle: 'Hope You Enjoy',
          screenIcon: Icons.book,
        ),
      ),
      body: Container(
        color: darkPrimaryColor.withOpacity(0.1),
        child: Center(
          child: Stack(
            children: [
              Center(
                child: Container(
                  width: getWidth(context) * 0.9,
                  height: 600,
                  decoration: BoxDecoration(
                      color: white,
                      border: Border.all(color: red),
                      borderRadius: BorderRadius.circular(6)),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 4, right: 4),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              if (widget.userType != 'Admin')
                                SizedBox(
                                    width: 100,
                                    height: 30,
                                    child: CustomButton(
                                        onPressed: () async {
                                          AnotherClass.showTransparentDialog(
                                              context);
                                          SharedPreferences pref =
                                              await SharedPreferences
                                                  .getInstance();
                                          String? userId =
                                              pref.getString('userId');
                                          // String userId=
                                         

                                          
                                          if (int.parse(widget.quantity)!=0) {
                                            String res = await BookEnquires()
                                              .requestBook(
                                                  userId!,
                                                  widget.bookid,
                                                  DateTime.now(),
                                                  widget.bookName,
                                                  widget.author,
                                                  widget.imageurl,
                                                  widget.quantity,
                                                userType:widget.userType
                                                  );
                                            AnotherClass.hideTransparentDialog(
                                                context);
                                            if(res=="Success"){
                                               CustomAlertDialog()
                                                .showAlertMyDialog(
                                                    context,
                                                    'Book request is submitted',
                                                    'Hope it will accept');
                                            }else if(res=='You have this book so you cannot request for it'){
                                              CustomAlertDialog()
                                                .showAlertMyDialog(
                                                    context,
                                                    'May be you already have this book',
                                                    res);

                                            }else{
                                              CustomAlertDialog()
                                                .showAlertMyDialog(
                                                    context,
                                                    'May be you already requested for book',
                                                    res);
                                            }
                                           
                                          } else {
                                            AnotherClass.hideTransparentDialog(
                                                context);
                                                
                                            CustomAlertDialog()
                                                .showAlertMyDialog(
                                                    context,
                                                    'Book quantity is not sufficient','book quantity is zero'
                                                    );
                                          }
                                        },
                                        text: Text('Request',
                                            style: buttonTextStyle
                                            )
                                            )
                                            ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Image.network(
                          widget.imageurl,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        customRowForLableAndValue(
                          labelName: 'Book NAme',
                          labelValue: widget.bookName,
                        ),
                        customRowForLableAndValue(
                          labelName: 'Author',
                          labelValue: widget.author,
                        ),
                        if (widget.userType == 'Admin')
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: customRowForLableAndValue(
                                  labelName: 'Quantity',
                                  labelValue: widget.quantity,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 20),
                                child: InkWell(
                                  child: const Icon(
                                    Icons.edit,
                                    color: red,
                                  ),
                                  onTap: () {
                                    CustomAlertDialog().updateBookQuantity(
                                        context,
                                        'Update Book Quantity',
                                        widget.bookid);
                                  },
                                ),
                              ),
                            ],
                          ),
                        if (widget.userType != 'Admin')
                          customRowForLableAndValue(
                            labelName: 'Quantity',
                            labelValue: widget.quantity,
                          ),
                        const SizedBox(
                          height: 10,
                        ),
                        if (widget.userType == 'Admin')
                          SizedBox(
                            width: getWidth(context) * 0.85,
                            child: CustomTextField(
                                controller: studentid,
                                labelText: 'Student id',
                                hintText: 'Enter student id',
                                alternateHintText: 'Enter student id',
                                keyboardType: TextInputType.text),
                          ),
                        const SizedBox(
                          height: 10,
                        ),
                        if (widget.userType == 'Admin')
                          SizedBox(
                              width: getWidth(context) * 0.85,
                              height: 40,
                              child: CustomButton(
                                  onPressed: () async {
                                    AnotherClass.showTransparentDialog(context);
                                    bool status =
                                        await CheckUserInOurLmsSystem()
                                            .studentInLirary(studentid.text);

                                    if (status) {
                                      if (int.parse(widget.quantity) != 0) {
                                        String result = await IssueBook()
                                            .issueBook(
                                                widget.bookName,
                                                widget.bookid,
                                                studentid.text,
                                                DateTime.now(),
                                                15);
                                        AnotherClass.hideTransparentDialog(
                                            context);

                                        if (result == "Success") {
                                          AnotherClass.hideTransparentDialog(
                                              context);
                                          widget.quantity =
                                              (int.parse(widget.quantity) - 1)
                                                  .toString();
                                          CustomAlertDialog().showAlertMyDialog(
                                              context,
                                              'Book is issued ',
                                              'have a fun day');
                                        } else {
                                          AnotherClass.hideTransparentDialog(
                                              context);
                                          CustomAlertDialog().showAlertMyDialog(
                                              context,
                                              'may  be you already issued book ',
                                              result);
                                        }

                                        setState(() {});
                                      } else {
                                        AnotherClass.hideTransparentDialog(
                                            context);
                                        CustomAlertDialog().showAlertMyDialog(
                                            context,
                                            'Book quantity is not sufficient ',
                                            'try again after some time');
                                      }
                                    } else {
                                      AnotherClass.hideTransparentDialog(
                                          context);

                                      CustomAlertDialog().showAlertMyDialog(
                                          context,
                                          'Ohh User Not Found',
                                          'Please enter valid user');
                                    }
                                  },
                                  text: Text('Issue Book',
                                      style: buttonTextStyle))),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
