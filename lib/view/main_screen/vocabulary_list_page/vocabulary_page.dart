import 'package:chinese_study_applicaion/model/account.dart';
import 'package:chinese_study_applicaion/model/favorite_questions.dart';
import 'package:chinese_study_applicaion/model/question.dart';
import 'package:chinese_study_applicaion/utilities/firestore/favorite_question_firestore.dart';
import 'package:chinese_study_applicaion/utilities/firestore/question_firestore.dart';
import 'package:chinese_study_applicaion/utilities/firestore/user_firestore.dart';
import 'package:chinese_study_applicaion/utilities/provider/providers.dart';
import 'package:chinese_study_applicaion/view/main_screen/main_screen.dart';
import 'package:chinese_study_applicaion/view/main_screen/my_page/my_page.dart';
import 'package:chinese_study_applicaion/view/main_screen/vocabulary_list_page/vocabulary_categories_page.dart';
import 'package:chinese_study_applicaion/view/main_screen/vocabulary_list_page/vocabulary_content_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../utilities/app_colors.dart';
import '../../../utilities/app_snack_bars.dart';
import '../../../utilities/app_text_styles.dart';
import '../../common_widget/Indicators/normal_circular_indicator.dart';

class VocabularyPage extends ConsumerWidget {
  final String categoryId;
  final String categoryTitle;
  const VocabularyPage({Key? key, required this.categoryId, required this.categoryTitle}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final Size size = MediaQuery.of(context).size;
    final questionFuture = QuestionFireStore.questions.where('category_id', isEqualTo: categoryId).get();
    final bool isFavorite = ref.watch(isFavoriteProvider);//isFavoriteProviderのデフォはFalse。
    //お気に入りに登録されているかの判定状況を持たせる
    final String currentUserId = UserFireStore.currentUserId;

    //TODO:Favorite登録を消す、解除する
    Future<void> _deleteFavoriteDialogBuilder(BuildContext context, WidgetRef ref, String favoriteQuestionId) {
      return showDialog<void>(
        context: context,
        builder: (BuildContext context) {
          return CupertinoAlertDialog(
            title: const Text('お気に入り解除'),
            content: const Text('既にお気に入り登録されています。解除してよろしいでしょうか？'),
            actions: <Widget>[
              TextButton(
                style: TextButton.styleFrom(
                  textStyle: Theme.of(context).textTheme.labelLarge,
                ),
                child: Text('戻る'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              TextButton(
                style: TextButton.styleFrom(
                  textStyle: Theme.of(context).textTheme.labelLarge,
                ),
                child: const Text('解除'),
                onPressed: () async{
                  await FavoriteQuestionFireStore.deleteFavoriteQuestion(favoriteQuestionId);
                  ref.read(isFavoriteProvider.notifier).state = false;//TODO:お気に入り解除
                  Navigator.pop(context);
                },
              ),
            ],
          );
        },
      );
    }

    //TODO:uidとquestionIdを渡して保存
    Future<dynamic> createFavoriteQuestion(String uid, String questionId) async{//FireStoreに送るデータ
      //!でnull回避 await をつけておく一応
      FavoriteQuestion newFavoriteQuestion = FavoriteQuestion(//データのオブジェクト。所持するデータたち
        //クライアント側から送るデータの「管」を作るイメージ。この後DB側のそのデータを受け取る「皿」たちとくっつける。
          accountId: uid,
          questionId: questionId
      );
      var _result = await FavoriteQuestionFireStore.setFavoriteQuestion(
          accountId: newFavoriteQuestion.accountId,
          questionId: newFavoriteQuestion.questionId
      );
      //引数を{}で囲んでrequiredにすることで名前付きで尚且つ、必須パラメータ(必須引数)とすることもできる。試してみた。
      return _result;
    }

    return Scaffold(
      appBar: AppBar(title: Text(categoryTitle), iconTheme: IconThemeData(color: AppColors.mainBlue),),
      body: SafeArea(
          child: FutureBuilder<QuerySnapshot>(
              future: questionFuture,
              builder: (context, snapshot) {
                if(snapshot.hasData){
                  return ListView.builder(
                      padding: const EdgeInsets.all(2),
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (BuildContext context, int index) {
                        //category_titleを変数に格納
                        final String questionTitle = snapshot.data!.docs[index].get("title");
                        final String questionId = snapshot.data!.docs[index].get("question_id");
                        return Container(
                          padding: EdgeInsets.all(4),
                          child: GestureDetector(
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context) => VocabularyContentPage(
                                questionId: questionId,
                              )));
                            },
                            child: Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              color: AppColors.mainWhite,
                              elevation: 3,
                              child: Container(
                                height: 90,
                                child: Center(
                                  child: Container(
                                    child: Stack(
                                      alignment: Alignment.centerLeft,
                                      children: [
                                        Center(child: Text("$questionTitle",//title:の記述削除
                                            style: AppTextStyles.textBoldNormal,
                                            overflow: TextOverflow.ellipsis
                                        )),
                                        Align(
                                          alignment: Alignment.centerRight,
                                          child: GestureDetector(
                                            //TODO:押して保存。保存されている場合は保存解除
                                            onTap: () async{
                                              print("tapped");
                                              //TODO:該当するQuestionが既にFireStoreに存在するかどうか確認する処理。
                                              var _result = await FavoriteQuestionFireStore.getFavoriteQuestion(currentUserId, questionId);
                                              if(_result is String){//正常(FireStoreに値があり、既にお気に入りとなっていた時は)
                                                //TODO:お気に入りを削除
                                                await _deleteFavoriteDialogBuilder(context, ref, _result);
                                                ScaffoldMessenger.of(context).showSnackBar(AppSnackBar.deletingFavoriteQuestionIsSuccessful);
                                                print("_result が　String");
                                                print("_result:$_result");
                                              } else {//お気に入り未登録の時→お気に入り登録処理
                                                var result = await createFavoriteQuestion(currentUserId, questionId);//お気に入り保存処理
                                                if(result == true){//保存処理の成功で、trueが返ってきた時は
                                                  ref.read(isFavoriteProvider.notifier).state = true;//まずお気に入り登録をtrueにする
                                                  print("createFavoriteQuestionの結果がtrue");
                                                  ScaffoldMessenger.of(context).showSnackBar(AppSnackBar.settingFavoriteQuestionIsSuccessful);
                                                } else {
                                                  ScaffoldMessenger.of(context).showSnackBar(AppSnackBar.settingFavoriteQuestionIsFailed);
                                                }
                                                print("_result:$_result");
                                              }
                                              },
                                            child: Container(
                                              height: 90,
                                              width: 70,
                                              child: Center(
                                                  child: isFavorite
                                                  ? Icon(Icons.add, size: 26, color: AppColors.mainGray)
                                                  : Icon(Icons.add, size: 26, color: AppColors.mainGray)
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
                            ),
                          ),
                        );
                      }
                  );
                } else {
                  return const NormalCircularIndicator();
                }
              }
          )
      ),
    );
  }
// Widget build(BuildContext context) {
//   return Scaffold(
//     body: SafeArea(
//       child: CustomScrollView(
//         slivers: <Widget>[
//           SliverAppBar(
//             automaticallyImplyLeading: false,
//             pinned: false,
//             snap: false,
//             floating: true,
//             expandedHeight: 10.0,
//             flexibleSpace: Container(
//               color: Colors.cyan,
//               height: 300,
//               child: const FlexibleSpaceBar(
//                 title: Text('SliverAppBar',style: TextStyle(color: AppColors.mainBlue)),
//               ),
//             ),
//           ),
//           SliverList(
//             delegate: SliverChildBuilderDelegate(
//                   (BuildContext context, int index) {
//                 return Container(
//                   color: index.isOdd ? Colors.white : Colors.black12,
//                   height: 100.0,
//                   child: Center(
//                     child: Text('${index + 1}', textScaleFactor: 2),
//                   ),
//                 );
//               },
//               childCount: 20,
//             ),
//           ),
//         ],
//       ),
//     ),
//   );
// }
}