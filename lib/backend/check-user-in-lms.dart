import 'package:cloud_firestore/cloud_firestore.dart';

class CheckUserInOurLmsSystem{
  FirebaseFirestore firebaseFirestore=FirebaseFirestore.instance;
  Future<bool>studentInLirary(String userId,{String clgName='acropolis@gmail.com'})async{
   DocumentSnapshot userSnapshot,userSnapshot1;
    print('dipuuuuuuuuuuuuu am called here');
    try{
       userSnapshot = await firebaseFirestore
          .collection('lms')
          .doc(clgName)
          .collection('Student')
          .doc(userId)
          .get();
        userSnapshot1 = await firebaseFirestore
          .collection('lms')
          .doc(clgName)
          .collection('Faculty')
          .doc(userId)
          .get();
          if(userSnapshot.exists || userSnapshot1.exists){
      return true;
    }
    }catch(error){
        return false;
    }finally{
      
      // ignore: control_flow_in_finally
      // return false;
    }
    
           print('i am called here');
    
    return false;
  }

  //yet not implemented
   Future<bool>facultyInLirary(String userId,{String clgName='acropolis@gmail.com'})async{

     print('dipuuuuuuuuuuuuu am called here');
    DocumentSnapshot userSnapshot = await firebaseFirestore
          .collection('lms')
          .doc(clgName)
          .collection('Student')
          .doc(userId)
          .get();
          print('i am called here');
    if(userSnapshot.exists){
      return true;
    }
    return false;
  }
}