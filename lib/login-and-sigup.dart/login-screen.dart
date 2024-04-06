// ignore_for_file: use_build_context_synchronously

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:keyboard_hider/keyboard_hider.dart';
import 'package:lms/admin/adminTabController.dart';
import 'package:lms/backend/login-user.dart';
import 'package:lms/const/custom-button.dart';
import 'package:lms/const/custom-drop-down-menu.dart';
import 'package:lms/const/custom-textfield.dart';
import 'package:lms/const/customAlertDialog.dart';
import 'package:lms/const/overlays.dart';
import 'package:lms/const/theme.dart';
import 'package:lms/faculty/faculty-tab-controller.dart';
import 'package:lms/login-and-sigup.dart/hello.dart';

import 'package:lms/student/student-tab-controller.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool tapstatus = false;
  bool obsecuretext = true;
  String selectedUserType = 'Select User Type';
  TextEditingController userId = TextEditingController();
  TextEditingController password = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    hideTextInput();
    // FocusScope.of(context).unfocus();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            SizedBox(
                width: getWidth(context) * 0.9,
                child: CustomDropDownMenu(
                  selectedValue: selectedUserType,
                  option: const [
                    'Select User Type',
                    'Admin',
                    'Faculty',
                    'Student'
                  ],
                  onSelectedChanged: (String value) {
                    selectedUserType = value;
                    print('selected user type $selectedUserType');
                    setState(() {});
                  },
                )),
            const SizedBox(
              height: 10,
            ),
            SizedBox(
                width: getWidth(context) * 0.9,
                // height:60,
                child: CustomTextField(
                    controller: userId,
                    hintText: 'Enter User Id',
                    alternateHintText: 'Enter User Id',
                    labelText: 'User Id',
                    icon: const FaIcon(
                      FontAwesomeIcons.user,
                      color: red,
                    ),
                    keyboardType: TextInputType.text)),
            const SizedBox(
              height: 10,
            ),
            SizedBox(
                width: getWidth(context) * 0.9,
                // height:60,
                child: CustomTextField(
                    controller: password,
                    hintText: 'Enter Password',
                    labelText: 'Password',
                    alternateHintText: 'Enter Password',
                    icon: const FaIcon(
                      FontAwesomeIcons.eye,
                      color: red,
                    ),
                    obsecuretext: obsecuretext,
                    keyboardType: TextInputType.text)),
            const SizedBox(
              height: 10,
            ),
            SizedBox(
              width: getWidth(context) * 0.9,
              child: CustomButton(
                  onPressed: () async {
                    AnotherClass.showTransparentDialog(context);
                    String res = await AuthenticationMethod().loginMethod(
                        userId: userId.text,
                        password: password.text,
                        userType: selectedUserType);
                    // print('result ');
                    if (res == 'success') {
                      
                      final SharedPreferences prefs =
                          await SharedPreferences.getInstance();
                      await prefs.setString('userId', userId.text);
                      await prefs.setString('userType', selectedUserType);
                      if (selectedUserType == 'Student') {
                       
                         print("i am divyansh patidar here   smkmkdmkmkmkm      bhsbhbshbhb");
                        AnotherClass.hideTransparentDialog(context);
                        // Navigator.pop(context);
                        // print("i am divyansh patidar here        bhsbhbshbhb");
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (context) => StudentTabController(
                                      userType: selectedUserType,
                                    )),
                            (route) => false);
                      } else if (selectedUserType == 'Faculty') {
                        AnotherClass.hideTransparentDialog(context);
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (context) => FacultyTabController(
                                      userType: selectedUserType,
                                    )),
                            (route) => false);
                      } else {
                       AnotherClass.hideTransparentDialog(context);

                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const AdminTabControllerScreen()),
                            (route) => false);
                      }
                    } else {
                      AnotherClass.hideTransparentDialog(context);
                      CustomAlertDialog().showAlertMyDialog(
                          context, 'Creadintal is not matched', res);
                    }

                    setState(() {});
                  },
                  text: Text(
                    'Login',
                    style: buttonTextStyle,
                  )),
            )
          ],
        ),
      ),
    );
  }
}
