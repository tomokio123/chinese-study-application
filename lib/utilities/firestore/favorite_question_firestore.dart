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
        'favorite_question_id': questionId,//favorite_question_idフィールドには取ってきたquestionのidを入れ、
        'user_id': accountId //user_idフィールドにはQuestionテーブルのquestionIdを入れる
      })
          .then((value) => print("お気に入り問題保存に成功"));
      return true;
      //.catchError((error) => print("FireStore新規問題投稿に失敗: $error"));
    } on Exception catch(e){
      print('お気に入り問題保存エラー：$e');
    }
  }
  static Future<dynamic> getFavoriteQuestionIdList(String userId) async{
    //今のところ使ってない
    try{
      //user_idに一致する
      DocumentSnapshot documentSnapshot = await favoriteQuestions.doc(userId).get();
      //ドキュメントIdに対応するドキュメントを取ってくる
      Map<String, dynamic> data = documentSnapshot.data() as Map<String, dynamic>;
      FavoriteQuestion favoriteQuestionIdList = FavoriteQuestion(
        //favoriteQuestionIdはFireStoreの自動ID,
        questionId: data['question_id'],
        accountId: data['user_id']
      );
      print('ユーザー取得完了');
      return favoriteQuestionIdList;
    } on FirebaseException catch(e){
      print('ユーザー取得完了エラー: $e');
      return false;
    }
  }
}