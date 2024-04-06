import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lms/ScreenCommonBetweenAllUser/book-request-fac-student.dart';

import 'package:lms/ScreenCommonBetweenAllUser/book-search.dart';
import 'package:lms/admin/book-req-confemation.dart';
import 'package:lms/backend/getUserInformation.dart';

import 'package:lms/const/theme.dart';
import 'package:lms/faculty/faculty-home-screen.dart';

import 'package:shared_preferences/shared_preferences.dart';

class FacultyTabController extends StatefulWidget {
  final String userType;
  const FacultyTabController({super.key, required this.userType});

  @override
  State<FacultyTabController> createState() => _FacultyTabControllerState();
}

class _FacultyTabControllerState extends State<FacultyTabController> {
  int _page =0;
  late PageController pageControll=PageController();
    List? facultyInfo;
  // List<Map<String,dynamic>>?issuedBookInfo;
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
    print('with lllllllllllllllllll       $vali');
    facultyInfo = await GetUserInformation().getInfoOfCurrentUser();
   
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
    // getUserId();
  }

  void onPageChanged(int page) async{
    setState(() {
      _page = page;
    });
  }
  @override
  Widget build(BuildContext context) {
    return  facultyInfo!=null? Scaffold(
      body:PageView(
        controller: pageControll,
        onPageChanged:onPageChanged,
        children: [
          FacultyHomeScreen(facultyInfo:facultyInfo==null?[]:facultyInfo!,),
           BookSearch(userType:widget.userType,),
          const BookRequestConfermation(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,size:30,
              color: _page == 0 ? red : melon,
            ),
            label: '',
            tooltip:'Home'
          ),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.search,size:30,
                color: _page == 1 ? red : melon,
              ),
              label:'',
              tooltip:'Search Book'
              ),
          BottomNavigationBarItem(
              icon: FaIcon(
                FontAwesomeIcons.book,
                color: _page == 2 ? red : melon,
              ),
              label: '',
              tooltip:'Requested Book'
              ),
        ],
   
        onTap: navigationTapped,
      ),
    ):const Center(
      child:SizedBox(
        height:40,
        width:40,
        child: CircularProgressIndicator(
          color:red,
        ),
      ),
    );
  }
}
