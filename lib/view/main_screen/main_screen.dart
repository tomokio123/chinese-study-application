import 'package:chinese_study_applicaion/utilities/app_colors.dart';
import 'package:chinese_study_applicaion/utilities/provider/providers.dart';
import 'package:chinese_study_applicaion/view/main_screen/book_mark_page/book_mark_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../utilities/firestore/favorite_question_firestore.dart';
import '../../utilities/firestore/user_firestore.dart';
import 'my_page/my_page.dart';
import 'one_on_one_list_page/school_page.dart';
import 'test_list_page/test_categories_page.dart';
import 'vocabulary_list_page/vocabulary_categories_page.dart';

class MainScreen extends ConsumerWidget {
  const MainScreen({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final int _selectedIndex = ref.watch(mainScreenCurrentSelectedIndexProvider);
    final String currentUserId = UserFireStore.currentUserId;//自分のユーザIDを取得したい

    final List<Widget> _widgetOptions = <Widget>[
      TestCategoriesPage(),
      //OneOnOneListPage(),
      VocabularyCategoriesPage(),
      BookMarkPage(currentUserId: currentUserId),
      MyPage(),
    ];

    Widget _BottomNavigationBar(selectedIndex){
      void _onItemTapped(int index) async{
        //var favoriteQuestionIdList = await FavoriteQuestionFireStore.favoriteQuestions.get();
        ref.read(mainScreenCurrentSelectedIndexProvider.notifier).state = index;
      }
      return BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.quiz_outlined),
            label: 'テスト',
          ),
          // BottomNavigationBarItem(
          //   icon: Icon(Icons.checklist),
          //   label: '一問一答',
          // ),
          BottomNavigationBarItem(
            icon: Icon(Icons.school_outlined),
            label: '単語帳',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bookmark_border),
            label: 'やり直し',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline_outlined),
            label: 'マイページ',
          ),
        ],
        currentIndex: selectedIndex,
        type: BottomNavigationBarType.fixed,
        //Flutterの中のコードで３以上なら「type: BottomNavigationBarType.shifting」になるからこれ指定しないと見えなくなる
        selectedItemColor: AppColors.mainBlue,
        onTap: _onItemTapped,
      );
    }

    return Scaffold(
      body: Column(
        //Columnのなかのchildren要素は高さがないとエラー出るので高さ指定するOrExpandedで囲むかどちらかの処理をする
        children: [
          Expanded(
            child: Container(
              child: _widgetOptions.elementAt(_selectedIndex),
            )
          ),
        ],
      ),
      bottomNavigationBar: _BottomNavigationBar(_selectedIndex)
    );
  }
}