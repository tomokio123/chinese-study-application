import 'package:flutter/cupertino.dart';

class MyPageModel extends ChangeNotifier{
  bool checkedCurrentValue = true;

  void changeText() {
    checkedCurrentValue = false;
    notifyListeners();
  }
}