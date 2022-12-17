import 'package:chinese_study_applicaion/Utilities/app_colors.dart';
import 'package:flutter/material.dart';

class TutorialPage extends StatelessWidget {
  const TutorialPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('TutorialPage',style: TextStyle(color: AppColors.mainWhite)),
      backgroundColor: AppColors.mainBlue),
      body: SafeArea(
        child: Container(
          child: Text('TutorialPage'),
        ),
      ),
    );
  }
}
