import 'dart:math';

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
                  pause: const Duration(seconds: 3),
                  repeatForever: true,
                  animatedTexts: [
                    ColorizeAnimatedText('AppTitle',
                        colors: [AppColors.subBlue, AppColors.mainBlue, AppColors.subBlue],
                        textStyle: TextStyle(fontSize: 50,letterSpacing: 2)
                    ),
                  ],
                ),
                SizedBox(height: 120),
                Transform.rotate(
                  angle: -90 * pi / 180, //piとはπのことで = 3.1415926535的なやつ
                  //度数法→弧度法に直してる。「-90°= -1/4π」による。
                  child: Container(
                    height: 200,
                    child: Image.asset('images/main_image.png')),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
