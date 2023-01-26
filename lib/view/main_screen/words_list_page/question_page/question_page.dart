import 'package:flutter/material.dart';

import '../../../../utilities/app_colors.dart';

class QuestionPage extends StatelessWidget {
  const QuestionPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
          iconTheme: IconThemeData(color: AppColors.mainBlue),
          backgroundColor: AppColors.mainWhite,
          automaticallyImplyLeading: true),
        //以上の記述一行だけでNavigationのBack矢印が消せる。),
      body: Center(
        child: SafeArea(
          child: Column(
            children: [
              Container(
                  width: double.infinity, height: size.height * 0.3,
                  color: AppColors.mainPink,
                  child: Center(child: Text('Container'))
              ),
              Text("QuestionPage"),
              Text("QuestionPage"),
              Text("QuestionPage"),
            ],
          ),
        ),
      ),
    );
  }
}
