import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../../../utilities/app_colors.dart';
import '../../../../../utilities/app_snack_bars.dart';
import '../../../../../utilities/authentication/authentication.dart';

class UserInfoEditPage extends StatelessWidget {
  UserInfoEditPage({Key? key, required this.email, required this.password})
      : super(key: key);

  final String email;
  final String password;

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => primaryFocus?.unfocus(),
      child: Scaffold(
        appBar: AppBar(
            iconTheme: IconThemeData(color: AppColors.mainBlue),
            title: Text('ユーザー情報更新')),
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
                    child: TextFormField(
                      decoration: const InputDecoration(
                        hintText: 'メールアドレス',
                      ),
                      controller: TextEditingController(text: email),
                      //controller: emailController,
                      autofocus: true,
                      keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.next,
                    ),
                  ),
                  SizedBox(
                    width: 300,
                    child: TextFormField(
                      decoration: const InputDecoration(
                          hintText: 'パスワード',
                          helperText: '※パスワードは6文字以上必要です'
                      ),
                      controller: TextEditingController(text: password),
                      keyboardType: TextInputType.visiblePassword,
                      textInputAction: TextInputAction.next,
                    ),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                      onPressed: (){
                      },
                      child: Text('プロフィール情報を更新'))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}