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
                        Container(
                          // color: AppColors.mainBlue,
                            width: double.infinity,
                            height: isAnswered ? size.height * 0.45 : size.height * 0.32,
                            child: Center(
                              //questionのタイトル
                              child: isAnswered
                                  ? Column(
                                children: [
                                  Container(
                                    height: 300,
                                    child: Image.asset(
                                      //TODO:正解と不正解のImageを作って貼り付ける。一旦はpngで作る
                                        isCorrect ?
                                        'images/maru2.png':
                                        'images/batu2.png'
                                    ),
                                  ),
                                  Container(
                                    height: 50,
                                    child: Center(
                                        child: Text(
                                            isCorrect ? "正解!" : "不正解",
                                            style: TextStyle(
                                                color:isCorrect ? AppColors.mainRed : AppColors.mainBlue,
                                                fontSize: 40
                                            ))
                                    ),
                                  )
                                ],
                              )
                                  : Text(snapshot.data!.docs[currentQuestionIndex].get("title"),
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
                                      GridView.count(
                                          physics: const NeverScrollableScrollPhysics(),
                                          //上記でスクロール固定
                                          crossAxisCount: 2,
                                          mainAxisSpacing: 24,
                                          crossAxisSpacing: 24,
                                          children: List.generate(4, (index) => GestureDetector(
                                            onTap: () async{
                                              //Tap時に先にやることは正誤判定を行うこと
                                              if(index.toString() == snapshot.data!.docs[currentQuestionIndex].get("correct_answer_index_number")){
                                                //正答時
                                                ref.read(isCorrectProvider.notifier).state = true;
                                                ref.read(numberOfCorrectAnswersProvider.notifier).state++;//正答数を+1
                                              }
                                              if(index.toString() != snapshot.data!.docs[currentQuestionIndex].get("correct_answer_index_number")){
                                                //不正答時
                                                ref.read(isCorrectProvider.notifier).state = false;
                                              }
                                              if(ref.read(currentQuestionIndexProvider) < questionLength - 1){
                                                //回答題が最後の問題ではない時→回答して次の問題へ
                                                ref.read(buttonProvider.notifier).state = true;
                                                //解答状態(isAnswered)をfalse => trueにする処理。
                                                ref.read(currentQuestionIndexProvider.notifier).state++;
                                              }
                                              if(currentQuestionIndex == questionLength - 1){
                                                //回答題が最後の問題の時→Result画面へ
                                                Navigator.pushReplacement(context, MaterialPageRoute(
                                                    builder: (context)=> QuestionResultPage(
                                                        questionLength: currentQuestionIndex + 1,
                                                        numberOfCorrectAnswers: ref.read(numberOfCorrectAnswersProvider)
                                                    ))
                                                );
                                                ref.refresh(currentQuestionIndexProvider.notifier).state;
                                              }
                                              print(ref.read(numberOfCorrectAnswersProvider));
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
                                        onTap: (){
                                          ref.read(buttonProvider.notifier).state = false;
                                        },
                                        child: Center(
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              children: [
                                                Expanded(
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                      border: Border.all(color: AppColors.mainBlue, width: 4),
                                                      borderRadius: BorderRadius.circular(20),
                                                    ),
                                                    padding: EdgeInsets.fromLTRB(20, 0, 20, 50),
                                                    child: Center(
                                                        child: Text(
                                                          "${snapshot.data!.docs[currentQuestionIndex - 1].get("commentary")}",
                                                          //この処理より先にquestionCounterが++されてしまうので-1しておくことで帳尻合わせる。
                                                          style: TextStyle(fontSize: 22),)),
                                                  ),
                                                ),
                                              ],
                                            )),
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