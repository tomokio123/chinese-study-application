import 'package:chinese_study_applicaion/Utilities/app_colors.dart';
import 'package:flutter/material.dart';

class AnnouncementPage extends StatelessWidget {
  const AnnouncementPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          iconTheme: IconThemeData(color: AppColors.mainBlue),
          title: Text('お知らせ詳細',style: TextStyle(color: AppColors.mainBlue)),
          backgroundColor: AppColors.mainWhite),
      body: SafeArea(
        child: Container(
          child: Text('TutorialPage'),
        ),
      ),
    );
  }
}