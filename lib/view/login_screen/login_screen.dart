import 'package:chinese_study_applicaion/utilities/firestore/user_firestore.dart';
import 'package:chinese_study_applicaion/view/common_widget/buttons/normal_button.dart';
import 'package:chinese_study_applicaion/view/main_screen/main_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../utilities/app_colors.dart';
import '../../utilities/app_snack_bars.dart';
import '../../utilities/authentication/authentication.dart';
import '../sign_in_screen/sign_up_screen.dart';

class LoginScreen extends ConsumerWidget {
  LoginScreen({Key? key}) : super(key: key);

   final TextEditingController emailController = TextEditingController();
   final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    Future<void> loginFunction() async{
      if(emailController.text.isNotEmpty && passwordController.text.isNotEmpty) {
        var result = await Authentication.emailSignIn(email: emailController.text, password: passwordController.text);
        if(result is UserCredential){
          //返ってきた値がUserCredential型なら(ちゃんとFirebaseAuthに則ったものなら)
          if(result.user!.emailVerified == true){
            var _result = await UserFireStore.getUser(result.user!.uid);
            if(_result == true){//_resultがtrue返ってきてユーザ情報が格納されていたら
              //pushReplacementは「遷移後に前のページに戻れなくなる」ナビゲーション
              ScaffoldMessenger.of(context).showSnackBar(AppSnackBar.logInIsSuccessful);
              print('FirebaseAuthログインに成功しました');
              Navigator.push(context, MaterialPageRoute(builder: (context) => const MainScreen()));
            } else {//_resultがfalseの時の対応。だがそんなことあるのか？要調査
              ScaffoldMessenger.of(context).showSnackBar(AppSnackBar.logInIsFailed);
              print('FirebaseAuthログインに失敗しました');
              print('${_result}');
            }
          } else {
            ScaffoldMessenger.of(context).showSnackBar(AppSnackBar.yourEmailAddressIsNotApproved);
            print('メール認証できてません');
          }
        } else {
          ScaffoldMessenger.of(context).showSnackBar(AppSnackBar.incorrectPasswordOrEmailAddress);
          print('パスワード或いはメールアドレスが間違っています');
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(AppSnackBar.blankIsNotFilled);
        print('全部の空欄を埋めてください');
      }
    }

    return GestureDetector(
      onTap: () => primaryFocus?.unfocus(),
      child: Scaffold(
        backgroundColor: AppColors.mainWhite,
        body: SingleChildScrollView(//bodyにSingleSingleChildScrollViewでいい感じになる
          child: SafeArea(
            child: Center(
              child: Column(
                children: [
                  SizedBox(height: 50),
                  Text('ログイン',style: TextStyle(fontSize: 35)),
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    width: 300,
                    child: TextFormField(
                      autofillHints: const [AutofillHints.email],
                      cursorColor: AppColors.mainBlue,
                      decoration: const InputDecoration(
                        focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: AppColors.mainBlue, width: 2)),
                          hintText: 'メールアドレス',
                          helperText: '※有効なメールアドレスを使用してください'
                      ),
                      controller: emailController,
                      autofocus: true,
                      keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.next,
                    ),
                  ),
                  SizedBox(
                    width: 300,
                    child: TextFormField(
                      autofillHints: const [AutofillHints.password],
                      cursorColor: AppColors.mainBlue,
                      decoration: const InputDecoration(
                        focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: AppColors.mainBlue, width: 2)),
                        //enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: AppColors.mainBlue)),
                        hintText: 'パスワード',
                        helperText: '※パスワードは6文字以上にしてください'
                      ),
                      controller: passwordController,
                      keyboardType: TextInputType.visiblePassword,
                      textInputAction: TextInputAction.done,
                    ),
                  ),
                  SizedBox(height: 30),
                  RichText( //テキストの一部だけ色やサイズなどを変えられるWidget
                      text: TextSpan(//キーワードなどをハイライト(強調)表示するWidget
                          style: TextStyle(color: Colors.black),
                          children: [
                            TextSpan(text: 'アカウント作成していない方は'),
                            TextSpan(text: 'こちら',
                                style: const TextStyle(color: AppColors.mainBlue),
                                recognizer: TapGestureRecognizer()..onTap = (){
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => SignUpScreen()));
                              print('Tapped アカウント作成していない方はこちら');
                                }
                            )
                          ]
                      )
                  ),
                  SizedBox(height: 30),
                  // ElevatedButton(
                  //     onPressed: () async{
                  //
                  //       },
                  //     child: Text('Button')
                  // ),
                  NormalButton(
                    onPressed: () async => loginFunction(),
                    buttonText: "ログイン",

                  ),
                  SizedBox(height: 50),
                  Container(
                      width: 300,
                      child: Text('・ログインに不具合などが発生する場合アプリの再起動で改善する場合がございます')),
                ],
              ),
              /*child: ElevatedButton(
                  onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const MainScreen()));
                  },
                  child: const Text('次の画面へ遷移')),*/
            ),
          ),
        ),
      ),
    );
  }
}
