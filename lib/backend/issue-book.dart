import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:lms/backend/AddandRemoveBookQuantity.dart';
import 'package:lms/backend/addAndRemoveBookInUserAccount.dart';
import 'package:lms/backend/book-request.dart';
import 'package:lms/backend/bookcatalog.dart';
import 'package:lms/backend/getUserInformation.dart';
import 'package:uuid/uuid.dart';


class IssueBook {
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  Future<String> issueBook(String bookName, String bookId, String userId,DateTime issueDate,int daysToReturn,
      {String clgName = 'acropolis@gmail.com'}) async {
    try {
      String result = 'Some error occurred';
      String issueId = const Uuid().v1();
      
      // DateTime returnDate=issueDate.add(Duration(days:daysToReturn));
     List alredayIssuedBook=await GetUserInformation().getUserInfoFromId(userId);
     print("dipu string is here ${alredayIssuedBook.toString()}");
     bool val=alredayIssuedBook[0].contains(bookId);
     print("val is here $val");
      if(!val){
        print("val2 is here $val");
      await firebaseFirestore
          .collection('lms')
          .doc(clgName)
          .collection('issuebook')
          .doc(issueId)
          .set({
        "issueid": issueId,
        "bookname": bookName,
        "bookid": bookId,
        "userid": userId,
        "issudeDate":DateFormat('dd/MM/yyyy').format(issueDate),
        "returndate":DateFormat('dd/MM/yyyy').format(issueDate.add(Duration(days:daysToReturn))),
        "actualreturndate":issueDate.add(Duration(days:daysToReturn))
      });
      await AddandRemoveBook().removeBookQuantity(bookId);
      await  BookCatalog().addInfoInCatalog(1,issueBook:true);
        DocumentSnapshot userSnapshot=await firebaseFirestore.collection('lms').doc(clgName).collection('Student').doc(userId).get();
       if(userSnapshot.exists){
          await AddAndRemoveBookInUserAccount().addBookInUserAccount(userId,'Student',bookId);
       }else{
          await AddAndRemoveBookInUserAccount().addBookInUserAccount(userId,'Faculty',bookId);
       }
      // await  AddAndRemoveBookInUserAccount().addBookInUserAccount(userId,'Student', bookId);
      await BookRequested().updateTheQuantityOfRequestedBook(bookId,increaseQunaity:false);
      await BookRequested().updateTheQuantityOfRequestedBookFaculty(bookId,increaseQunaity:false);
      // await  AddAndRemoveBookInUserAccount().addBookInUserAccount(userId,'Student', bookId);
      return result = 'Success';
      }else{
        // print('error is occued');
        return "Book is already issued";
      }
    } catch (e) {
      // print("Error: $e");
      return 'Error: $e';
    }
  }

  Future<String> deleteIssueBook(String bookId, String userId,
      {String clgName = 'acropolis@gmail.com'}) async {
    try {
      String result = 'Some error occurred';

      QuerySnapshot querySnapshot = await firebaseFirestore
          .collection('lms')
          .doc(clgName)
          .collection('issuebook')
          .get();

      List<Map<String, dynamic>> dataList = [];
      for (var document in querySnapshot.docs) {
        Map<String, dynamic> data = document.data() as Map<String, dynamic>;
        dataList.add(data);
        if (data['bookid'] == bookId && data['userid'] == userId) {
          await firebaseFirestore
              .collection('lms')
              .doc(clgName)
              .collection('issuebook')
              .doc(data[
                  'issueid']) 
              .delete();
          break;
        }
      }

      return result = 'Success';
    } catch (e) {
      print("Error: $e");
      return 'Error: $e';
    }
  }
}
