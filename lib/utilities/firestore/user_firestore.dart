import 'package:cloud_firestore/cloud_firestore.dart';

import '../../model/account.dart';
import '../authentication/authentication.dart';

class UserFireStore {
  static final _fireStoreInstance = FirebaseFirestore.instance;
  static final CollectionReference users = _fireStoreInstance.collection('users');

  static Future<dynamic> setUser(Account newAccount) async{//ユーザーをfirestoreに登録する処理
    try{
      await users.doc(newAccount.id).set({//データの追加は「set」メソッド
        'user_id': newAccount.id,
        //FireStoreの「usersコレクション」の「user_id」フィールドに、newAccountオブジェクトの「id」を格納
        //「'user_id'」とはデータベース側で用意しておく「箱」にあたる。
        //それとクライアント側からデータを送る管の名前である「newAccount.id」をくっつける作業を行なっている
        'email': newAccount.email,
        'password': newAccount.password
      })
          .then((value) => print("FireStore新規ユーザー作成に成功"))
          .catchError((error) => print("FireStore新規ユーザー作成に失敗しました!: $error"));
      return true;
    } on FirebaseException catch(e){
      print('新規ユーザー作成エラー $e');
      return false;
    }
  }

  static Future<dynamic> getUser(String uid) async{
    try{
      DocumentSnapshot documentSnapshot = await users.doc(uid).get();
      Map<String, dynamic> data = documentSnapshot.data() as Map<String, dynamic>;
      Account myAccount = Account(
          id: uid,
          email: data['email'],
          password: data['password']
      );
      Authentication.myAccount = myAccount;
      print('ユーザー取得完了');
      return true;
    } on FirebaseException catch(e){
      print('ユーザー取得完了エラー: $e');
      return false;
    }
  }
}