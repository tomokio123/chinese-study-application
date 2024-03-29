import 'package:chinese_study_applicaion/utilities/firestore/favorite_question_firestore.dart';
import 'package:chinese_study_applicaion/utilities/firestore/user_firestore.dart';
import 'package:chinese_study_applicaion/utilities/provider/providers.dart';
import 'package:chinese_study_applicaion/view/common_widget/Indicators/normal_circular_indicator.dart';
import 'package:chinese_study_applicaion/view/main_screen/vocabulary_list_page/vocabulary_content_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../utilities/app_colors.dart';
import '../../../utilities/app_text_styles.dart';
import '../../../utilities/firestore/question_firestore.dart';

class BookMarkPage extends ConsumerWidget with ChangeNotifier {
  final String currentUserId;
  BookMarkPage({Key? key, required this.currentUserId}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bookMarkPageFuture = FavoriteQuestionFireStore.favoriteQuestions.where("user_id", isEqualTo: currentUserId).get();
    //TODO:同期的に削除に伴ってsnapshotを削除したい。これもやる
    return Scaffold(
      appBar: AppBar(title: Text("やり直し"),automaticallyImplyLeading: false),
      body: Center(
        child: SafeArea(
          child: Consumer(builder: (context, ref, child) {
            return FutureBuilder<QuerySnapshot>(
                //future: FavoriteQuestionFireStore.favoriteQuestions.where("user_id", isEqualTo: currentUserId).get(),
                future: bookMarkPageFuture,
                builder: (context, snapshot) {
                  if(snapshot.hasData){
                    final List<dynamic> favoriteQuestionIdList = [];
                    final dataSize = snapshot.data!.size;
                    if(dataSize != 0){
                      for (var i = 0; i < dataSize; i++) {
                        favoriteQuestionIdList.add(snapshot.data!.docs[i].get("question_id"));
                      }
                    }
                    return FutureBuilder<QuerySnapshot>(
                        future: favoriteQuestionIdList.isNotEmpty
                            ? QuestionFireStore.questions.where("question_id", whereIn: favoriteQuestionIdList).get()
                            : null,
                        // TODO:favoriteQuestionsコレクションの中でuser_idが一致するquestion_idを取り出し、
                        // TODO:そのquestion_idと一致するquestionをquestionコレクションから取ってきて表示
                        builder: (context, snapshot) {
                          if(snapshot.hasData){
                            return ListView.builder(
                              itemCount: snapshot.data!.size,
                              itemBuilder: (BuildContext context, int index) {
                                final String questionTitle = snapshot.data!.docs[index].get("title");
                                final String questionId = snapshot.data!.docs[index].get("question_id"); //questionIdは表示しないので不要
                                return Container(
                                  padding: EdgeInsets.all(4),
                                  child: GestureDetector(
                                    onTap: (){
                                      //TODO:押したらどうするか
                                      Navigator.push(context, MaterialPageRoute(builder: (context) => VocabularyContentPage(
                                          questionId: questionId)));
                                    },
                                    child: Card(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      color: AppColors.mainWhite,
                                      elevation: 3,
                                      child: SizedBox(
                                        height: 75, //90から75へ
                                        child: Stack(
                                          children: [
                                            Center(child: Text(questionTitle,
                                                style: AppTextStyles.textSemiNormal,
                                                overflow: TextOverflow.ellipsis
                                            )),
                                            Align(
                                              alignment: Alignment.centerRight,
                                              child: GestureDetector(
                                                //TODO:押して保存。保存されている場合は保存解除
                                                onTap: () async{
                                                  //TODO：ここからもお気にりの削除ができるようにする
                                                  //まずcurrentUserId, questionIdを与えてFavoriteQuestionIDを取得
                                                  var _favoriteQuestionId = await FavoriteQuestionFireStore.getFavoriteQuestion(currentUserId, questionId);
                                                  if(_favoriteQuestionId is String){//正常(FireStoreに値があり、既にお気に入りとなっていて)Stringが帰ってきた時は
                                                    //TODO:お気に入りを削除
                                                    await FavoriteQuestionFireStore.deleteFavoriteQuestion(_favoriteQuestionId);
                                                    print("削除");
                                                    ref.watch(bookMarkPageProvider.notifier).state = FavoriteQuestionFireStore.favoriteQuestions.where("user_id", isEqualTo: currentUserId).get();
                                                  }
                                                },
                                                child: Container(
                                                  height: 90,
                                                  width: 50,
                                                  child: Center(
                                                      child: Icon(Icons.cancel_outlined, size: 20,color: AppColors.mainGray,)
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
                          } else if(snapshot.hasError){
                            return Container();
                          } else if(snapshot.hasData == false) {
                            return Center(child: Text("やり直しはありません",style: TextStyle(color: AppColors.mainBlue)));
                          } else {
                            return Container();
                          }
                        }
                    );
                  } else if(snapshot.hasError) {
                    return Container();
                  } else {
                    return const NormalCircularIndicator();
                  }
                }
            );
          })
        ),
      ),
    );
  }
}
