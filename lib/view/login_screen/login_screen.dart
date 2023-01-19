import 'package:chinese_study_applicaion/view/main_screen/main_screen.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../utilities/app_colors.dart';
import '../../utilities/app_snack_bars.dart';
import '../sign_in_screen/sign_up_screen.dart';

class LoginScreen extends ConsumerWidget {
  LoginScreen({Key? key}) : super(key: key);

   final TextEditingController emailController = TextEditingController();
   final TextEditingController passController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onTap: () => primaryFocus?.unfocus(),
      child: Scaffold(
        backgroundColor: AppColors.mainWhite,
        body: SafeArea(
          child: Center(
            child: Column(
              children: [
                SizedBox(height: 50),
                Text('LoginScreen',style: TextStyle(fontSize: 35)),
                Text('a@gmail.com',style: TextStyle(fontSize: 10)),
                Text('aaaaaa',style: TextStyle(fontSize: 10)),
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  width: 300,
                  child: TextFormField(
                    autofillHints: const [AutofillHints.email],
                    cursorColor: AppColors.mainBlue,
                    decoration: const InputDecoration(
                      focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: AppColors.mainBlue, width: 2)),
                      hintText: 'メールアドレス',
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
                    controller: passController,
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
                ElevatedButton(
                    onPressed: () async{
                      if(emailController.text.isNotEmpty && passController.text.isNotEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(AppSnackBar.logInIsSuccessful);
                        print('FirebaseAuthログインに成功しました');
                        Navigator.push(context, MaterialPageRoute(builder: (context) => const MainScreen()));
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(AppSnackBar.blankIsNotFilled);
                        print('全部の空欄を埋めてください');
                        ScaffoldMessenger.of(context).showSnackBar(AppSnackBar.logInIsFailed);
                        print('FirebaseAuthログインに失敗しました');
                      }
                      },
                    child: Text('Button'))
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
    );
  }
}
