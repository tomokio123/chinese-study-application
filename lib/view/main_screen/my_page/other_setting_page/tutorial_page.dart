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
        title: '「テスト」',
        body: 'テストで自分の現在の状況を確認しよう！',
        doAnimateImage: true),
    PageModel(
        color: AppColors.mainBlue,
        imageAssetPath: 'images/batu2.png',
        title: '「単語帳」',
        body: 'ジャンル別に単語をおさらいでき、やり直し保存も可能！',
        doAnimateImage: true),
    PageModel(
        color: AppColors.mainMainBlue,
        imageAssetPath: 'images/maru2.png',
        title: '「やり直し」',
        body: '保存した気になる単語はここで見直そう！',
        doAnimateImage: true),
    PageModel.withChild(
        child: Padding(
            padding: EdgeInsets.only(bottom: 25.0),
            child: Text(
              "さあ、始めよう！",
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
