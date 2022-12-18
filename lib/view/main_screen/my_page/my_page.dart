import 'package:chinese_study_applicaion/utilities/app_colors.dart';
import 'package:chinese_study_applicaion/view/main_screen/main_screen.dart';
import 'package:chinese_study_applicaion/view/main_screen/my_page/account_page/edit_account_page/edit_account_page.dart';
import 'package:chinese_study_applicaion/view/main_screen/my_page/other_setting_page/announcement_page.dart';
import 'package:chinese_study_applicaion/view/main_screen/my_page/other_setting_page/tutorial_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:page_transition/page_transition.dart';
import 'package:settings_ui/settings_ui.dart';

import '../../first_screen/first_screen.dart';
import 'my_page_view_model.dart';

class MyPage extends ConsumerWidget {

  const MyPage({Key? key}) : super(key: key);
  // [SliverAppBar]s are typically used in [CustomScrollView.slivers], which in
  final bool _isSignin = true;//ログイン状態

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final checkedCurrentValue = ref.watch(myPageViewModelProvider);

    return Scaffold(
        appBar: AppBar(title: Text('マイページ')),
        body: SettingsList(
          sections: [
            SettingsSection(
              title: Text('アカウント情報'),
              tiles: <SettingsTile>[
                SettingsTile.navigation(
                  onPressed: (value) => Navigator.push(context, MaterialPageRoute(builder: (context) => EditAccountPage())),
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
                  onPressed: null,
                  leading: Icon(Icons.language),
                  title: Text('ログイン状況'),
                  trailing: Expanded(child: Container()),
                  value: Text(_isSignin == true ? '有効' : '無効'),
                ),
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
              ],
            ),
            SettingsSection(
              title: Text('その他の設定'),
              tiles: <SettingsTile>[
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
            if(_isSignin == true)SettingsSection(
              tiles: <SettingsTile>[
                SettingsTile.navigation(
                  onPressed: (value) => _logOutDialogBuilder(context),
                  title: Text('サインアウト',style: TextStyle(color: AppColors.mainRed)),
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
              onPressed: () {
                Navigator.push(context, PageTransition(
                    type: PageTransitionType.scale,
                    alignment: Alignment.bottomCenter,
                    child: MainScreen()));
              },
            ),
          ],
        );
      },
    );
  }
}