import 'package:chinese_study_applicaion/Utilities/app_colors.dart';
import 'package:flutter/material.dart';

class AppSnackBar {
  //TODO:さまざまなSnackBarを管理

  //passwordが一致しない時のSnackBar
  static final passwordSnackBar = SnackBar(
    content: const Text('パスワードが一致しません'),
    backgroundColor: AppColors.mainPink,
    shape: snackBarShape
  );

  //SignInのパスワードと再代入が一致しない時のSnackBar
  static final blankIsNotFilled = SnackBar(
    content: const Text('全部の空欄を埋めてください'),
    backgroundColor: AppColors.mainPink,
    shape: snackBarShape
  );

  static final registeringSignUpIsSuccessful = SnackBar(
      content: const Text('FirebaseAuth登録成功しました。また、メールアドレス宛に確認メールを送りました。'),
      shape: snackBarShape,
      backgroundColor: AppColors.mainGreen);

  static final registeringSignUpIsFailed = SnackBar(
      content: const Text('FirebaseAuth登録に失敗しました'),
      shape: snackBarShape,
      backgroundColor: AppColors.mainPink);

  static final logInIsSuccessful = SnackBar(
    content: const Text('FirebaseAuthログインに成功しました'),
    backgroundColor: AppColors.mainGreen,
    shape: snackBarShape,
  );

  static final logInIsFailed = SnackBar(
      content: Text('FirebaseAuthログインに失敗しました'),
      shape: snackBarShape,
      backgroundColor: AppColors.mainPink);



  //TODO:snackBarのshapeプロパティを管理
  static RoundedRectangleBorder snackBarShape = const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(topRight: Radius.circular(24),topLeft: Radius.circular(24))
  );

}
