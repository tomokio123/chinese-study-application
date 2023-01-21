import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


//TODO:ユーザー情報の受け渡しを行うためのProvider
final userProvider = StateProvider((ref) {
  return FirebaseAuth.instance.currentUser;
});

//TODO: currentUser情報を持たせるProvider
final currentUserProvider = StateProvider((ref) {
  return FirebaseAuth.instance.currentUser;
});

// //TODO: currentUserのメールアドレスを持たせるProvider
// final emailProvider = StateProvider((ref) {
//   return FirebaseAuth.instance.currentUser;
// });