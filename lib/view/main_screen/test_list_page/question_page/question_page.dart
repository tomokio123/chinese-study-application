import 'package:chinese_study_applicaion/utilities/firestore/answer_firestore.dart';
import 'package:chinese_study_applicaion/utilities/firestore/question_firestore.dart';
import 'package:chinese_study_applicaion/utilities/provider/providers.dart';
import 'package:chinese_study_applicaion/utilities/view_model/question_page_view_model.dart';
import 'package:chinese_study_applicaion/view/common_widget/containers/common_containers.dart';
import 'package:chinese_study_applicaion/view/main_screen/test_list_page/question_page/question_result_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../utilities/app_colors.dart';
import '../../../../utilities/app_text_styles.dart';

class QuestionPage extends ConsumerWidget {
  final String categoryId;
  const QuestionPage({Key? key,required this.categoryId}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final Size size = MediaQuery.of(context).size;

    int currentQuestionIndex = ref.watch(currentQuestionIndexProvider);
    final questionFuture = QuestionFireStore.questions.where('category_id', isEqualTo: categoryId).get();

    final bool isAnswered = ref.watch(buttonProvider);//回答したか
    final bool isCorrect = ref.watch(isCorrectProvider);//正解or不正解
    //final String currentQuestionNumber  = ref.watch(currentQuestionIdProvider);

    return Scaffold(
      body: Center(
        child: SafeArea(
          child: FutureBuilder<QuerySnapshot>(
            future: questionFuture,
            builder: (context, snapshot) {//このsnapShotには、もう整列して詰めておく。
              //ドキュメントのquestionCounterばんめにある"question_id"フィールド値を取得。
              //よってFutureで取得するときに整列、検索をすることが重要
              if(snapshot.hasData){//これ忘れると「null check Operator」の例外吐かれるので対策しておく
                //List questionNumberList = ["1","2","3","4","5","6","7","8","9","10"];的なListを作りたい

                List<String> questionNumberList = [];//問題番号に対応する回答を格納できるように配列を準備。
                for (var i =0; i < snapshot.data!.size; i++) {//問題の数の分だけ回す。
                  questionNumberList.add(snapshot.data!.docs[i].get("question_id"));
                  //用意していた配列にaddしていく処理
                }
                final answerFuture = AnswerFireStore.answers.where('answer_id', whereIn: questionNumberList).get();
                return Column(
                  children: [
                    isAnswered ? Container() : CurrentQuestionIndexContainer(currentQuestionIndex: currentQuestionIndex),
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
                              int questionLength = snapshot.data!.size;//問題のListの長さを先に取得する
                              return
                                isAnswered == false ?
                                ContainerInFourGridView( //未解答状態の時
                                    context: context, ref: ref,
                                    currentQuestionIndex: currentQuestionIndex,
                                    snapshot: snapshot
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
                return Container();
              }
            }
          ),
        ),
      ),
    );
  }
}
