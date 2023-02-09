import 'package:cloud_firestore/cloud_firestore.dart';

import '../../model/answer.dart';

class AnswerFireStore {
  static final _fireStoreInstance = FirebaseFirestore.instance;
  static final CollectionReference answers = _fireStoreInstance.collection('answers');

  static Future<dynamic> setAnswer(Answer newAnswer, String answerId) async{
    //解答をfireStoreに登録する処理
    try{
      await answers.doc(answerId).set({//データの追加は「set」メソッド
        'answer_id': newAnswer.answerId,
        'answer1': newAnswer.answer1,
        'answer2': newAnswer.answer2,
        'answer3': newAnswer.answer3,
        'answer4': newAnswer.answer4,
        'commentary': newAnswer.commentary,
        'correct_answer_index_number': newAnswer.correctAnswerIndexNumber,
      })
          .then((value) => print("FireStore新規解答投稿に成功"));
      return true;
      //.catchError((error) => print("FireStore新規問題投稿に失敗: $error"));
    } on Exception catch(e){
      print('新規解答投稿エラー：$e');
    }
  }

  // static Future<dynamic> getAnswer(String uid) async{
  //   try{
  //     DocumentSnapshot documentSnapshot = await answers.doc(uid).get();
  //     Map<String, dynamic> data = documentSnapshot.data() as Map<String, dynamic>;
  //     Answer answer = Answer(
  //       answerId: data['answer_id'],
  //       correctAnswerIndexNumber: data['correct_answer_index_number'],
  //       answer1: data['answer1'],
  //       answer2: data['answer2'],
  //       answer3: data['answer3'],
  //       answer4: data['answer4'],
  //       commentary: data['commentary']
  //     );
  //     print('ユーザー取得完了');
  //     return answer;
  //   } on FirebaseException catch(e){
  //     print('ユーザー取得完了エラー: $e');
  //     return false;
  //   }
  // }
}