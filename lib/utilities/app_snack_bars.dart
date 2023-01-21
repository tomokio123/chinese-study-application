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
      content: const Text('FirebaseAuthログインに失敗しました'),
      shape: snackBarShape,
      backgroundColor: AppColors.mainPink);

  static final incorrectPasswordOrEmailAddress = SnackBar(
      content: const Text('パスワードもしくはメールアドレスが間違っています'),
      shape: snackBarShape,
      backgroundColor: AppColors.mainPink);

  //SignUp時の例外処理に引っかかった時のSnackBar
  static final emailAddressAlreadyInUse = SnackBar(
      content: const Text('そのメールアドレスを持つアカウントはすでに存在します'),
      shape: snackBarShape,
      backgroundColor: AppColors.mainPink);

  static final invalidEmailAddress = SnackBar(
      content: const Text('メールアドレスが無効です'),
      shape: snackBarShape,
      backgroundColor: AppColors.mainPink);

  //Eメール認証で送ったメールのリンクをまだタップしていない時のSnackBar
  static final yourEmailAddressIsNotApproved = SnackBar(
      content: const Text('メールアドレス認証をしてください'),
      shape: snackBarShape,
      backgroundColor: AppColors.mainPink);

  //プロフィール編集に成功時のSnackBar
  static final editingProfileIsSuccessful = SnackBar(
      content: const Text('プロフィール編集に成功しました'),
      shape: snackBarShape,
      backgroundColor: AppColors.mainGreen);

  //プロフィール編集に失敗c時のSnackBar
  static final editingProfileIsFailed = SnackBar(
      content: const Text('プロフィール編集に失敗しました'),
      shape: snackBarShape,
      backgroundColor: AppColors.mainPink);




  //TODO:snackBarのshapeプロパティを管理
  static RoundedRectangleBorder snackBarShape = const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(topRight: Radius.circular(24),topLeft: Radius.circular(24))
  );

}
