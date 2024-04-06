import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lms/backend/book-request.dart';

class AddandRemoveBook {
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  // Method to remove quantity of a book after issue
  Future<String> removeBookQuantity(String bookid,
      {String clgName = 'acropolis@gmail.com'}) async {
    try {
      DocumentSnapshot userSnapshot = await firebaseFirestore
          .collection('lms')
          .doc(clgName)
          .collection('addbook')
          .doc(bookid)
          .get();
      if (userSnapshot.exists) {
        Map<String, dynamic>? userData =
            userSnapshot.data() as Map<String, dynamic>?;

        if (userData != null) {
          int quantity = userData['quantity'] ?? 0;
          userData['quantity'] = quantity - 1;
          if(userData['quantity']==0){
           BookRequested().deleteBookReq(bookid);
          }
          await firebaseFirestore
              .collection('lms')
              .doc(clgName)
              .collection('addbook')
              .doc(bookid)
              .update(userData);
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

  // Method to add quantity of a book after return
  Future<String> addBookQuantity(String bookid,
      {String clgName = 'acropolis@gmail.com'}) async {
    try {
      DocumentSnapshot userSnapshot = await firebaseFirestore
          .collection('lms')
          .doc(clgName)
          .collection('addbook')
          .doc(bookid)
          .get();
      if (userSnapshot.exists) {
        Map<String, dynamic>? userData =
            userSnapshot.data() as Map<String, dynamic>?;

        if (userData != null) {
          int quantity = userData['quantity'] ?? 0;
          userData['quantity'] = quantity + 1;

          await firebaseFirestore
              .collection('lms')
              .doc(clgName)
              .collection('addbook')
              .doc(bookid)
              .update(userData);
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
