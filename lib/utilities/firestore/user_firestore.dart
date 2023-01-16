import 'package:cloud_firestore/cloud_firestore.dart';

import '../../model/account.dart';

class UserFirestore {
  static final _firestoreInstance = FirebaseFirestore.instance;
  static final CollectionReference users = _firestoreInstance.collection('users');

  static Future<dynamic> setUser(Account newAccount) async{//ユーザーをfirestoreに登録する処理
    try{
      await users.doc(newAccount.id).set({
        'name': newAccount.name,
        'user_id': newAccount.favoriteQuestionId,
        'image_path': newAccount.email,
        'created_time': Timestamp.now(),
        'updated_time': Timestamp.now()
      });
      print('新規ユーザー作成完了');
      return true;
    } on FirebaseException catch(e){
      print('新規ユーザー作成エラー $e');
      return false;
    }
  }
}