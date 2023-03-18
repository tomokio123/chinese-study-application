import 'package:flutter/cupertino.dart';

import '../../../utilities/app_colors.dart';

class CurrentQuestionIndexContainer extends Container{
  final int currentQuestionIndex;
  CurrentQuestionIndexContainer({required this.currentQuestionIndex});

  @override
  // TODO: implement child
  Widget get child => Container(
    width: double.infinity,
    //color: AppColors.mainPink,
    padding: const EdgeInsets.only(top: 30),
    child: Center(
        child: Text("${currentQuestionIndex + 1} 問目",
          style: const TextStyle(fontSize: 20, decoration: TextDecoration.underline, color: AppColors.mainBlue),)
    ),
  );
}