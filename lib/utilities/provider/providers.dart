import 'package:chinese_study_applicaion/utilities/firestore/user_firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../model/account.dart';
import '../../view/common_widget/buttons/buttons.dart';
import '../authentication/authentication.dart';



//TODO: currentUser情報を持たせるProvider
final currentUserProvider = StateProvider.autoDispose((ref) {
  return FirebaseAuth.instance.currentUser;
});

//TODO: ボタンが押されているかどうかを保持するProvider
final buttonProvider = StateProvider.autoDispose((ref) {
  return false;
});

//TODO: 数を保持するProvider
final counterProvider = StateProvider((ref) => 0);

// ユーザー情報の受け渡しを行うためのProvider
final nameProvider = StateProvider.autoDispose((ref) {
  return '';
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
