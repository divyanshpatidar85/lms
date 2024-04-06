import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lms/backend/addAndRemoveBookInUserAccount.dart';
import 'package:lms/backend/book-request.dart';

import 'package:lms/backend/bookcatalog.dart';
import 'package:lms/backend/issue-book.dart';
import 'package:uuid/uuid.dart';

class BookEnquires {
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  // Method to add a book
  Future<String> addBook(String bookName, String bookAuthor, int bookPrice,
      int quantity, String imageUrl,
      {String clgName = 'acropolis@gmail.com'}) async {
    try {
      String randomid = const Uuid().v1();
      await firebaseFirestore
          .collection('lms')
          .doc(clgName)
          .collection('addbook')
          .doc(randomid)
          .set({
        "bookid": randomid,
        "bookname": bookName,
        "bookauthor": bookAuthor,
        "bookprice": bookPrice,
        "quantity": quantity,
        "imageurl": imageUrl
      });
      BookCatalog().addInfoInCatalog(quantity);
      return "Success";
    } catch (e) {
      return "Error: $e";
    }
  }

  // Method to request a book
  Future<String> requestBook(String userId, String bookId, DateTime timeStamp,String bookName,String author,String bookImageUrl,String quantity,
      {String userType='Student',String clgName = 'acropolis@gmail.com'}) async {
    try {
      String randomid = const Uuid().v1();
      if(userType=='Student'){
      QuerySnapshot duplicateDocs = await FirebaseFirestore.instance
      .collection('lms')
      .doc(clgName)
      .collection('requestbook')
      .where('userid', isEqualTo: userId)
      .where('bookid', isEqualTo: bookId)
      .limit(1)
      .get();
      DocumentSnapshot docsnap = await FirebaseFirestore.instance
      .collection('lms')
      .doc(clgName)
      .collection(userType)
      .doc(userId).get();
     

      print("print document haaaaahhhhhhhhhhhhhhhhhhhhaaaaaaaaa snap1 is ${docsnap['issuebook']}");
      if(duplicateDocs.docs.isEmpty && !docsnap['issuebook'].contains(bookId)){
      await firebaseFirestore
          .collection('lms')
          .doc(clgName)
          .collection('requestbook')
          .doc(randomid)
          .set({"userid": userId, "bookid": bookId,"bookname":bookName,"author":author,"imageurl":bookImageUrl, "timestamp": timeStamp,"requestid":randomid,"quantity":quantity});
      return "Success";
    }else if(docsnap['issuebook'].contains(bookId)){
        return "You have this book so you cannot request for it";
    }else{
       print('i aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa dipuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuu');
      return "You already requested book";
    }
        
      }else{
      QuerySnapshot duplicateDocs = await FirebaseFirestore.instance
      .collection('lms')
      .doc(clgName)
      .collection('requestbookfaculty')
      .where('userid', isEqualTo: userId)
      .where('bookid', isEqualTo: bookId)
      .limit(1)
      .get();
      DocumentSnapshot docsnap = await FirebaseFirestore.instance
      .collection('lms')
      .doc(clgName)
      .collection(userType)
      .doc(userId).get();
      if(duplicateDocs.docs.isEmpty && !docsnap['issuebook'].contains(bookId)){
      await firebaseFirestore
          .collection('lms')
          .doc(clgName)
          .collection('requestbookfaculty')
          .doc(randomid)
          .set({"userid": userId, "bookid": bookId,"bookname":bookName,"author":author,"imageurl":bookImageUrl, "timestamp": timeStamp,"requestid":randomid,"quantity":quantity});
      return "Success";
    }else if(docsnap['issuebook'].contains(bookId)){
       return "You have this book so you cannot request for it";
    }else{
      // print('i aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa dipuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuu');
      return "You already requested book";
    }
        
    }

    } catch (e) {
      return "Error: $e";
    }
  }

  // Method to return a book
  Future<String> returnBook(String bookId,String userId, {String clgName = 'acropolis@gmail.com'}) async {
    try {
      DocumentSnapshot userSnapshot = await firebaseFirestore
          .collection('lms')
          .doc(clgName)
          .collection('addbook')
          .doc(bookId)
          .get();
       print('${userSnapshot.data()}');    
      if (userSnapshot.exists) {
        Map<String, dynamic>? userData =
            userSnapshot.data() as Map<String, dynamic>?;
         print('i am okay now');
        if (userData != null) {
          int quantity = userData['quantity'] ?? 0;
          userData['quantity'] = quantity + 1;

          await firebaseFirestore
              .collection('lms')
              .doc(clgName)
              .collection('addbook')
              .doc(bookId)
              .update(userData);
       DocumentSnapshot userSnapshot=await firebaseFirestore.collection('lms').doc(clgName).collection('Student').doc(userId).get();
       if(userSnapshot.exists){
          await AddAndRemoveBookInUserAccount().removeBookInUserAccount(userId,'Student',bookId);
       }else{
          await AddAndRemoveBookInUserAccount().removeBookInUserAccount(userId,'Faculty',bookId);
       }
         
         await IssueBook().deleteIssueBook(bookId, userId);
         await  BookCatalog().addInfoInCatalog(1,returnBook:true);
         await BookRequested().updateTheQuantityOfRequestedBook(bookId);
         await BookRequested().updateTheQuantityOfRequestedBookFaculty(bookId);
         print('i am okay now');
        return "Success";
        } else {
          return "Error: Unable to retrieve book data";
        }
      } else {
        return "Error: Book not found";
      }
    } catch (e) {
      return "Error: $e";
    }
  }

  //update book qunatity
   Future<String> updateBookQuantity(String bookId,int newquantity,{String clgName = 'acropolis@gmail.com'}) async {
    try {
      DocumentSnapshot userSnapshot = await firebaseFirestore
          .collection('lms')
          .doc(clgName)
          .collection('addbook')
          .doc(bookId)
          .get();
       print('${userSnapshot.data()}');    
      if (userSnapshot.exists) {
        Map<String, dynamic>? userData =
            userSnapshot.data() as Map<String, dynamic>?;
        //  print('i am okay now');
        if (userData != null) {
          int quantity = userData['quantity'] ?? 0;
          userData['quantity'] = quantity + newquantity;

          await firebaseFirestore
              .collection('lms')
              .doc(clgName)
              .collection('addbook')
              .doc(bookId)
              .update(userData);
              await  BookCatalog().addInfoInCatalog(newquantity);
         
        return "Success";
        } else {
          return "Error: Unable to retrieve book data";
        }
      } else {
        return "Error: Book not found";
      }
    } catch (e) {
      return "Error: $e";
    }
  }



}
