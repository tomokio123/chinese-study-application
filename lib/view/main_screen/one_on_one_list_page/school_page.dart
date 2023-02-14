import 'package:chinese_study_applicaion/view/main_screen/one_on_one_list_page/to_chinese_page/to_chinese_page.dart';
import 'package:chinese_study_applicaion/view/main_screen/one_on_one_list_page/to_japanese_page/to_japanese_page.dart';
import 'package:flutter/material.dart';
import '../../../utilities/app_colors.dart';
//School = 問題のジャンルを選ぶページ
class OneOnOneListPage extends StatefulWidget {
  const OneOnOneListPage({Key? key}) : super(key: key);

  @override
  State<OneOnOneListPage> createState() => _OneOnOneListPageState();
}

class _OneOnOneListPageState extends State<OneOnOneListPage> {
  int _currentPageIndex = 0;
  void _onItemTapped(int index) {
    setState(() {
      _currentPageIndex = index;
    });
  }
   List<Widget> _widgetOptions = <Widget>[
    ToJapanesePage(),
    ToChinesePage()
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(automaticallyImplyLeading: false,
            // //以上の記述一行だけでNavigationのBack矢印が消せる。
            title: TabBar(
              onTap: _onItemTapped,
              tabs: [
                Tab(child: Text( '中国語→日本語',style: TextStyle(color: AppColors.mainBlue))),
                Tab(child: Text( '日本語→中国語',style: TextStyle(color: AppColors.mainBlue))),
            ],
              indicatorColor: AppColors.subBlue,
              indicatorSize: TabBarIndicatorSize.label,
        )),
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