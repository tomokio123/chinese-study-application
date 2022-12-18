import 'package:chinese_study_applicaion/view/main_screen/my_page/my_page.dart';
import 'package:provider/provider.dart';
import 'package:riverpod/riverpod.dart';

final myPageViewModelProvider = StateNotifierProvider<MyPageViewModel, bool>((ref) {
  return MyPageViewModel(ref);
});

class MyPageViewModel extends StateNotifier<bool>{
  Ref ref;
  MyPageViewModel(this.ref) : super(false);
  void checking(z) {
    // Counter は `ref` を使って他のプロバイダーを利用することができる
    final checkedCurrentValue = ref.read(myPageViewModelProvider);
  }
}