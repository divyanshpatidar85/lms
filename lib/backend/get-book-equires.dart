import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GetAllBookInfo {
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  Future<List<Map<String, dynamic>>> getBooks(
      {String clgName = 'acropolis@gmail.com'}) async {
    try {
      List<Map<String, dynamic>> list = [];
      Query query = firebaseFirestore.collection('lms').doc(clgName).collection('addbook');

      QuerySnapshot querySnapshot = await query.get();

      for (var element in querySnapshot.docs) {
        list.add({
          "bookid": element['bookid'],
          "bookname": element['bookname'],
          "bookauthor": element['bookauthor'],
          "quantity": element['quantity'],
          "bookprice": element['bookprice'],
          "imageurl": element['imageurl'],
        });
      }

      return list;
    } catch (e) {
     
      return [];
    }
  }
    Future<List<Map<String, dynamic>>> searchBook(String bookName,
      {String clgName = 'acropolis@gmail.com'}) async {
    try {
      List<Map<String, dynamic>> list = [];
      Query query = firebaseFirestore.collection('lms').doc(clgName).collection('addbook').where('bookname',isLessThanOrEqualTo:bookName);

      QuerySnapshot querySnapshot = await query.get();

      for (var element in querySnapshot.docs) {
        list.add({
          "bookid": element['bookid'],
          "bookname": element['bookname'],
          "bookauthor": element['bookauthor'],
          "quantity": element['quantity'],
          "bookprice": element['bookprice'],
          "imageurl": element['imageurl'],
        });
      }

      return list;
    } catch (e) {
     
      return [];
    }
  }
      Future<List<String>> getOnlyThoseBookThatUserHave(List listOfBookId,
      {String clgName = 'acropolis@gmail.com'}) async {
    try {
      List<String> list=['Select Book'];
      print('i am called ');
      for( var document in listOfBookId){
      DocumentSnapshot snap = await firebaseFirestore.collection('lms').doc(clgName).collection('addbook').doc(document).get();
      if(snap.exists){
        list.add(snap['bookname']);
      }else{
        return ['Select Book'];
      }

      }
      print('book list is here ${list.toString()}');
     return list;
      // QuerySnapshot querySnapshot = await query.get();

    } catch (e) {
     
      return ['Select Book'];
    }
  }

        Future<List<Map<String, dynamic>>> getIssuedBookInfoByUserId(
      {String clgName = 'acropolis@gmail.com'}) async {
    try {
      List<Map<String, dynamic>> list = [];
      SharedPreferences _pref=await SharedPreferences.getInstance();
      String? userId=_pref.getString('userId');
      print(userId);
      Query query = firebaseFirestore.collection('lms').doc(clgName).collection('issuebook').where('userid',isEqualTo:userId);

      QuerySnapshot querySnapshot = await query.get();

      for (var element in querySnapshot.docs) {
        list.add({
         
          "bookname": element['bookname'],
          "issuedate": element['issudeDate'],
          "returndate": element['returndate'],
          
        });
      }
      // if(querySnapshot.docs.isEmpty){
      //   list.add({
         
      //     "bookname":'No book issued',
      //     "issuedate":'dd/mm/yyyy',
      //     "returndate":'dd/mm/yyyy',
          
      //   });
      // }
     return list;
      // QuerySnapshot querySnapshot = await query.get();

    } catch (e) {
      print('error is occured ${e.toString()}');
      return [{"bookname":'No book issued',
          "issuedate":'dd/mm/yyyy',
          "returndate":'dd/mm/yyyy',}];
    }
  }
}
