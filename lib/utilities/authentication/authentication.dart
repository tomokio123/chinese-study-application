import 'package:firebase_auth/firebase_auth.dart';

import '../../model/account.dart';

class Authentication {
  static final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;//firebaseのインスタンス生成
  static User? currentFirebaseUser;
  static Account? myAccount;

  static Future<dynamic> signUp({required String email, required String password}) async{
    try{//ユーザーをfirebaseAuthに登録する処理
      UserCredential newAccount = await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
      print("firebaseAuth 登録 完了");
      return newAccount;
    } on FirebaseAuthException catch(e){
      if(e.code == 'invalid-email'){
        print("Auth 登録 Error: ${e.code}");
        return e;
      }
      if(e.code == 'email-already-in-use'){
        print("Auth 登録 Error: ${e.code}");
        return e;
      }
    }
  }

  static Future<dynamic> emailSignIn({required String email, required String password})async {
    //TODO:ここで「currentFirebaseUser」がしっかり埋まっているか確認する。サインアウトはできるが、アカウント削除の際にAuth.delete()だけができていない。
    //引数にはログインの際に打ち込んだemail&passwordが入ってくる
    try {
      final UserCredential _result = await _firebaseAuth.signInWithEmailAndPassword(
        //それを_resultオブジェクトとして持つ
          email: email,
          password: password);
      currentFirebaseUser = _result.user;
      //渡した引数の情報をもつオブジェクト「_result」のuserメソッドを呼び出す。
      // それをcurrentFirebaseUserとして再度保持する
      print("Auth signin ok");
      print("$email");
      return _result;//返り値として_resultを返す
    } on FirebaseAuthException catch(e){
      if(e.code == 'invalid-email'){
        print("Auth 登録 Error: ${e.code}");
        return e;
      }
      if(e.code == 'user-disabled'){
        print("Auth 登録 Error: ${e.code}");
        return e;
      }
      if(e.code == 'user-not-found'){
        print("Auth 登録 Error: ${e.code}");
        return e;
      }
      if(e.code == 'wrong-password'){
        print("Auth 登録 Error: ${e.code}");
        return e;
      }
    }
  }

  static Future<void> signOut() async{
    try {
      await _firebaseAuth.signOut();
      print('${_firebaseAuth}のサインアウト成功しました');
      //return true;
    } on FirebaseAuthException catch(e){
      print('サインアウトerror: $e');
      //サインアウトerror: [firebase_auth/no-current-user] No user currently signed in. こんなエラーが出る
      //return false;
    }
  }

  static Future<void> deleteAuth() async{
    try {
      // var user = FirebaseAuth.instance.currentUser;
      // await user!.delete();
      await currentFirebaseUser?.delete();//ログアウトするだけでアカウント事態を消したわけではない
      print('deleteAuth()成功');
    } on FirebaseAuthException catch(e){
      print('サインアウトerror: $e');
    }
  }
}