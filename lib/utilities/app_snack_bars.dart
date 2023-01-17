import 'package:chinese_study_applicaion/Utilities/app_colors.dart';
import 'package:flutter/material.dart';

class AppSnackBar {
  String snackBarContext;
  AppSnackBar({required this.snackBarContext});

  //passwordが一致しない時のSnackBar
  static final passwordSnackBar = SnackBar(
      content: Text('パスワードが一致しません'),
      backgroundColor: AppColors.mainPink);
  //SignInのパスワードと再代入が一致しない時のSnackBar
  static final signInButtonSnackBar = SnackBar(
      content: Text('全部の空欄を埋めてください'),
      backgroundColor: AppColors.mainPink);
  static final registeringSignUpIsSuccessful = SnackBar(
      content: Text('FirebaseAuth登録成功しました'),
      backgroundColor: AppColors.mainGreen);
  static final registeringSignUpIsFailed = SnackBar(
      content: Text('FirebaseAuth登録に失敗しました'),
      backgroundColor: AppColors.mainPink);
}
