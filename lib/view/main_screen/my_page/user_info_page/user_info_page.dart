import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../utilities/app_colors.dart';
import '../account_page/edit_account_page/edit_account_view_model.dart';

class UserInfoPage extends ConsumerWidget {
  const UserInfoPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final email = ref.watch(currentUserProvider)!.email;
    print('${email.toString()}');
    final password = ref.watch(currentUserProvider)!.uid;
    print('${password.toString()}');

    final _formKey = GlobalKey<FormState>();
    final Size size = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: () => primaryFocus?.unfocus(),
      child: Scaffold(
        appBar: AppBar(
            iconTheme: IconThemeData(color: AppColors.mainBlue),
            title: Text('ユーザー情報確認')),
        backgroundColor: AppColors.mainWhite,
        body: SafeArea(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                SizedBox(height: 60),
                Text('現在のユーザー情報',style: TextStyle(fontSize: 30)),
                SizedBox(height: 30),
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  width: size.width,
                  child: Column(
                    children: [
                      Text('メールアドレス',style: TextStyle(fontSize: 15)),
                      SizedBox(height: 10),
                      Text('$email',style: TextStyle(fontSize: 15)),
                    ],
                  )
                ),
                SizedBox(height: 10),
                Container(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    width: size.width,
                    child: Column(
                      children: [
                        Text('※ユーザId(自動の文字列が割り当てられます)',style: TextStyle(fontSize: 15)),
                        SizedBox(height: 10),
                        Text('$password',style: TextStyle(fontSize: 15)),
                      ],
                    )
                ),
                // ElevatedButton(//一旦UserInfoEditPageは無しで。
                //     onPressed: (){
                //       Navigator.push(context, MaterialPageRoute(builder: (context) =>
                //           UserInfoEditPage(
                //               email: email,
                //               password: password)));
                //     },
                //     child: Text('プロフィール情報を更新する'))
              ],
            ),
          ),
        ),
      ),
    );
  }
}