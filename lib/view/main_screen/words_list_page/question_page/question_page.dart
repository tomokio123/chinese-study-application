import 'package:chinese_study_applicaion/model/question.dart';
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
  const QuestionPage({Key? key,this.categoryId = "fruits"}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final Size size = MediaQuery.of(context).size;
    int questionCounter = ref.watch(counterProvider);
    //final questionFuture = QuestionFireStore.questions.get();
    final questionFuture = QuestionFireStore.questions.where('category_id', isEqualTo: "fruits").get();
    //上記記述だけだと問題だけが検索されて取得してしまう
    //AnswerFutureに回答を = [a,a,a,a,a,....]と格納したい
    //final answerFuture = AnswerFireStore.answers.where('answer_id', isEqualTo: '').get();

    //解答提出したかどうか,default = false
    final bool isAnswered = ref.watch(buttonProvider);
    //正解かどうか,default = false
    final bool isCorrect = ref.watch(isCorrectProvider);
    //final int numberOfCorrectAnswers = ref.watch(numberOfCorrectAnswersProvider);//使ってないっぽいから消してもいいかも
    //試験的に設置、現在の渡ってきたquestion_idの番号＝answer_idとなるように渡ってきたquestion_idを管理するProvider
    final String currentQuestionNumber  = ref.watch(currentQuestionIdProvider);

    return Scaffold(
      body: Center(
        child: SafeArea(
          child: FutureBuilder<QuerySnapshot>(
            future: questionFuture,
            builder: (context, snapshot) {//このsnapShotには、もう整列して詰めておく。
              //ref.read(currentQuestionIdProvider.notifier).state = snapshot.data!.docs[questionCounter].get("question_id");//"question_id"<String>
              //final questionIdListByQuestionFuture = snapshot.data!.docs[questionCounter].get(ref.read(currentQuestionIdProvider));
              //print(questionIdListByQuestionFuture);
              //ドキュメントのquestionCounterばんめにある"question_id"フィールド値を取得。
              //よってFutureで取得するときに整列、検索をすることが重要
              if(snapshot.hasData){//これ忘れると「null check Operator」の例外吐かれるので対策しておく
                //List questionNumberList = ["1","2","3","4","5","6","7","8","9","10"];的なListを作りたい
                //List subQuestionNumberList = ["1","2","3","4","5","6","7","8","9","10"];
                // var questionNumberList = snapshot.data!.docs;
                List<String> questionNumberList = [];
                for (var i =0; i < snapshot.data!.size; i++) {
                  questionNumberList.add(snapshot.data!.docs[i].get("question_id"));
                }
                print(questionNumberList);
                final answerFuture = AnswerFireStore.answers.where('answer_id', whereIn: questionNumberList).get();
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
                            print("answerFutureが${snapshot.hasData}");
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
                                      print(questionLength.toString());
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
                                      if(ref.read(counterProvider) < questionLength - 1){
                                        ref.read(buttonProvider.notifier).state = true;
                                        //解答状態(isAnswered)をfalse => trueにする処理。
                                        ref.read(counterProvider.notifier).state++;
                                      }
                                      if(questionCounter == questionLength - 1){
                                        Navigator.pushReplacement(context, MaterialPageRoute(
                                            builder: (context)=> QuestionResultPage(
                                          questionLength: questionCounter + 1,
                                          numberOfCorrectAnswers: ref.read(numberOfCorrectAnswersProvider.notifier).state
                                            )));
                                        ref.refresh(counterProvider.notifier).state;
                                      }
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
                                                      "${snapshot.data!.docs[questionCounter - 1].get("commentary")}",
                                                    //この処理より先にquestionCounterが++されてしまうので-1しておくことで帳尻合わせる。
                                                    style: TextStyle(fontSize: 22),)),
                                            color: AppColors.subGreen,
                                          ),
                                        ),
                                      ],
                                    )),
                              );
                            } else {
                              return Container(child: Text("answerFutureが${snapshot.hasData} = snapshot.hasdataが${snapshot.hasData}"));
                            }
                          }
                        ),
                      ),
                    )
                  ],
                );
              } else {
                return Container(child: Text('questionFutureがfalse'),);
              }
            }
          ),
        ),
      ),
    );
  }
}
