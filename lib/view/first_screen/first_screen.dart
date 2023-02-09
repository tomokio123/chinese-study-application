import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:chinese_study_applicaion/view/main_screen/main_screen.dart';
import 'package:flutter/material.dart';

import '../../utilities/app_colors.dart';

class FirstScreen extends StatelessWidget {
  const FirstScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.mainWhite,
      body: GestureDetector(
        onTap:  (){
          Navigator.push(context, MaterialPageRoute(builder: (context) => const MainScreen()));
        },
        child: SafeArea(
          child: Center(
            child: Column(
              children: [
                SizedBox(height: 150),
                AnimatedTextKit(
                  animatedTexts: [
                    ColorizeAnimatedText('AppTitle',
                        colors: [AppColors.subBlue, AppColors.mainBlue, AppColors.subBlue],
                        textStyle: TextStyle(fontSize: 45,letterSpacing: 1)
                    ),
                  ],
                ),
                SizedBox(height: 100),
                Container(
                  height: 170,
                  child: Image.asset('images/main_image.png'))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
