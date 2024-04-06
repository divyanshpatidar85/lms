import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
// import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
// import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:intl/intl.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lms/ScreenCommonBetweenAllUser/logout-class.dart';
import 'package:lms/api/firebase-api.dart';
import 'package:lms/backend/get-book-equires.dart';


import 'package:lms/const/custom-app-bar.dart';
import 'package:lms/const/custom-progress-indicator.dart';
import 'package:lms/const/theme.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StudentHomeScreen extends StatefulWidget {
  List<dynamic>studentInfo;
  
   StudentHomeScreen({super.key,required this.studentInfo});

  @override
  State<StudentHomeScreen> createState() => _StudentHomeScreenState();
}

class _StudentHomeScreenState extends State<StudentHomeScreen> {
  // List? studentInfo;
//   String htmlContent='''
// <html>
// <body>
// <img alt="Girl in a jacket" width="500" height="600" src="https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSrOluWuBYQmrKcQm1B9vqEnQxv3nhTIg-CH9NRcckxkiHy2XvvkZKiNeP__bruaMyRH88&usqp=CAU">
// </body>
// </html> 
//  ''';
  List<Map<String,dynamic>>?issuedBookInfo;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print('iin     it is called');
    getIssuedBook();

    print("image url is ${widget.studentInfo[5]}");
  
    
  }
  void getIssuedBook() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? vali = prefs.getString('userId');
    // print('with lllllllllllllllllll       $vali');
    issuedBookInfo=await GetAllBookInfo().getIssuedBookInfoByUserId();
    print("student fjnjfnjnjfnj $issuedBookInfo");
    setState(() {});
    //  print(dipu);
  }
  // issuedBookInfo=await GetAllBookInfo().getIssuedBookInfoByUserId();

  // void getUserId() async {
  //   final SharedPreferences prefs = await SharedPreferences.getInstance();
  //   String? vali = prefs.getString('userId');
  //   print('with lllllllllllllllllll       $vali');
  //   studentInfo = await GetUserInformation().getInfoOfCurrentUser();
  //   setState(() {});
  //   //  print(dipu);
  // }

  @override
  Widget build(BuildContext context) {
//  String htmlContent='''
// <html>
// <body>

// <img alt="unable to load profile Image"  src="${widget.studentInfo[5].toString()}">
// </body>
// </html> 
//  ''';
    return  Scaffold(
      appBar: AppBar(
        backgroundColor: darkPrimaryColor.withOpacity(0.1),
        elevation: 0,
        title: const CustomAppBar(
          title: 'Library',
          subtitle: 'Home',
          screenIcon: Icons.home,
        ),
        toolbarHeight: toolbarHeight,
      ),
      body:issuedBookInfo!=null?Center(
        child: Container(
          color: darkPrimaryColor.withOpacity(0.1),
          width: getWidth(context),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: [
                Stack(
                  children: [
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 20.0, left: 8, right: 8),
                      child: Container(
                        height: 300,
                        decoration: BoxDecoration(
                            color: white,
                            border: Border.all(color: red),
                            borderRadius: BorderRadius.circular(6)),
                        width: getWidth(context) * 0.9,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Center(
                        //         CircleAvatar(
                        //     radius:70,
                        //     child:SizedBox(
                        //   width: 2 *
                        //       65, // 2 times radius - 1 (to accommodate the border)
                        //   height: 2 *
                        //       65, // 2 times radius - 1 (to accommodate the border)
                        //   child: ClipOval(
                        //     // child: Image.network(widget.adminInfo[5].toString(),
                        //     //   fit: BoxFit.cover,
                        //     //   scale:0.5,
                        //     child:FadeInImage(
                        //                   placeholder:const AssetImage(
                        //                       'assets/app-logo/lmslogog.png'), // Placeholder image
                        //                   image: NetworkImage(widget.adminInfo[5]), // Actual profile image
                        //                   fit: BoxFit
                        //                       .cover, // Adjust image to fit circle avatar
                        //                 ) ,
                        //     ),
                        //   ),
                        // ),
                                child: CircleAvatar(
                                  radius: 60, // Radius minus 1
                                  child:SizedBox(
                                    width:55*2,
                                    height:55*2,
                                    child:ClipOval(
                                    child:FadeInImage(
                                          placeholder:const AssetImage(
                                              'assets/app-logo/lmslogog.png'), // Placeholder image
                                          image: NetworkImage(widget.studentInfo[5].toString()), // Actual profile image
                                          fit: BoxFit
                                              .contain, // Adjust image to fit circle avatar
                                        )
                                      
                                      
                                    ),
                                  
                                  )
                                ),
                              ),
                            ),
                            customTitle(context, 'User Information'),
                            SizedBox(
                                width: getWidth(context) * 0.9,
                                child: customRowForLableAndValue(
                                  labelName: 'Username',
                                  labelValue:widget.studentInfo[1],
                                )),
                            SizedBox(
                                width: getWidth(context) * 0.9,
                                child: customRowForLableAndValue(
                                  labelName: 'Userid',
                                  labelValue:widget.studentInfo[2],
                                )),
                            SizedBox(
                                width: getWidth(context) * 0.9,
                                child: SizedBox(
                                    width: getWidth(context) * 0.9,
                                    child: customRowForLableAndValue(
                                      labelName: 'Start Year',
                                      labelValue:widget.studentInfo[3].toString(),
                                    ))),
                            SizedBox(
                                width: getWidth(context) * 0.9,
                                child: customRowForLableAndValue(
                                  labelName: 'End year',
                                  labelValue:widget.studentInfo[4].toString(),
                                ))
                          ],
                        ),
                        // width: ,
                        // child:,
                      ),
                    )
                  ],
                ),
                Stack(
                  children: [
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 10.0, left: 8, right: 8),
                      child: Container(
                        height:200,
                        decoration: BoxDecoration(
                            color: white,
                            border: Border.all(color: red),
                            borderRadius: BorderRadius.circular(6)),
                        width: getWidth(context) * 0.9,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 15,
                            ),
                            customTitle(context, 'Issued Book Information'),
                          issuedBookInfo!.isNotEmpty?SizedBox(
                              width:getWidth(context)*0.9,
                              height:130,
                              child: ListView.builder(itemBuilder:(BuildContext context, index){
                                scheduleNotificationForBook(issuedBookInfo![index],index);
                                return Column(
                                  children: [
                                    SizedBox(
                                  width: getWidth(context) * 0.9,
                                  child: SizedBox(
                                      width: getWidth(context) * 0.9,
                                      child: customRowForLableAndValue(
                                        labelName: 'Issued Book',
                                        // labelValue:issuedBookInfo![].length.toString() ,
                                        labelValue:issuedBookInfo![index]['bookname'],
                                      ))),
                              SizedBox(
                                  width: getWidth(context) * 0.9,
                                  child: customRowForLableAndValue(
                                    labelName: 'Issued Date',
                                    labelValue:issuedBookInfo![index]['issuedate'].toString(),
                                    // labelValue:widget.issuedBookInfo[0]['issuedate'].toString().substring(0,widget.issuedBookInfo[0]['issuedate'].toString().length-22),
                                  )),
                              SizedBox(
                                  width: getWidth(context) * 0.9,
                                  child: customRowForLableAndValue(
                                    labelName: 'Due Date',
                                    labelValue:issuedBookInfo![index]['returndate'].toString()
                                    // labelValue:widget.issuedBookInfo[0]['returndate'].toString().substring(0,widget.issuedBookInfo[0]['returndate'].toString().length-22),
                                  )
                                  ),
                                  ],
                                );
                              },
                              itemCount:issuedBookInfo!.length,
                              ),
                            ): Center(child:  Text("No ssued book",style:subHeadingStyle,)),
                            
                  
                          ],
                        ),
                        // width: ,
                        // child:,
                      ),
                    )
                  ],
                ),
                Stack(
                  children: [
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 10.0, left: 8, right: 8),
                      child: Container(
                        height: 100,
                        decoration: BoxDecoration(
                            color: white,
                            border: Border.all(color: red),
                            borderRadius: BorderRadius.circular(6)),
                        width: getWidth(context) * 0.9,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 5,
                            ),
                            customTitle(context, 'Fine Status'),
                            customRowForLableAndValue(
                              labelName: 'Total Fine',
                              labelValue: '500 ',
                            ),
                          ],
                        ),
                        // width: ,
                        // child:,
                      ),
                    )
                  ],
                ),
                LogOutUniversal().logOut(context),
                const SizedBox(
                  height: 20,
                )
              ],
            ),
          ),
        ),
      ):const CustomIndicator(),
    );
  }

  Padding customTitle(BuildContext context, String title) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(
        child: Text(
          title,
          style: headingStyle(context),
        ),
      ),
    );
  }
  //here is sechudel class for notification
  
//function for notification
void scheduleNotificationForBook(Map<String, dynamic> book,int index) {

  String dueDateString = book['returndate'].toString();

  DateTime dueDate = DateFormat('dd/MM/yyyy').parse(dueDateString);

  DateTime notificationTime = DateTime.now().add(const Duration(minutes:1));
  print("user type ${notificationTime}");

  if (notificationTime.isAfter(DateTime.now())) {
   
    String payload = "Due date for ${book['bookname']} is approaching.";
   
    LocalNotifications.showScheduleNotification(
                      id:index,
                      title:"Book Due Reminder",
                      body:payload,
                      payload: "This is schedule data",
                      dueDate:dueDate
                      );
  }
}
}

// ignore: camel_case_types, must_be_immutable
class customRowForLableAndValue extends StatelessWidget {
  String labelName;
  String labelValue;
  customRowForLableAndValue(
      {super.key, required this.labelName, required this.labelValue});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10.0, top: 8, bottom: 0, right: 10),
      child: Row(
        children: [
          Expanded(
              child: Text(
            labelName,
            style: labelStyle,
          )),
          const Text(' : '),
          Expanded(
              child: Text(
            labelValue,
            style: labelValueStyle,
          )),
        ],
      ),
    );
  }



}
