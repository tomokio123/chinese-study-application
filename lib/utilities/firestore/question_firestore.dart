import 'package:chinese_study_applicaion/model/question.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class QuestionFireStore {
  static final _fireStoreInstance = FirebaseFirestore.instance;
  static final CollectionReference questions = _fireStoreInstance.collection('questions');

  static Future<dynamic> setQuestion(Question newQuestion, String documentId) async{//ユーザーをfirestoreに登録する処理
    try{
      await questions.doc(documentId).set({//データの追加は「set」メソッド
        'question_id': newQuestion.questionId,
        'title': newQuestion.title,
        'answer_id': newQuestion.answerId,
        'category_id': newQuestion.categoryId,
      })
          .then((value) => print("FireStore新規問題投稿に成功"));
          //.catchError((error) => print("FireStore新規問題投稿に失敗: $error"));
      return true;
    } on Exception catch(e){
      print('新規問題投稿エラー：$e');
    }
  }
  //TODO:questionテーブルの総数を求めて返す処理を描きたい
  static Future<dynamic> getQuestionNumber() async{
    try{
      QuerySnapshot querySnapshot = await questions.get();
      final int totalNumberOfQuestion = querySnapshot.size;
      print('全問題の総数:$totalNumberOfQuestion');
      print('全問題の総数取得完了');
      return totalNumberOfQuestion;
    } on FirebaseException catch(e){
      print('全問題の総数取得完了エラー: $e');
      return false;
    }
  }
}