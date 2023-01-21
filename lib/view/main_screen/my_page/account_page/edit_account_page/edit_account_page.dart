import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../../model/account.dart';
import '../../../../../utilities/app_colors.dart';
import '../../../../../utilities/app_snack_bars.dart';
import '../../../../../utilities/authentication/authentication.dart';
import '../../../../../utilities/firestore/user_firestore.dart';
import '../../../../../utilities/provider/providers.dart';

class EditAccountPage extends ConsumerWidget {
  const EditAccountPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref){
    final TextEditingController nameController = TextEditingController();
    final _formKey = GlobalKey<FormState>();

    final userId = ref.watch(userProvider)!.uid;
    print('${userId.toString()}');

    return GestureDetector(
      onTap: () => primaryFocus?.unfocus(),
      child: Scaffold(
        appBar: AppBar(
            iconTheme: IconThemeData(color: AppColors.mainBlue),
            title: Text('プロフィール編集')),
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
                        hintText: '名前',
                      ),
                      controller: nameController,
                      autofocus: true,
                      keyboardType: TextInputType.name,
                      textInputAction: TextInputAction.next,
                    ),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                      onPressed: () async{
                        if(nameController.text.isNotEmpty){
                          Account updatedProfile = Account(
                            id: userId,
                            name: nameController.text,
                          );
                          Authentication.myAccount = updatedProfile;
                          var result = await UserFireStore.updateProfile(updatedProfile);
                          print(result);
                          if(result == true){
                            print('result == true');
                            ScaffoldMessenger.of(context).showSnackBar(AppSnackBar.editingProfileIsSuccessful);
                            Navigator.pop(context);
                          } else {
                            print('result == false');
                            ScaffoldMessenger.of(context).showSnackBar(AppSnackBar.editingProfileIsFailed);
                          }
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(AppSnackBar.blankIsNotFilled);
                          print('全部の空欄を埋めてください');
                        }
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
