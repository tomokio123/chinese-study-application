import 'package:chinese_study_applicaion/utilities/firestore/user_firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../model/account.dart';
import '../authentication/authentication.dart';



//TODO: currentUser情報を持たせるProvider
final currentUserProvider = StateProvider.autoDispose((ref) {
  return FirebaseAuth.instance.currentUser;
});

//TODO: ボタンが押されているかどうかを保持するProvider
final buttonProvider = StateProvider.autoDispose<bool>((ref) {
  return false;
});
//TODO: 正解かどうかを保持するProvider
final isCorrectProvider = StateProvider.autoDispose<bool>((ref) {
  return false;
});

//TODO: 正解数を保持するProvider
final numberOfCorrectAnswersProvider = StateProvider<int>((ref) {
  return 0;//AutoDispose　　にすると正答数をResult画面に送る前に正答数
});

//TODO:現在の単語帳ナンバーのindexを保持するProvider
final currentVocabularyIndexProvider = StateProvider.autoDispose<int>((ref) {
  return 0;
});
//TODO:現在のquestion_idのindexを保持するProvider
final currentQuestionIndexProvider = StateProvider((ref) => 0);

// TODO:ユーザー情報の受け渡しを行うためのProvider
final nameProvider = StateProvider.autoDispose((ref) {
  return '';
});

// TODO:ドラムロールの値を保持するProvider
final dramProvider = StateProvider.autoDispose((ref) {
  return 'fruits';
});
// final nameProvider = StateProvider.autoDispose((ref) {
//   var result = ProvidersViewModel.fetchUserName();
//   if(result is String){return result;}
//   if(result == null){return '';}
//   return result;
// });

class ProvidersViewModel {
  static final _fireStoreInstance = FirebaseFirestore.instance;
  static final CollectionReference users = _fireStoreInstance.collection('users');
  static final currentUserId = FirebaseAuth.instance.currentUser!.uid;

  static Future<dynamic> fetchUserName() async{
    try{
      DocumentSnapshot documentSnapshot = await users.doc(currentUserId).get();
      Map<String, dynamic> data = documentSnapshot.data() as Map<String, dynamic>;
      Account myAccount = Account(
          id: currentUserId,
          name: data['name']
      );
      Authentication.myAccount = myAccount;
      print('ユーザー取得完了inFetchUserName');
      return myAccount.name;
    } on FirebaseException catch(e){
      print('ユーザー取得完了エラー: $e');
      return null;
    }
  }
}
