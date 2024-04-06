import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:lms/backend/login-user.dart';
import 'package:lms/const/theme.dart';
import 'package:lms/login-and-sigup.dart/tab-controller.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LogOutUniversal{
  RxBool colorAffect=true.obs;
  Widget logOut(BuildContext context){
    return Obx((){
     return Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top:10.0,left:8,right:8),
                      child:InkWell(
                        child: Container(
                          height:42,
                          width:getWidth(context)*0.9,
                        decoration:BoxDecoration(
                          color:colorAffect.value?white:darkPrimaryColor.withOpacity(0.1),
                          border:Border.all(color:red),
                          borderRadius:BorderRadius.circular(6)
                        ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment:MainAxisAlignment.spaceBetween,
                              children: [
                                Text('LogOut',style:headingStyle(context),),
                               const Icon(FontAwesomeIcons.powerOff)
                              ],
                            ),
                          ),
                        ),
                        onTap:()async{
                          colorAffect.toggle();
                          await Future.delayed(const Duration(milliseconds:200));
                          colorAffect.toggle();
                          await AuthenticationMethod().signOut();
                           Navigator.pushAndRemoveUntil(
                            // ignore: use_build_context_synchronously
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const TabControllerScreen()),
                            (route) => false);
                            SharedPreferences _pref=await SharedPreferences.getInstance();
                            _pref.remove('userId');
                            _pref.remove('userType');
                            _pref.clear();
                        },
                      )
                    )
                  ],
                );
    });
  }
}