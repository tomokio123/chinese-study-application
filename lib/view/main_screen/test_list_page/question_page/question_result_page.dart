import 'package:chinese_study_applicaion/Utilities/app_colors.dart';
import 'package:chinese_study_applicaion/utilities/provider/providers.dart';
import 'package:chinese_study_applicaion/view/common_widget/buttons/normal_button.dart';
import 'package:chinese_study_applicaion/view/main_screen/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class QuestionResultPage extends ConsumerWidget {
  final int questionLength;
  final int numberOfCorrectAnswers;

  const QuestionResultPage({Key? key,
    required this.questionLength, required this.numberOfCorrectAnswers
  }) : super(key: key);


  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
                                '$questionLength問中$numberOfCorrectAnswers問正解',
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
                    //問題成績見終わって戻るときに正答数Providerをrefreshする
                    ref.refresh(numberOfCorrectAnswersProvider.notifier).state;
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