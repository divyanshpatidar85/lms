import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthenticationMethod {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  Future<String> signUpUser({
    required String userId,
    required String userName,
    required String email,
    required String password,
    required String userType,
    required int startYear,
    required int endYear,
    required String mobileNumber,
    required String department,
    required String profileUrl,
    String clgName = 'acropolis@gmail.com',
  }) async {
    try {
      print(' am here');
      UserCredential userCredential = await _firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);
      print('by dipu');
      await _firebaseFirestore
          .collection('lms')
          .doc(clgName)
          .collection(userType)
          .doc(userId)
          .set({
        "currentuseruid": userCredential.user!.uid,
        "email": email,
        "username": userName,
        "userid": userId,
        "startyear": startYear,
        "endyear": endYear,
        "department": department,
        "issuebook": [],
        "fine": 0,
        "mobilenumber":mobileNumber,
        "profileurl": profileUrl,
      });
    // print('i am divyansh patidar');
      return "success";
    } catch (error) {
      return 'Some Error Occurred. Please check your credentials and connection.';
    }
  }

  Future<String> loginMethod({
    required String userId,
    required String password,
    required String userType,
    String clgName = 'acropolis@gmail.com',
  }) async {
    try {
      
      DocumentSnapshot userSnapshot = await _firebaseFirestore
          .collection('lms')
          .doc(clgName)
          .collection(userType)
          .doc(userId)
          .get();

      if (userSnapshot.exists) {
        Map<String, dynamic>? userData =
            userSnapshot.data() as Map<String, dynamic>?;
        String email = userData!['email'];
        await _firebaseAuth.signInWithEmailAndPassword(
            email: email, password: password);
        return "success";
      } else {
        return "User not found";
      }
    } catch (error) {
      return 'An error occurred: $error';
    }
  }

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }
}
