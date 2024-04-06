import 'package:cloud_firestore/cloud_firestore.dart';

class AddAndRemoveBookInUserAccount {
  FirebaseFirestore fireBaseStore = FirebaseFirestore.instance;
  Future<String> addBookInUserAccount(String userId,String userType,String bookId,{String clgName='acropolis@gmail.com'}) async {
    String result = "Soem error occured";
    DocumentSnapshot userSnapshot = await fireBaseStore
        .collection('lms')
        .doc(clgName)
        .collection(userType)
        .doc(userId)
        .get();
    if (userSnapshot.exists) {
      Map<String, dynamic>? userData =
          userSnapshot.data() as Map<String, dynamic>?;
          userData!['issuebook'].add(bookId);
     await fireBaseStore
            .collection('lms')
            .doc(clgName)
            .collection(userType)
            .doc(userId)
            .update(userData);
      
    }

    return result;
  }
    Future<String> removeBookInUserAccount(String userId,String userType,String bookId,{String clgName='acropolis@gmail.com'}) async {
    String result = "Soem error occured";
    DocumentSnapshot userSnapshot = await fireBaseStore
        .collection('lms')
        .doc(clgName)
        .collection(userType)
        .doc(userId)
        .get();
    if (userSnapshot.exists) {
      Map<String, dynamic>? userData =
          userSnapshot.data() as Map<String, dynamic>?;
          userData!['issuebook'].remove(bookId);
     await fireBaseStore
            .collection('lms')
            .doc(clgName)
            .collection(userType)
            .doc(userId)
            .update(userData);
      
    }

    return result;
  }
      Future<bool> getBookInUserAccount(String userId,String userType,String bookId,{String clgName='acropolis@gmail.com'}) async {
    bool result = false;
    DocumentSnapshot userSnapshot = await fireBaseStore
        .collection('lms')
        .doc(clgName)
        .collection(userType)
        .doc(userId)
        .get();
    if (userSnapshot.exists) {
      Map<String, dynamic>? userData =
          userSnapshot.data() as Map<String, dynamic>?;
          userData!['issuebook'].contains(bookId);
          result=true;
    
      
    }

    return result;
  }
}
