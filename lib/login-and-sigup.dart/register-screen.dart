import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_overlay_apps/flutter_overlay_apps.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:keyboard_hider/keyboard_hider.dart';
import 'package:lms/backend/image-upload.dart';
import 'package:lms/backend/login-user.dart';
import 'package:lms/const/custom-button.dart';
import 'package:lms/const/custom-drop-down-menu.dart';
import 'package:lms/const/custom-textfield.dart';
import 'package:lms/const/customAlertDialog.dart';
import 'package:lms/const/overlays.dart';
import 'package:lms/const/theme.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  Uint8List? _file;
  bool tapstatus = false;
  bool _showOverlay = false;
  bool enableStatus = true;
  String selectedUserType = 'Select User Type';
  TextEditingController userId = TextEditingController();
  TextEditingController userName = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController startYear = TextEditingController();
  TextEditingController endYear = TextEditingController();
  TextEditingController mobileNumber = TextEditingController();
  TextEditingController password = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    hideTextInput();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            const SizedBox(height: 10),
            Center(
              child: InkWell(
                child: CircleAvatar(
                  radius: 80,
                  child: _file == null
                      ? Text('Upload Image')
                      : SizedBox(
                          width: 2 *
                              78, // 2 times radius - 1 (to accommodate the border)
                          height: 2 *
                              78, // 2 times radius - 1 (to accommodate the border)
                          child: ClipOval(
                            child: Image.memory(
                              _file!,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                ),
                onTap: () async {
                  XFile? dipu = await ImagePicker()
                      .pickImage(source: ImageSource.gallery);
                  if (dipu != null) {
                    _file =
                        await StorageMethods().convertXFileToUint8List(dipu);
                  }
                  setState(() {});
                },
              ),
            ),
            const SizedBox(height: 10),
            // CustomDropDownMenu
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
                    // setState(() {
                      selectedUserType = value;
                      setState(() {
                        
                      });
                      // enableStatus = selectedUserType== 'Student';
                    // });
                  },
                )),
            const SizedBox(height: 10),
            SizedBox(
              width: getWidth(context) * 0.9,
              child: CustomTextField(
                controller: userId,
                hintText: 'Student Id',
                labelText: 'Student Id',
                alternateHintText: 'Enter Student Id ...',
                icon: const FaIcon(
                  FontAwesomeIcons.idCard,
                  color: red,
                ),
                keyboardType: TextInputType.text,
              ),
            ),
            const SizedBox(height: 10),
            SizedBox(
              width: getWidth(context) * 0.9,
              child: CustomTextField(
                controller: userName,
                hintText: 'Name',
                labelText: 'Name',
                alternateHintText: 'Enter your name ...',
                icon: const FaIcon(
                  FontAwesomeIcons.user,
                  color: red,
                ),
                keyboardType: TextInputType.text,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            if(selectedUserType=='Student')
            SizedBox(
              height: 45,
              width: getWidth(context) * 0.9,
              child: Row(
                children: [
                  SizedBox(
                    width: getWidth(context) * 0.43,
                    child: CustomTextField(
                      controller: startYear,
                      hintText: 'Start Year',
                      labelText: 'Start Year',
                      alternateHintText: 'Start Year',
                      keyboardType: TextInputType.number,
                      digit: true,
                      enableStatus: enableStatus,
                      lengthlimit: 4,
                    ),
                  ),
                  const SizedBox(
                    width: 14,
                  ),
                  SizedBox(
                    width: getWidth(context) * 0.43,
                    child: CustomTextField(
                      controller: endYear,
                      hintText: 'End Year',
                      labelText: 'End Year',
                      alternateHintText: 'Enter End Year ...',
                      keyboardType: TextInputType.number,
                      digit: true,
                      enableStatus: enableStatus,
                      lengthlimit: 4,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            SizedBox(
              width: getWidth(context) * 0.9,
              height: 45,
              child: CustomTextField(
                controller: email,
                hintText: 'Email',
                labelText: 'Email',
                alternateHintText: 'Enter your email id ..',

                // enableStatus:true,
                icon: const FaIcon(
                  Icons.mail,
                  color: red,
                ),
                digit: false,
                keyboardType: TextInputType.emailAddress,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            SizedBox(
              width: getWidth(context) * 0.9,
              height: 45,
              child: CustomTextField(
                controller: mobileNumber,
                hintText: 'Mobile Number',
                labelText: 'Mobile Number',
                alternateHintText: 'Enter your Mobile Number ..',
                icon: const FaIcon(
                  FontAwesomeIcons.phone,
                  color: red,
                ),
                digit: true,
                keyboardType: TextInputType.text,
              ),
            ),
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
                    obsecuretext: true,
                    keyboardType: TextInputType.text)),
            const SizedBox(
              height: 10,
            ),

            SizedBox(
              width: getWidth(context) * 0.9,
              child: CustomButton(
                  onPressed: () async {
                    if (selectedUserType == 'Select User Type') {
                      CustomAlertDialog().showAlertMyDialog(
                          context,
                          'Ohhh no Error !!!',
                          'please select correct user type');
                    } else if (userId.text.trim() == '') {
                      CustomAlertDialog().showAlertMyDialog(context,
                          'Ohhh no Error !!!', 'please enter correct user id');
                    } else if (userName.text.trim() == '') {
                      CustomAlertDialog().showAlertMyDialog(
                          context,
                          'Ohhh no Error !!!',
                          'please enter correct user name');
                    } else if (startYear.text.trim() == '' &&
                        startYear.text.length != 4 &&
                        selectedUserType == 'Student') {
                      CustomAlertDialog().showAlertMyDialog(context,
                          'Ohhh no Error !!!', 'please enter start year');
                    } else if (endYear.text.trim() == '' &&
                        endYear.text.length != 4 &&
                        selectedUserType == 'Student') {
                      CustomAlertDialog().showAlertMyDialog(context,
                          'Ohhh no Error !!!', 'please enter end year');
                    } else if (email.text.trim() == '') {
                      CustomAlertDialog().showAlertMyDialog(
                          context,
                          'Ohhh no Error !!!',
                          'please enter a valid email address');
                    } else if (mobileNumber.text.trim() == '' &&
                        mobileNumber.text.length != 10 &&
                        mobileNumber.text[0] != '0') {
                      CustomAlertDialog().showAlertMyDialog(
                          context,
                          'Ohhh no Error !!!',
                          'please enter a valid mobile number');
                    } else if (password.text.length < 6) {
                      CustomAlertDialog().showAlertMyDialog(
                          context,
                          'Ohhh no Error !!!',
                          'Password length must be greater than 5');
                    } else if (_file == null) {
                      CustomAlertDialog().showAlertMyDialog(context,
                          'Ohhh no Error !!!', 'Please upload profile image');
                    } else {
                      AnotherClass.showTransparentDialog(context);
                      String imageUrl = await StorageMethods()
                          .uploadToStorage(_file!, isprofile: true);
                      print('i uploaded images');
                      if(selectedUserType!='Student'){
                        startYear.text='0000';
                        endYear.text='0000';
                      }
                      String res = await AuthenticationMethod().signUpUser(
                          userId: userId.text,
                          userName: userName.text,
                          email: email.text,
                          password: password.text,
                          userType: selectedUserType,
                          startYear:int.parse(startYear.text),
                          endYear: int.parse(endYear.text),
                          mobileNumber: mobileNumber.text,
                          department: '',
                          profileUrl: imageUrl);
                      print('i done images');
                      if (res == "success") {
                        // ignore: use_build_context_synchronously
                        AnotherClass.hideTransparentDialog(context);
                        // ignore: use_build_context_synchronously
                        CustomAlertDialog().showAlertMyDialog(
                            context,
                            'User is registered succesfully',
                            'now try to login');
                      } else {
                        // ignore: use_build_context_synchronously
                        AnotherClass.hideTransparentDialog(context);
                        // ignore: use_build_context_synchronously
                        CustomAlertDialog()
                            .showAlertMyDialog(context, 'Error !!!', res);
                      }
                    }

                    //  _showOverlay=true;
                    //  AnotherClass.showTransparentDialog(context);
                    // Future.delayed(const Duration(seconds:50)).whenComplete(() {
                    // AnotherClass.hideTransparentDialog(context);

                    // },);
                    // setState(() {});
                    //  tapstatus = false;
                    //  setState(() {

                    //  });
                  },
                  text: Text(
                    'Register',
                    style: buttonTextStyle,
                  )),
            ),
            // if (_showOverlay)
            // const TransparentProgressOverlay(),
          ],
        ),
      ),
    );
  }
}
