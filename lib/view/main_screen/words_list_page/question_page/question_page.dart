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

    //解答提出したかどうか,default = false
    final bool isAnswered = ref.watch(buttonProvider);
    //正解かどうか,default = false
    final bool isCorrect = ref.watch(isCorrectProvider);
    final int numberOfCorrectAnswers = ref.watch(numberOfCorrectAnswersProvider);

    return Scaffold(
      body: Center(
        child: SafeArea(
          child: FutureBuilder<QuerySnapshot>(
            future: questionFuture,
            builder: (context, snapshot) {
              if(snapshot.hasData){//これ忘れると「null check Operator」の例外吐かれるので対策しておく
                //titleを先に取得しておく
                return Column(
                  children: [
                    Container(
                        width: double.infinity,
                        //color: AppColors.mainPink,
                        padding: const EdgeInsets.only(top: 40),
                        child: Center(
                            child: Text(isAnswered ? "" : "${questionCounter + 1} 問目",
                              style: const TextStyle(fontSize: 30),)
                        )),
                    Container(
                        color: AppColors.mainBlue,
                        width: double.infinity, height: size.height * 0.28,
                        child: Center(
                          //questionのタイトル
                            child: isAnswered
                                ? Text(isCorrect ? "正解です" : "不正解です",
                                style: TextStyle(fontSize: 26))
                                : Text(snapshot.data!.docs[questionCounter].get("title"),
                                style: TextStyle(fontSize: 26)),
                        )
                    ),
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.fromLTRB(12,12,12,0),
                        child: FutureBuilder<QuerySnapshot>(
                          future: answerFuture,
                          builder: (context, snapshot) {
                            if(snapshot.hasData) {
                              return
                                isAnswered == false ? //未解答状態の時
                                Container(//選択肢を出す
                                  child: GridView.count(
                                    physics: const NeverScrollableScrollPhysics(),
                                    //上記でスクロール固定
                                    crossAxisCount: 2,
                                    mainAxisSpacing: 24,
                                    crossAxisSpacing: 24,
                                    children: List.generate(4, (index) => GestureDetector(
                                      onTap: () async{
                                        //Tap時に先にやることは正誤判定を行うこと
                                        if(index.toString() == snapshot.data!.docs[questionCounter].get("correct_answer_index_number")){
                                          //正答時
                                          ref.read(isCorrectProvider.notifier).state = true;
                                          ref.read(numberOfCorrectAnswersProvider.notifier).state++;//正答数を+1
                                        }
                                        if(index.toString() != snapshot.data!.docs[questionCounter].get("correct_answer_index_number")){
                                          //不正答時
                                          ref.read(isCorrectProvider.notifier).state = false;
                                        }
                                        if(ref.read(counterProvider) < 9){
                                          ref.read(buttonProvider.notifier).state = true;
                                          //解答状態(isAnswered)をfalse => trueにする処理。
                                          ref.read(counterProvider.notifier).state++;
                                        }
                                        if(questionCounter == 9){
                                          Navigator.pushReplacement(context, MaterialPageRoute(
                                              builder: (context)=> QuestionResultPage(
                                            numberOfQuestions: questionCounter + 1,
                                            numberOfCorrectAnswers: ref.read(numberOfCorrectAnswersProvider.notifier).state
                                              )));
                                          ref.refresh(counterProvider.notifier).state;
                                        }
                                        print("indexNumber:$index");
                                        print('${questionCounter + 1}問目を回答した');
                                        print("numberOfCorrectAnswers:${ref.read(numberOfCorrectAnswersProvider.notifier).state}");
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
                                ),
                              ) :
                              GestureDetector(//解答すると
                                onTap: (){
                                  ref.read(buttonProvider.notifier).state = false;
                                },
                                child: Center(
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        Expanded(
                                          child: Container(
                                            padding: EdgeInsets.fromLTRB(20, 0, 20, 50),
                                              child: Center(
                                                  child: Text(
                                                      "解説解説解説解説解説解説解説解説解説解説解説解説解説"
                                                      "解説解説解説解説解説解説解説解説解説解説解説解説解説"
                                                          "解説解説解説解説解説解説解説解説解説解説解"
                                                      "説解説解説解説解説:"
                                                      "${snapshot.data!.docs[questionCounter].get("commentary")}",
                                                    style: TextStyle(fontSize: 22),)),
                                            color: AppColors.mainGreen,
                                          ),
                                        ),
                                      ],
                                    )),
                              );
                            } else {
                              return Container(child: Text("${snapshot.hasData}"));
                            }
                          }
                        ),
                      ),
                    )
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
