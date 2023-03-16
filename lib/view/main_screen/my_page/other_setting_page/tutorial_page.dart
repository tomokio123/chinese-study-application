import 'package:flutter/material.dart';
import 'package:flutter_overboard/flutter_overboard.dart';

import '../../../../utilities/app_colors.dart';

class TutorialPage extends StatelessWidget {
  TutorialPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: OverBoard(
        pages: pages,
        showBullets: true,
        skipText: "スキップ",
        nextText: "次へ",
        finishText: "了解！",
        skipCallback: () {
          // when user select SKIP
          Navigator.pop(context);
        },
        finishCallback: () {
          // when user select NEXT
          Navigator.pop(context);
        },
      ),
    );
  }

  final pages = [
    PageModel(
        color: AppColors.subBlue,
        imageAssetPath: 'images/main_image.png',
        title: '左右のスワイプ',
        body: 'NEXTを押さなくても左右にスワイプすることで画面の切替が出来ます',
        doAnimateImage: true),
    PageModel(
        color: AppColors.mainBlue,
        imageAssetPath: 'images/main_image.png',
        title: '文字を表示できます',
        body: '細かい説明をbodyに指定して書くことが出来ます',
        doAnimateImage: true),
    PageModel(
        color: AppColors.mainMainBlue,
        imageAssetPath: 'images/main_image.png',
        title: '左右のスワイプ',
        body: 'NEXTを押さなくても左右にスワイプすることで画面の切替が出来ます',
        doAnimateImage: true),
    PageModel.withChild(
        child: Padding(
            padding: EdgeInsets.only(bottom: 25.0),
            child: Text(
              "さあ、始めましょう",
              style: TextStyle(
                color: Colors.white,
                fontSize: 32,
              ),
            )),
        color: AppColors.mainMainMainBlue,
        //color: const Color(0xFF5886d6),
        doAnimateChild: true)
  ];
}
