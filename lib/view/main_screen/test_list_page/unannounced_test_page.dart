import 'package:chinese_study_applicaion/utilities/firestore/answer_firestore.dart';
import 'package:chinese_study_applicaion/utilities/firestore/question_firestore.dart';
import 'package:chinese_study_applicaion/utilities/provider/providers.dart';
import 'package:chinese_study_applicaion/view/common_widget/containers/containers.dart';
import 'package:chinese_study_applicaion/view/main_screen/test_list_page/question_page/question_result_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../utilities/app_colors.dart';
import '../../../../utilities/app_text_styles.dart';
import '../../../utilities/view_model/question_page_view_model.dart';
import '../../common_widget/Indicators/normal_circular_indicator.dart';

class UnannouncedTestPage extends StatelessWidget {
  final int totalNumberOfQuestions;//questionsテーブルの全問題数を取得
  const UnannouncedTestPage({Key? key, required this.totalNumberOfQuestions})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final List <String> randomNumberList = [];// ランダムな"question_id"を格納する配列
    for (var i = 1; i < totalNumberOfQuestions + 1; i++) {
      //iは総問題数(totalNumberOfQuestions)個分。
      randomNumberList.add("$i");
    }
    print(randomNumberList);
    randomNumberList.shuffle();//TODO:いったん取ってきた全ての問題snapShotをシャッフルする処理
    final List<String> gotRandomNumberList = randomNumberList.take(10).toList();
    //TODO:その問題から10題取ってくる処理(["2", "4", "8", "10", "14"...]的なノリ)

    final questionFuture = QuestionFireStore.questions.where("question_id", whereIn: gotRandomNumberList).get();
    final answerFuture = AnswerFireStore.answers.where('answer_id', whereIn: gotRandomNumberList).get();

    return Scaffold(
      body: Consumer(builder: (context, ref, child){
        return Center(
          child: SafeArea(
            child: FutureBuilder<QuerySnapshot>(
                future: questionFuture,
                builder: (context, snapshot) {
                  //現在の問題のIndexを管理。問題の番数はこれ+1。
                  final int currentQuestionIndex = ref.watch(currentQuestionIndexProvider);
                  final bool isAnswered = ref.watch(buttonProvider);//回答したか
                  final bool isCorrect = ref.watch(isCorrectProvider);//正解or不正解
                  if(snapshot.hasData){//これ忘れると「null check Operator」の例外吐かれるので対策しておく
                    int questionLength = snapshot.data!.size;//問題のListの長さを先に取得する
                    print("questionLength:$questionLength");
                    print("question_id:${snapshot.data!.docs[currentQuestionIndex].get("question_id")}");
                    print("currentQuestionIndex:$currentQuestionIndex");
                    return Column(
                      children: [
                        isAnswered ? Container()
                            : CurrentQuestionIndexContainer(currentQuestionIndex: currentQuestionIndex),
                        TitleAndAnswerResultContainer(
                            isAnswered: isAnswered, size: size,
                            currentQuestionIndex: currentQuestionIndex,
                            isCorrect: isCorrect, snapshot: snapshot
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
                                      // isAnsweredを管理するbuttonProviderのデフォルトは「false」なので注意
                                      GridView.count(
                                          physics: const NeverScrollableScrollPhysics(),
                                          //上記でスクロール固定
                                          crossAxisCount: 2,
                                          mainAxisSpacing: 24,
                                          crossAxisSpacing: 24,
                                          children: List.generate(4, (index) => GestureDetector(
                                            onTap: () async{
                                              QuestionPageViewModel.onTapFunctionInFourGridView(context, ref, currentQuestionIndex, index, snapshot);
                                            },
                                            child: Card(
                                                shape: RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.circular(10),
                                                ),
                                                color: AppColors.mainWhite,
                                                elevation: 5,
                                                child: Center(
                                                    child: Text('${snapshot.data!.docs[currentQuestionIndex].get("answer${index + 1}")}', style: AppTextStyles.textBold)
                                                )
                                            ),
                                          ))
                                      ) :
                                      GestureDetector(//解答すると
                                        onTap: () async{
                                          QuestionPageViewModel.onTapFunctionInCommentaryState(
                                              context: context,
                                              ref: ref,
                                              currentQuestionIndex: currentQuestionIndex,
                                              questionLength: questionLength
                                          );
                                        },
                                        child: CenteredCommentaryContainer(currentQuestionIndex: currentQuestionIndex, snapshot: snapshot),
                                      );
                                  } else {
                                    return Container();
                                  }
                                }
                            ),
                          ),
                        )
                      ],
                    );
                  } else {
                    return const NormalCircularIndicator();
                  }
                }
            ),
          ),
        );
      })
    );
  }
}