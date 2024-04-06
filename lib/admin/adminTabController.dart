import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lms/ScreenCommonBetweenAllUser/book-search.dart';
import 'package:lms/admin/add-book.dart';
import 'package:lms/admin/addUser.dart';
import 'package:lms/admin/admin-home.dart';
import 'package:lms/admin/book-req-confemation.dart';
import 'package:lms/backend/getUserInformation.dart';
import 'package:lms/const/custom-progress-indicator.dart';

import 'package:lms/const/theme.dart';
import 'package:shared_preferences/shared_preferences.dart';


class AdminTabControllerScreen extends StatefulWidget {
  const AdminTabControllerScreen({super.key});

  @override
  State<AdminTabControllerScreen> createState() =>
      _AdminTabControllerScreenState();
}

class _AdminTabControllerScreenState extends State<AdminTabControllerScreen> {
  int _page = 0;
  late PageController pageControll = PageController();
     List? adminInfo;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserId();

    // print('User id is :  ${AuthenticationMethod().userId}');
  }

  void getUserId() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? vali = prefs.getString('userId');
    print('with admin       $vali');
    adminInfo = await GetUserInformation().getInfoOfCurrentUser();
    print('here is admin data :${adminInfo.toString()}');
    setState(() {});
    //  print(dipu);
  }

  @override
  void dispose() {
    super.dispose();
    pageControll.dispose();
  }

  void navigationTapped(int page) {
    pageControll.jumpToPage(page);
  }

  void onPageChanged(int page) {
    setState(() {
      _page = page;
    });
  }

  @override
  Widget build(BuildContext context) {
    return adminInfo!=null?Scaffold(
      body: PageView(
        controller: pageControll,
        onPageChanged: onPageChanged,
        children:  [
          // BookSearch(userType:'Admin',),
          AdminHomeScreen(adminInfo:adminInfo!,),
           BookSearch(userType:'Admin',),
          const BookRequestConfermationAdmin(),
         const AddBook(),
          const AddUser(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
                size: 30,
                color: _page == 0 ? red : melon,
              ),
              label: '',
              tooltip: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.search,
                size: 30,
                color: _page == 1 ? red : melon,
              ),
              label: '',
              tooltip: 'Search Book'),
          BottomNavigationBarItem(
              icon: FaIcon(
                FontAwesomeIcons.bookAtlas,
                color: _page == 2 ? red : melon,
              ),
              label: '',
              tooltip: 'Requested History'),
          BottomNavigationBarItem(
              icon: FaIcon(
                FontAwesomeIcons.book,
                color: _page == 3 ? red : melon,
              ),
              label: '',
              tooltip: 'Add Book'),
          BottomNavigationBarItem(
              icon: FaIcon(
                FontAwesomeIcons.user,
                color: _page == 4 ? red : melon,
              ),
              label: '',
              tooltip: 'Add User'),
        ],
        onTap: navigationTapped,
      ),
    ):const CustomIndicator();
  }
}
