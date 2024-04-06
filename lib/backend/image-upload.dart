import 'dart:io';
import 'dart:typed_data';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';

class StorageMethods {
  // Adding image to Firebase storage
  Future<String> uploadToStorage(Uint8List file, {bool isprofile = false}) async {
    try {
      // Creating location to our Firebase storage
      final FirebaseStorage firebaseStorage = FirebaseStorage.instance;
      Reference ref;
      isprofile == true
          ? ref = firebaseStorage.ref().child('profile')
          : ref = firebaseStorage.ref().child('book');
      String uuid = const Uuid().v1();
      ref = ref.child(uuid);

      UploadTask uploadTask = ref.putData(file);

      TaskSnapshot snapshot = await uploadTask;
      String downloadUrl = await snapshot.ref.getDownloadURL();
      return downloadUrl;
    } catch (e) {
      print("Error: $e");
      // Handle error here
      return '';
    }
  }

  Future<Uint8List> convertXFileToUint8List(XFile xFile) async {
    try {
      File file = File(xFile.path);
      List<int> bytes = await file.readAsBytes();
      return Uint8List.fromList(bytes);
    } catch (e) {
      print("Error: $e");
      // Handle error here
      return Uint8List(0);
    }
  }
}
