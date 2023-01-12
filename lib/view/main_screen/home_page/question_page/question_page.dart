import 'package:flutter/material.dart';

import '../../../../utilities/app_colors.dart';

class QuestionPage extends StatelessWidget {
  const QuestionPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: AppColors.mainBlue),
      body: SafeArea(
        child: Container(
          child: Text("QuestionPage"),
        ),
      ),
    );
  }
}
