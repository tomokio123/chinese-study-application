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
                    isAnswered ? Container()
                    : CurrentQuestionIndexContainer(currentQuestionIndex: currentQuestionIndex),
                    Container(
                        margin: EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                        ),
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
                              int questionLength = snapshot.data!.size;//問題のListの長さを先に取得する
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
                                      // if(ref.read(currentQuestionIndexProvider) < questionLength - 1){
                                      //   //回答題が最後の問題ではない時→回答して次の問題へ
                                      //   ref.read(currentQuestionIndexProvider.notifier).state++;
                                      // }
                                      // if(currentQuestionIndex == questionLength - 1 && ref.read(buttonProvider.notifier).state == true){
                                      //   //最終問題＆＆その問題に回答した時isAnswered = true とする
                                      //   ref.read(buttonProvider.notifier).state = true;
                                      //   //回答題が最後の問題の時→Result画面へ
                                      // }
                                      print(ref.read(numberOfCorrectAnswersProvider));
                                      //TODO:解答状態(isAnswered)をfalse => trueにする処理。
                                      ref.read(buttonProvider.notifier).state = true;
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
                                  if(currentQuestionIndex == questionLength - 1){
                                    //TODO:最終問題 && 回答状況がtrue「回答して答えと解説を見ていますよ」って状況のなかではTapすると次の画面へ
                                    Navigator.pushReplacement(context, MaterialPageRoute(
                                        builder: (context)=> QuestionResultPage(
                                            questionLength: currentQuestionIndex + 1,
                                            numberOfCorrectAnswers: ref.read(numberOfCorrectAnswersProvider)
                                        ))
                                    );
                                    ref.refresh(currentQuestionIndexProvider.notifier).state;//Providerのリセット。
                                  } else {
                                    //基本はこっちが作動する
                                    //TODO:このタイミングで問題番号を+1するので176行目は[currentQuestionIndex]で番号の帳尻が合う設計。
                                    ref.read(currentQuestionIndexProvider.notifier).state++;
                                    ref.read(buttonProvider.notifier).state = false;
                                    //TODO:回答状況(isAnsweredにfalseを入れて、「未回答状態」とする)
                                  }
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
                                                  "${snapshot.data!.docs[currentQuestionIndex].get("commentary")}",
                                                  //docs[currentQuestionIndex]でOK!
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
                return Container();
              }
            }
          ),
        ),
      ),
    );
  }
}
