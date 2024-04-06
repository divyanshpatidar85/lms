import 'package:cloud_firestore/cloud_firestore.dart';

class BookCatalog {
  final FirebaseFirestore _fireBaseStore = FirebaseFirestore.instance;
  
  Future<void> addInfoInCatalog(int addnewquantity,
      {String clgName = 'acropolis@gmail.com', bool issueBook = false, bool returnBook = false}) async {
    try {
      DocumentSnapshot userSnapshot = await _fireBaseStore
          .collection('lms')
          .doc(clgName)
          .collection('bookcatalog')
          .doc('catalog')
          .get();

      if (userSnapshot.exists) {
        Map<String, dynamic>? userData = userSnapshot.data() as Map<String, dynamic>?;
        if (issueBook) {
          int issuebook = userData!['issuebook'];
          userData['issuebook'] = issuebook + 1;
        } else if (returnBook) {
          int issuebook = userData!['issuebook'];
          userData['issuebook'] = issuebook - 1;
        } else {
          int totalbook = userData!['totalbook'];
          userData['totalbook'] = totalbook + addnewquantity;
        }
          userData['notissuedbook']=userData['totalbook']-userData['issuebook'];
        await _fireBaseStore
            .collection('lms')
            .doc(clgName)
            .collection('bookcatalog')
            .doc('catalog')
            .update(userData);
      } else {
        await _fireBaseStore.collection('lms').doc(clgName).collection('bookcatalog').doc('catalog').set({
          "totalbook":addnewquantity,
          "notissuedbook":0,
          "issuebook": 0,
        });
      }
    } catch (e) {
      print("Error: $e");
      // Handle error here
    }
  }
    Future<List<int>> getCatalogData(
      {String clgName = 'acropolis@gmail.com'}) async {
        List<int>cataData=[];
    try {
      
      DocumentSnapshot userSnapshot = await _fireBaseStore
          .collection('lms')
          .doc(clgName)
          .collection('bookcatalog')
          .doc('catalog')
          .get();
          if(userSnapshot.exists){
      Map<String, dynamic>? userData = userSnapshot.data() as Map<String, dynamic>?;
      cataData.add(userData!['issuebook']);
      cataData.add(userData['notissuedbook']);
          }
      
    } catch (e) {
      print("Error: $e");
      return [];
      // Handle error here
    }
    // print("here cata log length ${cataData[0]}");
    return cataData;
  }
}
