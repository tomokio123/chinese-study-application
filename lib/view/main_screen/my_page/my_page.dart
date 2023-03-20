import 'package:chinese_study_applicaion/utilities/app_colors.dart';
import 'package:chinese_study_applicaion/utilities/firestore/favorite_question_firestore.dart';
import 'package:chinese_study_applicaion/view/login_screen/login_screen.dart';
import 'package:chinese_study_applicaion/view/main_screen/my_page/account_page/edit_account_page/edit_account_page.dart';
import 'package:chinese_study_applicaion/view/main_screen/my_page/other_setting_page/announcement_list_page.dart';
import 'package:chinese_study_applicaion/view/main_screen/my_page/other_setting_page/tutorial_page.dart';
import 'package:chinese_study_applicaion/view/main_screen/my_page/post_question_page/post_question_page.dart';
import 'package:chinese_study_applicaion/view/main_screen/my_page/user_info_page/user_info_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:settings_ui/settings_ui.dart';
import '../../../utilities/authentication/authentication.dart';
import '../../../utilities/firestore/user_firestore.dart';
import '../../../utilities/provider/providers.dart';
import 'my_page_view_model.dart';

class MyPage extends ConsumerWidget {

  const MyPage({Key? key}) : super(key: key);
  // [SliverAppBar]s are typically used in [CustomScrollView.slivers], which in
  final bool _isSignIn = true;//ログイン状態

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final userId = ref.watch(currentUserProvider)!.uid;
    final currentUserEmail = ref.watch(currentUserProvider)!.email;
    print('MyPage:$currentUserEmail');

    return Scaffold(
        appBar: AppBar(title: Text('マイページ'),automaticallyImplyLeading: false,),
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
                  initialValue: false,
                  //onPressed: (value){ref.read(myPageViewModelProvider.notifier).checking(value);},
                  onToggle: (value) {
                    ref.watch(myPageViewModelProvider.notifier).state = value;
                  },
                  leading: Icon(Icons.format_paint),
                  title: Text('音声読み上げ(現在利用不可)'),
                ),
                SettingsTile.navigation(
                  onPressed: (value){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=> AnnouncementListPage()));
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
            if(currentUserEmail == 't.fukuyama0123@gmail.com')SettingsSection(
              title: Text('問題投稿'),
              tiles: <SettingsTile>[
                SettingsTile.navigation(
                  onPressed: (value){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=> PostQuestionPage()));
                  },
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
              onPressed: () async{
                final String userId = UserFireStore.currentUserId;
                //TODO:ここ実装する。アカウントを削除する際に
                // User/FavoriteQuestionなどのユーザIdが絡むものも削除しないとデータベースに残ってしまう
                // Authentication.deleteAuth()以外にもsignOut()も同時に処理しないといけない
                await UserFireStore.deleteUser(userId);//成功
                await FavoriteQuestionFireStore.deleteAllFavoriteQuestion();// 成功
                await Authentication.deleteAuth();
                await Authentication.signOut();
                // while(Navigator.canPop(context)){//Navigator.canPop(context)＝「popできる状態だったら」
                //   Navigator.pop(context);
                // }
                //popできないような状態になったらpushreplacement　＝　その画面を破棄して新しいルートに遷移する
                Navigator.pushReplacement(context, MaterialPageRoute(
                    builder: (context) => LoginScreen()
                ));
              },
            ),
          ],
        );
      },
    );
  }
}