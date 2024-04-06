import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:lms/backend/getUserInformation.dart';
import 'package:lms/const/custom-progress-indicator.dart';
import 'package:lms/const/theme.dart';
import 'package:lms/faculty/faculty-home-screen.dart';
import 'package:url_launcher/url_launcher.dart';

class UserInfoToAdmin extends StatefulWidget {
  final String userId;
  const UserInfoToAdmin({super.key, required this.userId});

  @override
  State<UserInfoToAdmin> createState() => _UserInfoToAdminState();
}

class _UserInfoToAdminState extends State<UserInfoToAdmin> {
  List<dynamic>? studentInfo;
  @override
  void initState() {
    super.initState();
    getData();
  }

  void getData() async {
    studentInfo = await GetUserInformation().getUserInfoFromId(widget.userId);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return studentInfo != null
        ? Scaffold(
            appBar: AppBar(),
            body: Center(
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
                                      child: SizedBox(
                                        width: 55 * 2,
                                        height: 55 * 2,
                                        child: ClipOval(
                                            child: FadeInImage(
                                          placeholder: const AssetImage(
                                              'assets/app-logo/lmslogog.png'), // Placeholder image
                                          image: NetworkImage(studentInfo![5]
                                              .toString()), // Actual profile image
                                          fit: BoxFit
                                              .contain, // Adjust image to fit circle avatar
                                        )),
                                      )),
                                ),
                              ),
                              // customTitle(context, 'User Information'),
                              SizedBox(
                                  width: getWidth(context) * 0.9,
                                  child: customRowForLableAndValue(
                                    labelName: 'Username',
                                    labelValue: studentInfo![1],
                                  )),
                              SizedBox(
                                  width: getWidth(context) * 0.9,
                                  child: customRowForLableAndValue(
                                    labelName: 'Userid',
                                    labelValue: studentInfo![2],
                                  )),
                              SizedBox(
                                  width: getWidth(context) * 0.9,
                                  child: SizedBox(
                                      width: getWidth(context) * 0.9,
                                      child: customRowForLableAndValue(
                                        labelName: 'Start Year',
                                        labelValue: studentInfo![3].toString(),
                                      ))),
                              SizedBox(
                                  width: getWidth(context) * 0.9,
                                  child: customRowForLableAndValue(
                                    labelName: 'End year',
                                    labelValue: studentInfo![4].toString(),
                                  )),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  SizedBox(
                                      width: getWidth(context) * 0.8,
                                      child: customRowForLableAndValue(
                                        labelName: 'Mobile Number',
                                        labelValue: studentInfo![7].toString(),
                                      )),
                                  InkWell(
                                    child: const Icon(
                                      Icons.call,
                                      color: red,
                                    ),
                                    onTap: () async {
                                      print("i am called ");
                                      String url = '${studentInfo![7]}';
                                      print("${studentInfo![7]}");
                                      Uri urll = Uri(scheme: 'tel', path: url);
                                      if (await canLaunchUrl(urll)) {
                                        await launchUrl(urll);
                                      } else {
                                        // Handle the case where the phone app cannot be launched
                                        print('Could not launch $url');
                                        // Fluttertoast.showToast(msg: 'Could not launch phone dialer');
                                      }
                                    },
                                  )
                                ],
                              ),
                            ],
                          ),
                          // width: ,
                          // child:,
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          )
        : const CustomIndicator();
  }
}
