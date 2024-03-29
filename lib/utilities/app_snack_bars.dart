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
      content: const Text('アカウント新規登録に成功しました。'),
      shape: snackBarShape,
      backgroundColor: AppColors.subGreen);

  static final registeringSignUpIsFailed = SnackBar(
      content: const Text('アカウント新規登録に失敗しました'),
      shape: snackBarShape,
      backgroundColor: AppColors.mainPink);

  static final logInIsSuccessful = SnackBar(
    content: const Text('ログインに成功しました'),
    backgroundColor: AppColors.subGreen,
    shape: snackBarShape,
  );

  static final logInIsFailed = SnackBar(
      content: const Text('ログインに失敗しました'),
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

  //Eメール認証で送ったメールのリンクをまだタップしていない時のSnackBar
  static final sentVerificationEmail = SnackBar(
      content: const Text('認証メールをメールアドレス宛に送りました。メール内リンクをタップしてください'),
      shape: snackBarShape,
      backgroundColor: AppColors.subGreen);

  //プロフィール編集に成功時のSnackBar
  static final editingProfileIsSuccessful = SnackBar(
      content: const Text('プロフィール編集に成功しました'),
      shape: snackBarShape,
      backgroundColor: AppColors.subGreen);

  //プロフィール編集に失敗時のSnackBar
  static final editingProfileIsFailed = SnackBar(
      content: const Text('プロフィール編集に失敗しました'),
      shape: snackBarShape,
      backgroundColor: AppColors.mainPink);

  //問題と答えの投稿に成功時のSnackBar
  static final postingQuestionAndAnswerIsSuccessful = SnackBar(
      content: const Text('問題と答えの投稿に成功しました'),
      shape: snackBarShape,
      backgroundColor: AppColors.subGreen);

  //カテゴリの投稿に成功時のSnackBar
  static final postingCategoryIsSuccessful = SnackBar(
      content: const Text('カテゴリの投稿に成功しました'),
      shape: snackBarShape,
      backgroundColor: AppColors.subGreen);

  //問題の投稿に失敗時のSnackBar
  static final postingQuestionIsFailed = SnackBar(
      content: const Text('問題の投稿に失敗しました'),
      shape: snackBarShape,
      backgroundColor: AppColors.mainPink);

  //お気に入り問題登録成功時のSnackBar
  static final settingFavoriteQuestionIsSuccessful = SnackBar(
      content: const Text('お気に入り問題の登録に成功しました'),
      shape: snackBarShape,
      backgroundColor: AppColors.subGreen);

  //お気に入り問題登録失敗時のSnackBar
  static final settingFavoriteQuestionIsFailed = SnackBar(
      content: const Text('お気に入り問題の登録に失敗しました'),
      shape: snackBarShape,
      backgroundColor: AppColors.mainPink);

  //お気に入り問題削除成功時のSnackBar
  static final deletingFavoriteQuestionIsSuccessful = SnackBar(
      content: const Text('お気に入り問題の削除に成功しました'),
      shape: snackBarShape,
      backgroundColor: AppColors.subGreen);

  //お気に入り問題削除失敗時のSnackBar
  static final deletingFavoriteQuestionIsFailed = SnackBar(
      content: const Text('お気に入り問題の削除に失敗しました'),
      shape: snackBarShape,
      backgroundColor: AppColors.mainPink);

  //サインアウト成功時のSnackBar
  static final signOutAccountIsSuccessful = SnackBar(
      content: const Text('アカウントの削除に成功しました'),
      shape: snackBarShape,
      backgroundColor: AppColors.subGreen);
  //サインアウト削除失敗時のSnackBar
  static final signOutAccountIsFailed = SnackBar(
      content: const Text('アカウントの削除に失敗しました'),
      shape: snackBarShape,
      backgroundColor: AppColors.mainPink);

  //アカウントの削除成功時のSnackBar
  static final deletingAccountIsSuccessful = SnackBar(
      content: const Text('アカウントの削除に成功しました'),
      shape: snackBarShape,
      backgroundColor: AppColors.subGreen);
  //アカウントの削除失敗時のSnackBar
  static final deletingAccountIsFailed = SnackBar(
      content: const Text('アカウントの削除に失敗しました'),
      shape: snackBarShape,
      backgroundColor: AppColors.mainPink);





  //TODO:snackBarのshapeプロパティを管理
  static RoundedRectangleBorder snackBarShape = const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(topRight: Radius.circular(24),topLeft: Radius.circular(24))
  );

}
