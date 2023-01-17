import 'package:firebase_auth/firebase_auth.dart';

class Authentication {
  static final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;//firebaseのインスタンス生成

  static Future<dynamic> signUp({required String email, required String password}) async{
    try{//ユーザーをfirebaseAuthに登録する処理
      UserCredential newAccount = await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
      print("firebaseAuth 登録 完了");
      return newAccount;
    } on FirebaseAuthException catch(e){
      print("Auth 登録 Error: $e ");
      return false;
    }
  }
}