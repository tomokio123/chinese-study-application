import 'package:chinese_study_applicaion/utilities/app_snack_bars.dart';
import 'package:chinese_study_applicaion/utilities/firestore/user_firestore.dart';
import 'package:chinese_study_applicaion/view/common_widget/buttons/normal_button.dart';
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

  @override
  Widget build(BuildContext context) {

    Future<void> registerUser() async{
      if(emailController.text.isNotEmpty &&
          passwordController.text.isNotEmpty &&
          reInputtedPasswordController.text.isNotEmpty
      ){
        if(passwordController.text == reInputtedPasswordController.text){
          var result = await Authentication.signUp(
              email: emailController.text, password: passwordController.text
          );
          if(result is UserCredential) {//resultにちゃんとした値が入ってきた時,つまり
            //　「resultに入ってる値の型がUserCredential型なら」って意味
            //Auth登録成功SnackBar
            ScaffoldMessenger.of(context).showSnackBar(AppSnackBar.registeringSignUpIsSuccessful);
            var _result = await createAccount(result.user!.uid);
            //resultに入っているuidを_resultに格納
            if (_result == true) {
              result.user!.sendEmailVerification();//Emailアドレスにメールを送る処理
              ScaffoldMessenger.of(context).showSnackBar(AppSnackBar.sentVerificationEmail);
              // uploadが成功し終わってから元の画面に戻るってしたいので
              Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreen()));
              print('Go LoginScreen');
            }
          }
          if(result is FirebaseAuthException){//resultにfirebase系のエラーが入ってきた時
            if(result.code == 'email-already-in-use'){
              ScaffoldMessenger.of(context).showSnackBar(AppSnackBar.emailAddressAlreadyInUse);
            }
            if(result.code == 'invalid-email')
              ScaffoldMessenger.of(context).showSnackBar(AppSnackBar.invalidEmailAddress);

          }
        }
        else {
          ScaffoldMessenger.of(context).showSnackBar(AppSnackBar.passwordSnackBar);
          print('パスワードが一致しません');
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(AppSnackBar.blankIsNotFilled);
        print('全部の空欄を埋めてください');
      }
    }


    return GestureDetector(
      onTap: () => primaryFocus?.unfocus(),
      child: Scaffold(
        appBar: AppBar(
            iconTheme: IconThemeData(color: AppColors.mainBlue),
            title: Text('アカウント登録')),
        backgroundColor: AppColors.mainWhite,
        body: SingleChildScrollView(
          child: SafeArea(
            child: Center(
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    SizedBox(height: 20),
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      width: 300,
                      child: TextFormField(
                        cursorColor: AppColors.mainBlue,
                        decoration: const InputDecoration(
                          focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: AppColors.mainBlue, width: 2)),
                          helperText: '※有効なメールアドレスを使用してください',
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
                        cursorColor: AppColors.mainBlue,
                        decoration: const InputDecoration(
                            focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: AppColors.mainBlue, width: 2)),
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
                        cursorColor: AppColors.mainBlue,
                        decoration: const InputDecoration(
                            focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: AppColors.mainBlue, width: 2)),
                            hintText: 'パスワード(再入力)',
                            helperText: '※念の為再入力してください'
                        ),
                        controller: reInputtedPasswordController,
                        keyboardType: TextInputType.visiblePassword,
                        textInputAction: TextInputAction.done,
                      ),
                    ),
                    const SizedBox(height: 20),
                    // ElevatedButton(
                    //     onPressed: () async{
                    //     },
                    //     child: Text('Button')
                    // ),
                    NormalButton(
                        buttonText: "アカウント登録",
                        onPressed: () async => registerUser),
                    SizedBox(height: 30),
                    Container(
                        width: 300,
                        child: Text('・確認メールを送りますので有効なメールアドレスを使用してください')),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<dynamic> createAccount(String uid) async{//FireStoreに送るデータ
    //!でnull回避 await をつけておく一応
    Account newAccount = Account(//データのオブジェクト。所持するデータたち
      //クライアント側から送るデータの「管」を作るイメージ。この後DB側のそのデータを受け取る「皿」たちとくっつける。
        id: uid,
        email: emailController.text,
        password: passwordController.text
    );
    var _result = await UserFireStore.setUser(newAccount);
    return _result;
  }
}
