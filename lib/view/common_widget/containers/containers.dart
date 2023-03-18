import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

import '../../../utilities/app_colors.dart';

class CurrentQuestionIndexContainer extends Container{
  //何問目？とかを表示するための共通Container。
  final int currentQuestionIndex;
  CurrentQuestionIndexContainer({super.key, required this.currentQuestionIndex});

  @override
  // TODO: implement child
  Widget get child => Container(
    width: double.infinity,
    //color: AppColors.mainPink,
    padding: const EdgeInsets.only(top: 30),
    child: Center(
        child: Text("${currentQuestionIndex + 1} 問目",
          style: const TextStyle(fontSize: 20, decoration: TextDecoration.underline, color: AppColors.mainBlue),)
    ),
  );
}

class CenteredCommentaryContainer extends Container{
  //解説を表示するための共通Container。
  final int currentQuestionIndex;
  final AsyncSnapshot<QuerySnapshot<Object?>> snapshot;
  CenteredCommentaryContainer({super.key, required this.currentQuestionIndex, required this.snapshot});

  @override
  // TODO: implement child
  Widget get child => Center(
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
      ));
}

class TitleAndAnswerResultContainer extends Container{
  //[問題文]と回答後の[正解不正解]を表示するための共通Container。
  final bool isAnswered;
  final bool isCorrect;
  final Size size;
  final int currentQuestionIndex;
  final AsyncSnapshot<QuerySnapshot<Object?>> snapshot;

  TitleAndAnswerResultContainer({super.key, required this.isAnswered,
    required this.size, required this.currentQuestionIndex, required this.isCorrect, required this.snapshot});

  @override
  // TODO: implement child
  Widget get child => Container(
      margin: const EdgeInsets.all(20),
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
  );
}