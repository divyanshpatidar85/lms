import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class DueBookInformation {
 FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

 Future<List<Map<String, dynamic>>> dueBookInformationAllInfomration({String clgName = 'acropolis@gmail.com'}) async {
    List<Map<String, dynamic>> list = [];
    QuerySnapshot snap = await firebaseFirestore.collection('lms').doc(clgName).collection("issuebook").where("actualreturndate", isLessThan: DateTime.now()).get();
    for (var element in snap.docs) {
      list.add({
        "bookid": element['bookid'],
        "bookname": element['bookname'],
        "returndate": element['returndate'],
        "userid": element['userid'],
        "actualreturndate": element['actualreturndate']
        
      });
    }

    print("book data is here with my $list");
    return list;
 }
}