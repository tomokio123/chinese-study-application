import 'package:chinese_study_applicaion/utilities/firestore/answer_firestore.dart';
import 'package:chinese_study_applicaion/utilities/firestore/question_firestore.dart';
import 'package:chinese_study_applicaion/utilities/provider/providers.dart';
import 'package:chinese_study_applicaion/view/main_screen/words_list_page/question_page/question_result_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../utilities/app_colors.dart';
import '../../../../utilities/app_text_styles.dart';

class QuestionPage extends ConsumerWidget {
  final String categoryId;
  const QuestionPage({Key? key,this.categoryId = ""}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final Size size = MediaQuery.of(context).size;
    int questionCounter = ref.watch(counterProvider);
    final questionFuture = QuestionFireStore.questions.get();
    final answerFuture = AnswerFireStore.answers.get();

    return Scaffold(
      body: Center(
        child: SafeArea(
          child: FutureBuilder<QuerySnapshot>(
            future: questionFuture,
            builder: (context, snapshot) {
              if(snapshot.hasData){//これ忘れると「null check Operator」の例外吐かれるので対策しておく
                return Column(
                  children: [
                    Container(
                        width: double.infinity,
                        //color: AppColors.mainPink,
                        padding: const EdgeInsets.only(top: 40),
                        child: Center(
                            child: Text('${questionCounter + 1}問目',
                              style: TextStyle(fontSize: 30),)
                        )),
                    Container(
                        color: AppColors.mainPink,
                        width: double.infinity, height: size.height * 0.28,
                        //color: AppColors.mainBlue,
                        child: Center(
                          //questionのタイトル
                            child: Text('${snapshot.data!.docs[questionCounter].get("title")}',
                                style: TextStyle(fontSize: 20)))
                    ),
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.fromLTRB(12,12,12,0),
                        child: FutureBuilder<QuerySnapshot>(
                          future: answerFuture,
                          builder: (context, snapshot) {
                            if(snapshot.hasData) {
                              return GridView.count(
                                  physics: const NeverScrollableScrollPhysics(),
                                  //上記でスクロール固定
                                  crossAxisCount: 2,
                                  mainAxisSpacing: 24,
                                  crossAxisSpacing: 24,
                                  children: List.generate(4, (index) => GestureDetector(
                                    onTap: (){
                                      if(ref.read(counterProvider) < 9){
                                        ref.read(counterProvider.notifier).state++;
                                      }
                                      if(questionCounter == 9){
                                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> QuestionResultPage(
                                          numberOfQuestions: questionCounter + 1,
                                          numberOfCorrectAnswers: 3,
                                        )
                                        ));
                                        ref.refresh(counterProvider.notifier).state;
                                      }
                                      print('${questionCounter + 1}');
                                    },
                                    child: Card(
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(10),
                                        ),
                                        color: AppColors.mainWhite,
                                        elevation: 5,
                                        child: Center(
                                            child: Text('${snapshot.data!.docs[questionCounter].get("answer${index + 1}")}', style: AppTextStyles.textBold)
                                        )
                                    ),
                                  ))
                              );
                            } else {
                              return Container();
                            }
                          }
                        ),
                      ),
                    ),
                  ],
                );
              } else {
                return Container();
              }
            }
          ),
        ),
      ),
    );
  }
}
