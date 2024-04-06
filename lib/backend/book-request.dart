//book request is accepted or denied
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:lms/backend/issue-book.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BookRequested {
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  Future<String> bookRequestedAccepted(
      String bookId, String userId, String bookName, int daysToreturn,
      {String clgName = 'acropolis@gmail.com'}) async {
    String result = "Some error occured";
    try {
      QuerySnapshot querySnapshot = await firebaseFirestore
          .collection('lms')
          .doc(clgName)
          .collection('requestbook')
          .get();

      List<Map<String, dynamic>> dataList = [];
      for (var document in querySnapshot.docs) {
        Map<String, dynamic> data = document.data() as Map<String, dynamic>;
        dataList.add(data);
        if (data['bookid'] == bookId && data['userid'] == userId) {
          await firebaseFirestore
              .collection('lms')
              .doc(clgName)
              .collection('requestbook')
              .doc(data['requestid'])
              .delete();

          // print('requet id is here ${data['requestid']}');
          break;
        }
      }
      await IssueBook()
          .issueBook(bookName, bookId, userId, DateTime.now(), daysToreturn);
      result = "Success";
      // await AddandRemoveBook().removeBookQuantity(bookId);
      return result;
    } catch (error) {
      return error.toString();
    }
  }

  //denied book request
  Future<String> bookRequestedDenied(String bookId, String userId,
      {String clgName = 'acropolis@gmail.com'}) async {
    String result = "Some error occured";
    try {
      SharedPreferences pref=await SharedPreferences.getInstance();
      String? userType=pref.getString('userType');
       QuerySnapshot querySnapshot;
      //  print('i am faclty');
      if(userType=='Student'){
        querySnapshot = querySnapshot = await firebaseFirestore
          .collection('lms')
          .doc(clgName)
          .collection('requestbook')
          .get();
      }else{
        // print('i am faclty');
        querySnapshot = querySnapshot = await firebaseFirestore
          .collection('lms')
          .doc(clgName)
          .collection('requestbookfaculty')
          .get();
      }
     

      List<Map<String, dynamic>> dataList = [];
      for (var document in querySnapshot.docs) {
        Map<String, dynamic> data = document.data() as Map<String, dynamic>;
        dataList.add(data);
        if (data['bookid'] == bookId && data['userid'] == userId && userType=='Student') {
          await firebaseFirestore
              .collection('lms')
              .doc(clgName)
              .collection('requestbook')
              .doc(data['requestid'])
              .delete();

          break;
        }else if(data['bookid'] == bookId && data['userid'] == userId && userType=='Faculty'){
           await firebaseFirestore
              .collection('lms')
              .doc(clgName)
              .collection('requestbookfaculty')
              .doc(data['requestid'])
              .delete();

          break;
        }
      }
      return 'Success';
    } catch (e) {
      return e.toString();
    }
  }

  Future<List<Map<String, dynamic>>> getInfoOfRequestedBook(
      String userType, String userId,
      {String clgName = 'acropolis@gmail.com'}) async {
    QuerySnapshot querySnapshot;
    if (userType == 'Student' ) {
      querySnapshot = await firebaseFirestore
          .collection('lms')
          .doc(clgName)
          .collection('requestbook')
          .where('userid', isEqualTo: userId)
          .get();
    }else if(userType=='Faculty'){
      querySnapshot = await firebaseFirestore
          .collection('lms')
          .doc(clgName)
          .collection('requestbookfaculty')
          .where('userid', isEqualTo: userId)
          .get();
    }else {
      querySnapshot = await firebaseFirestore
          .collection('lms')
          .doc(clgName)
          .collection('requestbook')
          .get();
    }
    // if(querySnapshot.e)
    List<Map<String, dynamic>> dataList = [];
    for (var document in querySnapshot.docs) {
      Map<String, dynamic> data = document.data() as Map<String, dynamic>;
      dataList.add(data);
    }

    return dataList;
  }

  //get book information by the admin for user and admin
    Future<List<Map<String, dynamic>>> getInfoOfRequestedBookAdmin(
      String userType, String userId,
      {String clgName = 'acropolis@gmail.com'}) async {
    QuerySnapshot querySnapshot;
    if (userType == 'Student' ) {
      querySnapshot = await firebaseFirestore
          .collection('lms')
          .doc(clgName)
          .collection('requestbook')
          
          .get();
    }else{
      querySnapshot = await firebaseFirestore
          .collection('lms')
          .doc(clgName)
          .collection('requestbookfaculty')
          
          .get();
    }
    // if(querySnapshot.e)
    List<Map<String, dynamic>> dataList = [];
    for (var document in querySnapshot.docs) {
      Map<String, dynamic> data = document.data() as Map<String, dynamic>;
      dataList.add(data);
    }

    return dataList;
  }

  

  //update the the qunatity of requested book
  Future<void> updateTheQuantityOfRequestedBook(String bookId,
      {String clgName = 'acropolis@gmail.com',
      bool increaseQunaity = true}) async {
    QuerySnapshot querySnapshot;
   
   
 querySnapshot = await firebaseFirestore
        .collection('lms')
        .doc(clgName)
        .collection('requestbook')
        .where('bookid', isEqualTo: bookId)
        .get();
    
   

    // if(querySnapshot.e)
    // List<Map<String, dynamic>> dataList = [];
    for (DocumentSnapshot document in querySnapshot.docs) {
      DocumentReference docRef = document.reference;
      Map<String, dynamic> data = document.data() as Map<String, dynamic>;
      if (increaseQunaity == true) {
        data['quantity'] = (int.parse(data['quantity'])+ 1).toString();
      } else {
        data['quantity'] = (int.parse(data['quantity'])- 1).toString();
        print('i am updateing document   hahahhaha');
      }
      await docRef.update(data);
    }

    // return dataList;
  }

  //update book request quantity faculty book quantity
    Future<void> updateTheQuantityOfRequestedBookFaculty(String bookId,
      {String clgName = 'acropolis@gmail.com',
      bool increaseQunaity = true}) async {
    QuerySnapshot querySnapshot;
   
   
 querySnapshot = await firebaseFirestore
        .collection('lms')
        .doc(clgName)
        .collection('requestbookfaculty')
        .where('bookid', isEqualTo: bookId)
        .get();
    
   

    // if(querySnapshot.e)
    // List<Map<String, dynamic>> dataList = [];
    for (DocumentSnapshot document in querySnapshot.docs) {
      DocumentReference docRef = document.reference;
      Map<String, dynamic> data = document.data() as Map<String, dynamic>;
      if (increaseQunaity == true) {
        data['quantity'] = (int.parse(data['quantity'])+ 1).toString();
      } else {
        data['quantity'] = (int.parse(data['quantity'])- 1).toString();
        print('i am updateing document   hahahhaha');
      }
      await docRef.update(data);
    }

    // return dataList;
  }


//delete all book request when book quantity is zero
  Future<void> deleteBookReq(String bookId,
      {String clgName = 'acropolis@gmail.com',
      }) async {
    QuerySnapshot querySnapshot;

    querySnapshot = await firebaseFirestore
        .collection('lms')
        .doc(clgName)
        .collection('requestbook')
        .where('bookid', isEqualTo: bookId)
        .get();

    // if(querySnapshot.e)
    // List<Map<String, dynamic>> dataList = [];
    for (DocumentSnapshot document in querySnapshot.docs) {
      DocumentReference docRef = document.reference;
      // Map<String, dynamic> data = document.data() as Map<String, dynamic>;
      
      await docRef.delete();
    }

    // return dataList;
  }
}
