import 'package:chinese_study_applicaion/Utilities/app_colors.dart';
import 'package:chinese_study_applicaion/utilities/app_text_styles.dart';
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
    //TODO:正答数によって出てくる感想を変える処理
    String returnComment() {
      final String resultComment;
      if(numberOfCorrectAnswers == 0){
        return resultComment = "幹你娘！！";
      } else if (numberOfCorrectAnswers > 0 && numberOfCorrectAnswers <= 3){
        return resultComment = "白痴！！";
      } else if (numberOfCorrectAnswers > 3 && numberOfCorrectAnswers <= 6){
        return resultComment = "看不下去";
      } else if (numberOfCorrectAnswers > 6 && numberOfCorrectAnswers <= 9){
        return resultComment = "還不錯";
      } else if (numberOfCorrectAnswers == 10){
        return resultComment = "完美！太厲害了吧～";
      }
      return "No contest";
    }

    final String comment = returnComment();

    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
          child: Center(
            child: Column(
              children: [
                SizedBox(height: 20),
                Container(
                  margin: EdgeInsets.all(20),
                  height: size.height * 0.35,
                  width: double.infinity,
                  padding: const EdgeInsets.all(5.0),
                  decoration: BoxDecoration(
                    border: Border.all(color: AppColors.mainBlue),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Center(
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                                '$questionLength問中',// option + ¥ でバックスラッシュ(\)がうてる
                              style: TextStyle(fontSize: 22),
                            ),
                            SizedBox(height: size.height * 0.04),
                            Text(
                              '$numberOfCorrectAnswers問正解！',
                              style: TextStyle(fontSize: 48),
                            ),
                          ],
                        ),
                      )),
                ),
                Container(
                    child: Center(child: Text(comment, style: AppTextStyles.textBoldBig,)),
                    height: size.height * 0.30
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
