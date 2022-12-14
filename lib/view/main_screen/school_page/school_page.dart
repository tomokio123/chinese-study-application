import 'package:flutter/material.dart';
import 'package:material_segmented_control/material_segmented_control.dart';

import '../../../utilities/app_colors.dart';
import '../../../utilities/app_text_styles.dart';
import '../../first_screen/first_screen.dart';
import '../book_mark_page/book_mark_page.dart';
import '../home_page/home_page.dart';
//School = 問題のジャンルを選ぶページ
class SchoolPage extends StatefulWidget {
  const SchoolPage({Key? key}) : super(key: key);

  @override
  State<SchoolPage> createState() => _SchoolPageState();
}

class _SchoolPageState extends State<SchoolPage> {
  int _currentPageIndex = 0;
  void _onItemTapped(int index) {
    setState(() {
      _currentPageIndex = index;
    });
  }
  static const List<Widget> _widgetOptions = <Widget>[
    HomePage(),
    BookMarkPage()
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(automaticallyImplyLeading: false,
            // //以上の記述一行だけでNavigationのBack矢印が消せる。
            title: GestureDetector(
              child: TabBar(
                onTap: _onItemTapped,
                tabs: [
                  Tab(text: '1',),
                  Tab(text: '2'),
              ],
                indicatorColor: AppColors.mainWhite,
        ),
            ),
        backgroundColor: AppColors.mainBlue),
        body: Column(
          children: [
            Expanded(
                child: Container(
                    child: _widgetOptions.elementAt(_currentPageIndex)))
          ],
        ),
      ),
    );
  }
}
