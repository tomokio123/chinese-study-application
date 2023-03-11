import 'package:chinese_study_applicaion/model/account.dart';
import 'package:chinese_study_applicaion/model/question.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../model/favorite_questions.dart';
class FavoriteQuestionFireStore {
  static final _fireStoreInstance = FirebaseFirestore.instance;
  //static final CollectionReference questions = _fireStoreInstance.collection('questions');
  static final CollectionReference favoriteQuestions = _fireStoreInstance.collection('favorite_questions');
  //FireStoreをUsersっていうコレクション名にしたのはやらかした。。。。。以後リファクタリングする
  static Future<dynamic> setFavoriteQuestion({required String accountId, required String questionId}) async{
    //FavoriteQuestionをfireStoreに登録する処理
    try{
      //TODO:今回は[docID]=>[自動ID]とする
      //「favoriteQuestions」コレクションの、任意のドキュメントIdを自動生成してフィールドに値を登録。
      await favoriteQuestions.add({//今回は自分のユーザID(account.id)を入れる
        // 1.「set」メソッド => docIdを任意の文字列にしてデータ登録
        // 2.「add」メソッド => decIdを自動にしてデータ登録
        'question_id': questionId,//favorite_question_idフィールドには取ってきたquestionのidを入れ、
        'user_id': accountId //user_idフィールドにはQuestionテーブルのquestionIdを入れる
      })
          .then((value) => print("お気に入り問題保存に成功"));
      return true;
      //.catchError((error) => print("FireStore新規問題投稿に失敗: $error"));
    } on Exception catch(e){
      print('お気に入り問題保存エラー：$e');
    }
  }
  static Future<dynamic> getFavoriteQuestion(String userId, String questionId) async{
    //TODO:user_idに一致するものを取ってくる
    //今のところ使ってない
    try{
      DocumentSnapshot documentSnapshot = await favoriteQuestions.doc().get();//doc()に何か具体的な値を持たせないと'Null' is not a subtype 、、てなる
      Map<String, dynamic> data = documentSnapshot.data() as Map<String, dynamic>;
      FavoriteQuestion favoriteQuestion = FavoriteQuestion(
        //favoriteQuestionIdはFireStoreの自動ID,
        questionId: data['question_id'],
        accountId: data['user_id']
      );
      if(favoriteQuestion.questionId == questionId && favoriteQuestion.accountId == userId){
        //fireStoreから取ってきたquestionId,accountIdが引数で渡したものと完全一致したら
        print('お気に入り問題取得完了');
        return favoriteQuestion;
      } else {
        return false;//すでにお気に入り登録されている
      }
    } on FirebaseException catch(e){
      print('お気に入り問題取得エラー: $e');
      return false;
    }
  }
}