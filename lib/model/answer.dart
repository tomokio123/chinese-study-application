import 'package:cloud_firestore/cloud_firestore.dart';

class Answer {
  String id;
  String correctAnswerIndexNumber;
  String answer1;
  String answer2;
  String answer3;
  String answer4;
  String commentary;

  Answer({this.id = '', this.correctAnswerIndexNumber = '', this.answer1 = '',
    this.answer2 = '', this.answer3 = '', this.answer4 = '',this.commentary = ''});
}