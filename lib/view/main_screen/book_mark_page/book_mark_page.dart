import 'package:chinese_study_applicaion/utilities/firestore/favorite_question_firestore.dart';
import 'package:chinese_study_applicaion/utilities/firestore/user_firestore.dart';
import 'package:chinese_study_applicaion/view/common_widget/Indicators/normal_circular_indicator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../../../utilities/app_colors.dart';
import '../../../utilities/app_text_styles.dart';
import '../../../utilities/firestore/question_firestore.dart';

class BookMarkPage extends StatelessWidget {
  //TODO:お気に入りページに移った時に「お気に入り登録されているquestion_id(favoriteQuestionテーブルのquestion_idフィールド)のリスト」を取得する
  //TODO;このページに移った時に取得したquestion_idを元に、favorite_questionテーブルのquestion_idをwhereIndで検索して取り出す
  final String currentUserId;
  const BookMarkPage({Key? key, required this.currentUserId}) : super(key: key);

  //TODO:favorite_questionテーブルからuser_idでクエリ検索してquestion_idのリストを取り出してくるのは簡単だが
  //TODO:そのリストでquestionsテーブルにクエリ検索をかけるのはまた別で詰まっている
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(title: Text("やり直し"),automaticallyImplyLeading: false,),
      body: Center(
        child: SafeArea(
          child: FutureBuilder<QuerySnapshot>(
            future: FavoriteQuestionFireStore.favoriteQuestions.where("user_id", isEqualTo: currentUserId).get(),
            builder: (context, snapshot) {
              if(snapshot.hasData){
                final List<dynamic> favoriteQuestionIdList = [];
                for (var i = 0; i < snapshot.data!.size; i++) {
                  //iは総問題数(totalNumberOfQuestions)個分。
                  favoriteQuestionIdList.add(snapshot.data!.docs[i].get("question_id"));
                }
                return FutureBuilder<QuerySnapshot>(
                    future: QuestionFireStore.questions.where("question_id", whereIn: favoriteQuestionIdList).get(),
                    // TODO:favoriteQuestionsコレクションの中でuser_idが一致するquestion_idを取り出し、
                    // TODO:そのquestion_idと一致するquestionをquestionコレクションから取ってきて表示
                    builder: (context, snapshot) {
                      if(snapshot.hasData){
                        return ListView.builder(
                          itemCount: snapshot.data!.size,
                          itemBuilder: (BuildContext context, int index) {
                            final String questionTitle = snapshot.data!.docs[index].get("title");
                            //final String questionId = snapshot.data!.docs[index].get("question_id"); //questionIdは表示しないので不要
                            return Container(
                              padding: EdgeInsets.all(4),
                              child: GestureDetector(
                                onTap: (){
                                  //TODO:押したらどうするか
                                },
                                child: Card(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  color: AppColors.mainWhite,
                                  elevation: 3,
                                  child: SizedBox(
                                    height: 90,
                                    child: Stack(
                                      alignment: Alignment.centerLeft,
                                      children: [
                                        Center(child: Text("title:$questionTitle",
                                            style: AppTextStyles.textBoldNormal,
                                            overflow: TextOverflow.ellipsis
                                        )),
                                        Align(
                                          alignment: Alignment.centerRight,
                                          child: GestureDetector(
                                            //TODO:押して保存。保存されている場合は保存解除
                                            onTap: () async{
                                              //TODO：ここからもお気にりの削除ができるようにする
                                            },
                                            child: Container(
                                              height: 90,
                                              width: 70,
                                              child: Center(
                                                  child: Icon(Icons.cancel_outlined, size: 22,color: AppColors.mainGray,)
                                                //TODO:今のところisFavoriteは意味をなさない設計
                                                //Icon(Icons.star_rate_sharp, size: 30, color: AppColors.mainPink,)
                                              ),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        );
                      } else {
                        return Center(child: Container());
                      }
                    }
                );

              } else {
                return const NormalCircularIndicator();
              }
            }
          )
        ),
      ),
    );
  }
}
