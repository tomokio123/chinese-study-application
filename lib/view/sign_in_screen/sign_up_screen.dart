import 'package:chinese_study_applicaion/utilities/firestore/user_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../model/account.dart';
import '../../utilities/app_colors.dart';
import '../../utilities/authentication/authentication.dart';
import '../login_screen/login_screen.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({Key? key}) : super(key: key);

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController reInputtedPasswordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  // SnackBarを定義
  final signInButtonSnackBar = SnackBar(
    // SnackBarの背景色
      backgroundColor: AppColors.mainPink,
    content: Text('全部の空欄を埋めてください')
  );
  final passwordSnackBar = SnackBar(
    // SnackBarの背景色
      backgroundColor: AppColors.mainPink,
      content: Text('パスワードが一致していません')
  );

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => primaryFocus?.unfocus(),
      child: Scaffold(
        appBar: AppBar(
            iconTheme: IconThemeData(color: AppColors.mainBlue),
            title: Text('SignUpScreen')),
        backgroundColor: AppColors.mainWhite,
        body: SafeArea(
          child: Center(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  SizedBox(height: 20),
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    width: 300,
                    child: TextField(
                      decoration: const InputDecoration(
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
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          print('Please enter some text');
                          return 'Please enter some text';
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                          hintText: 'パスワード',
                          helperText: '※パスワードは6文字以上必要です'
                      ),
                      controller: passwordController,
                      keyboardType: TextInputType.visiblePassword,
                      textInputAction: TextInputAction.next,
                    ),
                  ),
                  SizedBox(
                    width: 300,
                    child: TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          print('Please enter some text');
                          return 'Please enter some text';
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                          hintText: 'パスワード(再入力)',
                          helperText: '※念の為再入力してください'
                      ),
                      controller: reInputtedPasswordController,
                      keyboardType: TextInputType.visiblePassword,
                      textInputAction: TextInputAction.done,
                    ),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                      onPressed: () async{
                        if(emailController.text.isNotEmpty &&
                        passwordController.text.isNotEmpty &&
                        reInputtedPasswordController.text.isNotEmpty
                        ){
                          if(passwordController.text == reInputtedPasswordController.text){
                            var result = await Authentication.signUp(email: emailController.text, pass: passwordController.text);
                            if(result is UserCredential) {
                              //　「resultに入ってる値の型がUserCredential型なら」って意味
                              var _result = await createAccount(result.user!.uid);//resultに入っているuidを_resultに格納
                              if (_result == true) {
                                result.user!.sendEmailVerification();//Emailアドレスにメールを送る処理
                                // uploadが成功し終わってから元の画面に戻るってしたいので
                                Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreen()));
                                print('Go LoginScreen');
                              }
                            }
                          }
                          else {
                            ScaffoldMessenger.of(context).showSnackBar(passwordSnackBar);
                            print('パスワードが一致しません');
                          }
                        } else {
                          // SnackBarを表示する
                          ScaffoldMessenger.of(context).showSnackBar(signInButtonSnackBar);
                          print('全部の空欄を埋めてください');
                        }
                      },
                      child: Text('Button'))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<dynamic> createAccount(String uid) async{
    //!でnull回避 await をつけておく一応
    Account newAccount = Account(
        email: emailController.text,
        password: passwordController.text
    );
    var _result = await UserFirestore.setUser(newAccount);
    return _result;
  }
}
