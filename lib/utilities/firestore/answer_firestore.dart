import 'package:cloud_firestore/cloud_firestore.dart';

import '../../model/answer.dart';

class AnswerFireStore {
  static final _fireStoreInstance = FirebaseFirestore.instance;
  static final CollectionReference answers = _fireStoreInstance.collection('answers');

  static Future<dynamic> getAnswer(String uid) async{
    try{
      DocumentSnapshot documentSnapshot = await answers.doc(uid).get();
      Map<String, dynamic> data = documentSnapshot.data() as Map<String, dynamic>;
      Answer answer = Answer(
        id: uid,
        correctAnswerIndexNumber: data['correct_answer_index_number'],
        answer1: data['answer1'],
        answer2: data['answer2'],
        answer3: data['answer3'],
        answer4: data['answer4'],
        commentary: data['commentary']
      );
      print('ユーザー取得完了');
      return answer;
    } on FirebaseException catch(e){
      print('ユーザー取得完了エラー: $e');
      return false;
    }
  }

}