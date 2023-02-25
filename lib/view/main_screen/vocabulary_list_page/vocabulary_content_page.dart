import 'package:chinese_study_applicaion/utilities/app_text_styles.dart';
import 'package:chinese_study_applicaion/utilities/firestore/question_firestore.dart';
import 'package:chinese_study_applicaion/utilities/provider/providers.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../utilities/app_colors.dart';
import '../../../utilities/firestore/answer_firestore.dart';

class VocabularyContentPage extends ConsumerWidget {
  final String questionId;
  const VocabularyContentPage({Key? key, required this.questionId}) : super(key: key);

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
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                            height: 30,
                            child: Text('question_id:${snapshot.data!.docs[currentVocabularyIndex].get("question_id")}',
                                style: AppTextStyles.textBold)),
                        Container(
                            height: 30,
                            child: Text(
                              'title:${snapshot.data!.docs[currentVocabularyIndex].get("title")}',
                              style: AppTextStyles.textBold
                              ,)),
                        Container(
                          child: FutureBuilder<QuerySnapshot>(
                            //answer_idがquestion_idと等しいクエリを取得して表示する
                            future: AnswerFireStore.answers.where("answer_id", isEqualTo: questionId).get(),
                            builder: (context, snapshot) {
                              if(snapshot.hasData){
                                return Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                        height: 30,
                                        child: Text('answer_id:${snapshot.data!.docs[currentVocabularyIndex].get("answer_id")}',
                                            style: AppTextStyles.textBold)),
                                    Container(
                                        height: 30,
                                        child: Text(
                                          'commentary:${snapshot.data!.docs[currentVocabularyIndex].get("commentary")}',
                                          style: AppTextStyles.textBold
                                          ,))
                                  ],
                                );
                              } else {
                                return Container();
                              }
                            }
                            ))
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