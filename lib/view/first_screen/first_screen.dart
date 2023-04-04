import 'dart:math';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:chinese_study_applicaion/utilities/app_text_styles.dart';
import 'package:chinese_study_applicaion/view/main_screen/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../utilities/app_colors.dart';

class FirstScreen extends StatelessWidget {
  const FirstScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap:  (){
        Navigator.push(context, MaterialPageRoute(builder: (context) => const MainScreen()));
      },
      child: Scaffold(
        backgroundColor: AppColors.mainWhite,
        body: SingleChildScrollView(
          child: SafeArea(
            child: Center(
              child: Column(
                children: [
                  SizedBox(height: 100),
                  Transform.rotate(
                    angle: -0 * pi / 180, //piとはπのことで = 3.1415926535的なやつ
                    //度数法→弧度法に直してる。「-90°= -1/4π」による。
                    child: Container(
                        height: 250,
                        child: Image.asset('images/IMG_0993.png', width: 300)
                            .animate(onPlay: (controller) => controller.repeat())
                            .shimmer(delay: 4000.ms, duration: 1800.ms)
                            .shake(hz: 4, curve: Curves.easeInOutCubic)
                            .scale(
                          begin: const Offset(1, 1),
                          end: const Offset(1.1, 1.1),
                          duration: 600.ms,
                        )
                            .then(delay: 600.ms)
                            .scale(
                          begin: const Offset(1, 1),
                          end: const Offset(1 / 1.1, 1 / 1.1),
                        )),
                  ),
                  SizedBox(height: 100),
                  Container(
                    padding: EdgeInsets.all(10),
                    child: AnimatedTextKit(
                      pause: const Duration(seconds: 3),
                      repeatForever: true,
                      animatedTexts: [
                        ColorizeAnimatedText('Go 美麗島',
                            colors: [AppColors.subBlue, AppColors.mainBlue, AppColors.subBlue],
                            textStyle: AppTextStyles.textBoldBig
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
