import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GetUserInformation {
  Future<List> getInfoOfCurrentUser(
      {String clgName = 'acropolis@gmail.com'}) async {
    List<dynamic> returnInformaton = [];
    SharedPreferences pref = await SharedPreferences.getInstance();
    String ?userId = pref.getString('userId');
    // userId='student';
    String? userType = pref.getString('userType');
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    DocumentSnapshot userSnapshot = await firebaseFirestore
        .collection('lms')
        .doc(clgName)
        .collection(userType!)
        .doc(userId)
        .get();
    if (userSnapshot.exists) {
      Map<String, dynamic>? userData =
          userSnapshot.data() as Map<String, dynamic>?;
      returnInformaton.add(userData!['email']);
      returnInformaton.add(userData['username']);
      returnInformaton.add(userData['userid']);
      returnInformaton.add(userData['startyear']);
      returnInformaton.add(userData['endyear']);
      returnInformaton.add(userData['profileurl']);
      returnInformaton.add(userData['issuebook']);
      returnInformaton.add(userData['mobilenumber']);
      print('divyansh is heer ${userData['username']}   $userId');
      // return "success";
    } else {
      // return "User not found";
    }

    return returnInformaton;
  }
    Future<List> getUserInfoFromId(String id,
      {String clgName = 'acropolis@gmail.com'}) async {
    List<dynamic> returnInformaton = [];
    // SharedPreferences pref = await SharedPreferences.getInstance();
    // String? userId = pref.getString('userId');
    // String? userType = pref.getString('userType');
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    DocumentSnapshot userSnapshot = await firebaseFirestore
        .collection('lms')
        .doc(clgName)
        .collection('Student')
        .doc(id)
        .get();
        DocumentSnapshot userSnapshot1 = await firebaseFirestore
        .collection('lms')
        .doc(clgName)
        .collection('Faculty')
        .doc(id)
        .get();
    if (userSnapshot.exists) {
      Map<String, dynamic>? userData =
          userSnapshot.data() as Map<String, dynamic>?;
      returnInformaton.add(userData!['email']);
      returnInformaton.add(userData['username']);
      returnInformaton.add(userData['userid']);
      returnInformaton.add(userData['startyear']);
      returnInformaton.add(userData['endyear']);
      returnInformaton.add(userData['profileurl']);
      returnInformaton.add(userData['issuebook']);
      returnInformaton.add(userData['mobilenumber']);
      // print('divyansh is heer ${userData['mobilenumber'].toString()}');
      // return "success";
    } else if(userSnapshot1.exists) {
      // print("tulllllllllllllllllllllllllaaaaaaaaa0000");
      Map<String, dynamic>? userData =
          userSnapshot1.data() as Map<String, dynamic>?;
       returnInformaton.add(userData!['email']);
      returnInformaton.add(userData['username']);
      returnInformaton.add(userData['userid']);
      returnInformaton.add(userData['startyear']);
      returnInformaton.add(userData['endyear']);
      returnInformaton.add(userData['profileurl']);
      returnInformaton.add(userData['issuebook']);
      returnInformaton.add(userData['mobilenumber']);
      // print('divyansh is heer ${userData['issuebook'].toString()}');
      // return "User not found";
    }
    
    return returnInformaton;
  }


  
}
