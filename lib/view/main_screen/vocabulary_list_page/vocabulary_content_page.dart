import 'package:chinese_study_applicaion/utilities/app_text_styles.dart';
import 'package:chinese_study_applicaion/utilities/firestore/question_firestore.dart';
import 'package:chinese_study_applicaion/utilities/provider/providers.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../utilities/app_colors.dart';
import '../../../utilities/firestore/answer_firestore.dart';

class VocabularyContentPage extends ConsumerWidget {
  const VocabularyContentPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //現在の単語帳ナンバーのindexを保持する。
    final int currentVocabularyIndex = ref.watch(currentVocabularyIndexProvider);

    return Scaffold(
      appBar: AppBar(
          iconTheme: const IconThemeData(color: AppColors.mainBlue),
          title: Text("VocabularyContentPage")),
      body: Center(
        child: SafeArea(
          child: Container(
            width: double.infinity,//目一杯広げる
            child: FutureBuilder<QuerySnapshot>(
                future: QuestionFireStore.questions.get(),
                builder: (context, snapshot) {
                  if(snapshot.hasData){
                    List<String> questionNumberList = [];//問題番号に対応する回答を格納できるように配列を準備。
                    for (var i =0; i < snapshot.data!.size; i++) {
                      //問題の数の分だけ回す。iは[index]を表しているので0から始める。データサイズの1つ手前で止めるのがミソ！
                      questionNumberList.add(snapshot.data!.docs[i].get("question_id"));
                      //用意していた配列にaddしていく処理
                    }
                    final answerFuture = AnswerFireStore.answers.where('answer_id', whereIn: questionNumberList).get();
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                            child: Text('${snapshot.data!.docs[currentVocabularyIndex].get("question_id")}',
                                style: AppTextStyles.textBold)),
                        Container(
                            height: 100,
                            child: Text(
                              '${snapshot.data!.docs[currentVocabularyIndex].get("title")}',
                              style: AppTextStyles.textBoldBig
                              ,)),
                        Container(
                          child: FutureBuilder<QuerySnapshot>(
                            future: answerFuture,
                            builder: (context, snapshot) {
                              return Container();
                            }
                          ),)
                      ],
                    );
                  } else {
                    return Container(child: Text('questionFutureがfalse'),);
                  }
                }
            ),
          ),
        ),
      ),
    );
  }
}