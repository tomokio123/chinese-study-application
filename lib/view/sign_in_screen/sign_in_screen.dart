import 'package:flutter/material.dart';
import '../../utilities/app_colors.dart';
import '../login_screen/login_screen.dart';

class SignInScreen extends StatelessWidget {
  SignInScreen({Key? key}) : super(key: key);

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => primaryFocus?.unfocus(),
      child: Scaffold(
        appBar: AppBar(
            iconTheme: IconThemeData(color: AppColors.mainBlue),
            title: Text('SignInScreen')),
        backgroundColor: AppColors.mainWhite,
        body: SafeArea(
          child: Center(
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
                  child: TextField(
                    decoration: const InputDecoration(
                        hintText: 'パスワード',
                        helperText: '※パスワードは6文字以上必要です'
                    ),
                    controller: passwordController,
                    keyboardType: TextInputType.visiblePassword,
                    textInputAction: TextInputAction.done,
                  ),
                ),
                SizedBox(
                  width: 300,
                  child: TextFormField(
                    decoration: const InputDecoration(
                        hintText: 'パスワード(再入力)',
                        helperText: '※念の為再入力してください'
                    ),
                    controller: passwordController,
                    keyboardType: TextInputType.visiblePassword,
                    textInputAction: TextInputAction.done,
                  ),
                ),
                ElevatedButton(
                    onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreen()));
                      print('Go LoginScreen');
                    },
                    child: Text('Button'))
              ],
            ),
          ),
        ),
      ),
    );
  }
  Future<void> loginWithEmailAndPassword () async{

  }
}
