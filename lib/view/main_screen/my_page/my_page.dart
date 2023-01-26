import 'package:chinese_study_applicaion/utilities/app_colors.dart';
import 'package:chinese_study_applicaion/view/login_screen/login_screen.dart';
import 'package:chinese_study_applicaion/view/main_screen/my_page/account_page/edit_account_page/edit_account_page.dart';
import 'package:chinese_study_applicaion/view/main_screen/my_page/other_setting_page/announcement_page.dart';
import 'package:chinese_study_applicaion/view/main_screen/my_page/other_setting_page/tutorial_page.dart';
import 'package:chinese_study_applicaion/view/main_screen/my_page/user_info_page/user_info_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:settings_ui/settings_ui.dart';
import '../../../utilities/authentication/authentication.dart';
import '../../../utilities/provider/providers.dart';
import 'my_page_view_model.dart';

class MyPage extends ConsumerWidget {

  const MyPage({Key? key}) : super(key: key);

  // [SliverAppBar]s are typically used in [CustomScrollView.slivers], which in
  final bool _isSignIn = true;//ログイン状態
  final bool _isOwner = true;//ログイン状態

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final userId = ref.watch(currentUserProvider)!.uid;
    print('${userId.toString()}');

    return Scaffold(
        appBar: AppBar(title: Text('マイページ')),
        body: SettingsList(
          sections: [
            SettingsSection(
              title: Text('アカウント情報'),
              tiles: <SettingsTile>[
                SettingsTile.navigation(
                  onPressed: (value) => Navigator.push(
                      context, MaterialPageRoute(builder: (context) => EditAccountPage(name: '初期値です')
                  )),
                  leading: Icon(Icons.person_outline_outlined),
                  title: Text('プロフィール'),
                  value: Text('編集'),
                ),
              ],
            ),
            SettingsSection(
              title: Text('ユーザー情報'),
              tiles: <SettingsTile>[
                SettingsTile.navigation(
                  onPressed: (value) => Navigator.push(
                      context, MaterialPageRoute(builder: (context) => UserInfoPage()
                  )),
                  leading: Icon(Icons.language),
                  title: Text('詳細情報'),
                  value: Text('確認'),
                ),
              ],
            ),
            SettingsSection(
              title: Text('その他の設定'),
              tiles: <SettingsTile>[
                SettingsTile.switchTile(
                  enabled: true,
                  activeSwitchColor: AppColors.mainBlue,
                  initialValue: true,
                  //initialValue: checkedCurrentValue,
                  //onPressed: (value){ref.read(myPageViewModelProvider.notifier).checking(value);},
                  onToggle: (value) {
                    ref.read(myPageViewModelProvider);
                  },
                  leading: Icon(Icons.format_paint),
                  title: Text('音声読み上げ'),
                ),
                SettingsTile.navigation(
                  onPressed: (value){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=> AnnouncementPage()));
                  },
                  leading: Icon(Icons.language),
                  title: Text('お知らせ'),
                  value: Text(''),
                ),
                SettingsTile.navigation(
                  onPressed: (value){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=> TutorialPage()));
                  },
                  leading: Icon(Icons.language),
                  title: Text('チュートリアル'),
                  value: Text(''),
                ),
              ],
            ),
            if(_isOwner == true)SettingsSection(
              title: Text('問題投稿'),
              tiles: <SettingsTile>[
                SettingsTile.navigation(
                  onPressed: null,
                  leading: Icon(Icons.language),
                  title: Text('問題投稿'),
                  value: Text('有効'),
                ),
              ],
            ),
            if(_isSignIn == true)SettingsSection(
              tiles: <SettingsTile>[
                SettingsTile.navigation(
                  onPressed: (value) => _logOutDialogBuilder(context),
                  title: Text('サインアウト',style: TextStyle(color: AppColors.mainRed)),
                ),
              ],
            ),
            if(_isSignIn == true)SettingsSection(
              tiles: <SettingsTile>[
                SettingsTile.navigation(
                  onPressed: (value) => _deleteAccountDialogBuilder(context, userId),
                  title: Text('アカウント削除',style: TextStyle(color: AppColors.mainRed)),
                ),
              ],
            ),
          ],
        ),
    );
  }

  Future<void> _logOutDialogBuilder(BuildContext context) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: const Text('サインアウト'),
          content: const Text('本当にサインアウトしてよろしいでしょうか？'),
          actions: <Widget>[
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: Text('戻る'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text('サインアウト'),
              onPressed: () async{
                await Authentication.signOut();
                while(Navigator.canPop(context)){//Navigator.canPop(context)＝「popできる状態だったら」
                  Navigator.pop(context);
                }
                //popできないような状態になったらpushreplacement　＝　その画面を破棄して新しいルートに遷移する
                Navigator.pushReplacement(context, MaterialPageRoute(
                    builder: (context) => LoginScreen()
                ));
                // Navigator.push(context, PageTransition(
                //     type: PageTransitionType.scale,
                //     alignment: Alignment.bottomCenter,
                //     child: LoginScreen()));
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _deleteAccountDialogBuilder(BuildContext context, String ref) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: const Text('アカウント削除'),
          content: const Text('本当にアカウント削除してよろしいでしょうか？'),
          actions: <Widget>[
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: Text('戻る'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text('アカウント削除'),
              onPressed: (){
                //まだ未記入
              },
            ),
          ],
        );
      },
    );
  }
}