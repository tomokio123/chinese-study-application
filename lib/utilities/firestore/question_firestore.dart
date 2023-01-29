import 'package:chinese_study_applicaion/model/question.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class QuestionFireStore {
  static final _fireStoreInstance = FirebaseFirestore.instance;
  static final CollectionReference questions = _fireStoreInstance.collection('questions');

  static Future<dynamic> setQuestion(Question newQuestion, String documentId) async{//ユーザーをfirestoreに登録する処理
    try{
      await questions.doc(documentId).set({//データの追加は「set」メソッド
        'title': newQuestion.title,
        'answer_id': newQuestion.answerId,
        'category_id': newQuestion.categoryId,
      })
          .then((value) => print("FireStore新規問題投稿に成功"))
          .catchError((error) => print("FireStore新規問題投稿に失敗: $error"));
      return true;
    } on FirebaseException catch(e){
      print('新規問題投稿エラー $e');
      return false;
    }
  }

  static Future<dynamic> getQuestion(String questionId) async{
    try{
      DocumentSnapshot documentSnapshot = await questions.doc(questionId).get();
      Map<String, dynamic> data = documentSnapshot.data() as Map<String, dynamic>;
      Question question = Question(
        id: questionId,
        title: data['title'],
        answerId: data['answer_id'],
        categoryId: data['category_id']
      );
      print('ユーザー取得完了');
      return question;
    } on FirebaseException catch(e){
      print('ユーザー取得完了エラー: $e');
      return false;
    }
  }
}