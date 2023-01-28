import 'package:chinese_study_applicaion/Utilities/app_colors.dart';
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
                  height: size.height * 0.3,
                  width: double.infinity,
                  color: AppColors.mainBlue,
                  child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                              'ここにresult'
                          ),
                          SizedBox(height: 24),
                          Text(
                              'ここにresult：$numberOfQuestions問中$numberOfCorrectAnswers問正解'
                          ),
                        ],
                      )),
                ),
                Text('text'),
                Text('text'),
                Text('text'),
                Text('text'),
                ElevatedButton(
                  child: const Text('次のページへ'),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.red,
                    onPrimary: Colors.black,
                    shape: const StadiumBorder(),
                  ),
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => SchoolPage()));
                  },
                )
              ],
            ),
          )
      ),
    );
  }
}
