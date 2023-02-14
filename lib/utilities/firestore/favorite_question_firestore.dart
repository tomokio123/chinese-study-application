import 'package:chinese_study_applicaion/model/account.dart';
import 'package:chinese_study_applicaion/model/question.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../model/favorite_questions.dart';
class FavoriteQuestionFireStore {
  static final _fireStoreInstance = FirebaseFirestore.instance;
  static final CollectionReference questions = _fireStoreInstance.collection('questions');
  static final CollectionReference favoriteQuestions = _fireStoreInstance.collection('favorite_questions');
  //FireStoreをUsersっていうコレクション名にしたのはやらかした。。。。。以後リファクタリングする
  static Future<dynamic> setFavoriteQuestion(Account account, Question question) async{
    //FavoriteQuestionをfireStoreに登録する処理
    try{
      //TODO:今回は[docID]=>[自分のユーザID]とし、それに一致するfavorite_questionを取得できるようにしたい
      //「favoriteQuestions」コレクションの、任意のドキュメントIdを自動生成してフィールドに値を登録。
      await favoriteQuestions.add({//今回は自分のユーザID(account.id)を入れる
        // 1.「set」メソッド => docIdを任意の文字列にしてデータ登録
        // 2.「add」メソッド => decIdを自動にしてデータ登録
        'favorite_question_id': question.questionId,//favorite_question_idには取ってきたquestionのidを入れ、
        'account_id': account.id //account_idには
      })
          .then((value) => print("FireStore新規カテゴリ投稿に成功"));
      return true;
      //.catchError((error) => print("FireStore新規問題投稿に失敗: $error"));
    } on Exception catch(e){
      print('新規カテゴリ投稿エラー：$e');
    }
  }
  static Future<dynamic> getFavoriteQuestion(String documentId) async{
    try{
      DocumentSnapshot documentSnapshot = await favoriteQuestions.doc(documentId).get();
      //ドキュメントIdに対応するドキュメントを取ってくる
      Map<String, dynamic> data = documentSnapshot.data() as Map<String, dynamic>;
      FavoriteQuestion favoriteQuestion = FavoriteQuestion(
        favoriteQuestionId: documentId,
        questionId: data['question_id'],
        accountId: data['user_id']
      );
      print('ユーザー取得完了');
      return favoriteQuestion;
    } on FirebaseException catch(e){
      print('ユーザー取得完了エラー: $e');
      return false;
    }
  }
}