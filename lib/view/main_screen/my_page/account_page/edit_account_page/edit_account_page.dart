import 'package:chinese_study_applicaion/view/common_widget/buttons/normal_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../../model/account.dart';
import '../../../../../utilities/app_colors.dart';
import '../../../../../utilities/app_snack_bars.dart';
import '../../../../../utilities/authentication/authentication.dart';
import '../../../../../utilities/firestore/user_firestore.dart';
import '../../../../../utilities/provider/providers.dart';

class EditAccountPage extends ConsumerWidget {
  String name;

  EditAccountPage({Key? key, required this.name}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref){

    final email = ref.watch(currentUserProvider)!.email;
    final userId = ref.watch(currentUserProvider)!.uid;
    final name = ref.watch(nameProvider);

    void pressEditButtonFunction(TextEditingController nameController) async{
        if(nameController.text.isNotEmpty){
          Account updatedProfile = Account(
            id: userId,
            email: email!,
            name: nameController.text,
          );
          Authentication.myAccount = updatedProfile;//TODO:staticで定義していたmyAccountに最新のupdateした情報で上書きしている
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
    }

    final nameController = TextEditingController(text: name);
    final _formKey = GlobalKey<FormState>();

    print('${email.toString()}');

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
                      cursorColor: AppColors.mainBlue,
                      decoration: const InputDecoration(
                        labelStyle: TextStyle(color: AppColors.mainBlue),
                        labelText: '名前',
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            width: 2,
                            color: AppColors.mainBlue,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: AppColors.mainBlue, width: 2)
                        ),
                        //enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: AppColors.mainBlue)),
                        hintText: '名前',
                      ),
                      controller: nameController,
                      autofocus: true,
                      keyboardType: TextInputType.name,
                      textInputAction: TextInputAction.next,
                    ),
                  ),
                  name is Account ? Text('名前：$name') : Text('名前：'),
                  const SizedBox(height: 20),
                  NormalButton(
                      buttonText: "プロフィール情報更新",
                      onPressed: () => pressEditButtonFunction(nameController)
                  )

                  // ElevatedButton(
                  //     onPressed: () => pressEditButtonFunction(nameController),
                  //     child: Text('プロフィール情報を更新'))
                ],
              ),
            ),
          ),
        ),
      ),
    );


  }
}
