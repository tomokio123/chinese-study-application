import 'package:chinese_study_applicaion/view/main_screen/my_page/my_page.dart';
import 'package:provider/provider.dart';
import 'package:riverpod/riverpod.dart';

final myPageViewModelProvider = StateProvider<bool>((ref) {
  return false;
});

//final buttonProvider = StateProvider.autoDispose<bool>((ref) {
//   return false;
// });