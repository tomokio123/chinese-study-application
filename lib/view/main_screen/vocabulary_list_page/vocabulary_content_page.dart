import 'package:chinese_study_applicaion/utilities/app_text_styles.dart';
import 'package:chinese_study_applicaion/utilities/firestore/question_firestore.dart';
import 'package:chinese_study_applicaion/utilities/provider/providers.dart';
import 'package:chinese_study_applicaion/view/common_widget/common_containers/common_containers.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
          title: Text("単語の詳細")),
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.all(15),
          width: double.infinity,//目一杯広げる
          child: FutureBuilder<QuerySnapshot>(
              future: QuestionFireStore.questions.where("question_id", isEqualTo: questionId).get(),
              //貰ってきたフィールド変数「questionId」と等しいものをquestion_idコレクションから取ってくる。
              builder: (context, snapshot) {
                if(snapshot.hasData){
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(height: 30),
                      // Container(
                      //     height: 30,
                      //     child: Text('question_id:${snapshot.data!.docs[currentVocabularyIndex].get("question_id")}',
                      //         style: AppTextStyles.textBold)),
                      // SizedBox(height: 10),
                      Container(
                          height: 30,
                          child: Text(
                            '''問題 ${snapshot.data!.docs[currentVocabularyIndex].get("title")}
                            ''',
                            style: AppTextStyles.textBold,)),
                      LinerContainer(),
                      Container(
                        child: FutureBuilder<QuerySnapshot>(
                          //answer_idがquestion_idと等しいクエリを取得して表示する
                          future: AnswerFireStore.answers.where("answer_id", isEqualTo: questionId).get(),
                          builder: (context, snapshot) {
                            if(snapshot.hasData){
                              return Column(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  choiceNameContainer(context, ref, snapshot, currentVocabularyIndex, "answer1","選択肢1"),
                                  choiceNameContainer(context, ref, snapshot, currentVocabularyIndex, "answer2","選択肢2"),
                                  choiceNameContainer(context, ref, snapshot, currentVocabularyIndex, "answer3","選択肢3"),
                                  choiceNameContainer(context, ref, snapshot, currentVocabularyIndex, "answer4","選択肢4"),
                                  LinerContainer(),
                                  Text("解説",style: AppTextStyles.textNormal),
                                  SizedBox(height: 10),
                                  SizedBox(//TODO：この高さを解説文がオーバーすると文字が切れる。小さくなったり、綺麗にまとめる方法を後々考えないといけない
                                      height: 260,
                                      child: Text(
                                        "${snapshot.data!.docs[currentVocabularyIndex].get("commentary")}",
                                        style: AppTextStyles.textNormal
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
                  return Container();
                }
              }
          ),
        ),
      ),
    );
  }
}

Widget choiceNameContainer(BuildContext context, WidgetRef ref, AsyncSnapshot<QuerySnapshot<Object?>> snapshot,
    int currentVocabularyIndex, String fieldName, String answerName) {
  return Container(
      margin: EdgeInsets.symmetric(vertical: 4),
      height: 25,
      child: Text('$answerName:${snapshot.data!.docs[currentVocabularyIndex].get(fieldName)}',
          style: AppTextStyles.textNormal)
  );
}