import 'package:chinese_study_applicaion/model/difficulty.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../model/announcements.dart';
class AnnouncementFireStore {
  static final _fireStoreInstance = FirebaseFirestore.instance;
  static final CollectionReference announcements = _fireStoreInstance.collection('announcements');

  static Future<dynamic> updateIsReadState(String announcementId, bool updatedBool) async{
    //既読をつける処理/
    // TODO：【重要】ここでは 「true = 既読・false = 未読」と定義している。
    try{
      await announcements.doc(announcementId).set({
        'is_read': updatedBool,
      }).then((value) => print("既読登録に成功"));
      return true;
      //.catchError((error) => print("FireStore新規問題投稿に失敗: $error"));
    } on Exception catch(e){
      print('既読登録エラー：$e');
    }
  }
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