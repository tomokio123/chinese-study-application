import 'package:chinese_study_applicaion/utilities/app_colors.dart';
import 'package:chinese_study_applicaion/view/main_screen/book_mark_page/book_mark_page.dart';
import 'package:chinese_study_applicaion/view/main_screen/school_page/school_page.dart';
import 'package:chinese_study_applicaion/view/main_screen/test_page/test_page.dart';
import 'package:chinese_study_applicaion/view/main_screen/words_list_page/words_list_page.dart';
import 'package:flutter/material.dart';

import 'my_page/my_page.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 4;
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
  static final List<Widget> _widgetOptions = <Widget>[
    WordsListPage(),
    const SchoolPage(),
    TestPage(),
    const BookMarkPage(),
    MyPage(),
  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        //Columnのなかのchildren要素は高さがないとエラー出るので高さ指定するOrExpandedで囲むかどちらかの処理をする
        children: [
          Expanded(
            child: Container(
              child: _widgetOptions.elementAt(_selectedIndex),
            )
          ),
          /*Container(
            height: 40,
            color: Colors.yellow,
            child: Center(
              child: Text('MainScreen'),
            )
          )*/
        ],
      ),
      bottomNavigationBar: _BottomNavigationBar(_selectedIndex)
    );
  }

  Widget _BottomNavigationBar(selectedIndex){
    return BottomNavigationBar(
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.school_outlined),
          label: '単語帳',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.checklist),
          label: '一問一答',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.quiz_outlined),
          label: 'テスト',
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
}