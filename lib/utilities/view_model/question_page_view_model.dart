import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../view/main_screen/test_list_page/question_page/question_result_page.dart';
import '../provider/providers.dart';

class QuestionPageViewModel {//TODO:question_page.dart/unannounced_test_page.dart の共通ロジックに名前をつけてここにまとめる、ことにする。

  static void onTapFunctionInCommentaryState(
      //TODO:解説を表示している時のonTap処理、引数で名前を明示する時としない時の違いがわからない→引数が多い時はこうやって名前付きの方が見やすいと思った
      {required BuildContext context,
      required WidgetRef ref,
      required int currentQuestionIndex,
      required int questionLength}) {
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
  }

  static void onTapFunctionInFourGridView(BuildContext context, WidgetRef ref,int currentQuestionIndex,
      int index, AsyncSnapshot<QuerySnapshot<Object?>> snapshot) {
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
    print(ref.read(numberOfCorrectAnswersProvider));
    //TODO:解答状態(isAnswered)をfalse => trueにする処理。
    ref.read(buttonProvider.notifier).state = true;
  }
}