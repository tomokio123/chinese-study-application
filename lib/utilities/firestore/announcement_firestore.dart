import 'package:chinese_study_applicaion/model/difficulty.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
class AnnouncementFireStore {
  static final _fireStoreInstance = FirebaseFirestore.instance;
  static final CollectionReference announcements = _fireStoreInstance.collection('announcements');

  // static Future<dynamic> getUser(String uid) async{
  //   try{
  //     DocumentSnapshot documentSnapshot = await announcements.doc(uid).get();
  //     Map<String, dynamic> data = documentSnapshot.data() as Map<String, dynamic>;
  //     Account myAccount = Account(
  //         id: uid,
  //         name: data['name'],
  //         email: data['email'],
  //         password: data['password']
  //     );
  //     Authentication.myAccount = myAccount;
  //     print('ユーザー取得完了');
  //     return true;
  //   } on FirebaseException catch(e){
  //     print('ユーザー取得完了エラー: $e');
  //     return false;
  //   }
  // }
}