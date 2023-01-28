import 'package:chinese_study_applicaion/model/question.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class QuestionFireStore {
  static final _fireStoreInstance = FirebaseFirestore.instance;
  static final CollectionReference questions = _fireStoreInstance.collection('questions');

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