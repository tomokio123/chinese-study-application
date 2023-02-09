import 'package:chinese_study_applicaion/Utilities/app_colors.dart';
import 'package:chinese_study_applicaion/view/common_widget/buttons/buttons.dart';
import 'package:chinese_study_applicaion/view/common_widget/buttons/normal_button.dart';
import 'package:chinese_study_applicaion/view/main_screen/main_screen.dart';
import 'package:chinese_study_applicaion/view/main_screen/school_page/school_page.dart';
import 'package:flutter/material.dart';

class QuestionResultPage extends StatelessWidget {
  final int numberOfQuestions;
  final int numberOfCorrectAnswers;

  const QuestionResultPage({Key? key,
    required this.numberOfQuestions, required this.numberOfCorrectAnswers
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
          child: Center(
            child: Column(
              children: [
                Container(
                  height: size.height * 0.35,
                  width: double.infinity,
                  color: AppColors.mainBlue,
                  child: Center(
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                                'ここにresult'
                            ),
                            SizedBox(height: 24),
                            Text(
                                '$numberOfQuestions問中$numberOfCorrectAnswers問正解',
                              style: TextStyle(fontSize: 28),
                            ),
                          ],
                        ),
                      )),
                ),
                Container(
                    child: Center(child: Text("なんか感想")),
                    color: AppColors.subGreen,
                    height: size.height * 0.35
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 0,vertical: 30),
                  child: NormalButton(buttonText: "戻る", onPressed: (){
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => MainScreen()));
                  }),
                ),
              ],
            ),
          )
      ),
    );
  }
}
