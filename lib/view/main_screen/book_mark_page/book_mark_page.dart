import 'package:chinese_study_applicaion/utilities/firestore/favorite_question_firestore.dart';
import 'package:chinese_study_applicaion/utilities/firestore/user_firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../../../utilities/app_colors.dart';

class BookMarkPage extends StatelessWidget {
  const BookMarkPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final String currentUserId = UserFireStore.currentUserId;//自分のユーザIDを取得したい
    print(currentUserId);

    return Scaffold(
      body: Center(
        child: SafeArea(
          child: FutureBuilder<QuerySnapshot>(
              future: FavoriteQuestionFireStore.favoriteQuestions.where("user_id", isEqualTo: currentUserId).get(),
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
                                  child: Center(child: Text("${snapshot.data!.size}"))),
                              SizedBox(
                                  width: double.infinity,
                                  height: 50,
                                  child: Center(child: Text("${snapshot.data!.docs[index].get("user_id")}　さんの、${snapshot.data!.docs[index].get("question_id")}です"))),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                } else {
                  return Center(child: Container(child: Text("${snapshot.hasData}がFalseですわ")));
                }
              }
          )
        ),
      ),
    );
  }
}
