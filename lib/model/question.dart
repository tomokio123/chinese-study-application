import 'package:cloud_firestore/cloud_firestore.dart';

class Question{
  String id;
  String title;
  String answerId;
  String categoryId;
  String difficultiesId;

  Question({this.id = '', this.title = '', this.answerId = '',
    this.categoryId = '', this.difficultiesId = ''});
}