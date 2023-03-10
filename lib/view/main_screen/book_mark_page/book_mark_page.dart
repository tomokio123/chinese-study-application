import 'package:chinese_study_applicaion/utilities/firestore/favorite_question_firestore.dart';
import 'package:chinese_study_applicaion/utilities/firestore/user_firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../../../utilities/app_colors.dart';
import '../../../utilities/firestore/question_firestore.dart';

class BookMarkPage extends StatelessWidget {
  //TODO:お気に入りページに移った時に「お気に入り登録されているquestion_id(favoriteQuestionテーブルのquestion_idフィールド)のリスト」を取得する
  // final String currentUserId;
  //TODO;このページに移った時に取得したquestion_idを元に、favorite_questionテーブルのquestion_idをwhereIndで検索して取り出す
  final List<String> favoriteQuestionIdList;
  const BookMarkPage({Key? key, required this.favoriteQuestionIdList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<String> favoriteQuestionIdList = ["1", "2"];
    final favoriteQuestionIdFuture = QuestionFireStore.questions.where("question_id", whereIn: favoriteQuestionIdList).get();

    return Scaffold(
      body: Center(
        child: SafeArea(
          child: FutureBuilder<QuerySnapshot>(
              future: favoriteQuestionIdFuture,
              // TODO:favoriteQuestionsコレクションの中でuser_idが一致するquestion_idを取り出し、
              // TODO:そのquestion_idと一致するquestionをquestionコレクションから取ってきて表示
              builder: (context, snapshot) {
                if(snapshot.hasData){
                  return ListView.builder(
                    itemCount: snapshot.data!.size,
                    itemBuilder: (BuildContext context, int index) {
                      return Center(
                        child: Container(
                          color: AppColors.mainBlue,
                          child: Column(
                            children: [
                              SizedBox(
                                  width: double.infinity,
                                  height: 50,
                                  child: Center(child: Text("data length:${snapshot.data!.size}"))),
                              SizedBox(
                                  width: double.infinity,
                                  height: 50,
                                  child: Center(child: Text("question_id:${snapshot.data!.docs[index].get("question_id")}です"))),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                } else {
                  return Center(child: Container());
                }
              }
          )
        ),
      ),
    );
  }
}
