import 'package:cloud_firestore/cloud_firestore.dart';

class Account {
  String id;
  String name;
  String email;
  String password;
  String favoriteQuestionId;
  Timestamp? createdAt;

  Account({this.id = '', this.name = 'UnKnown', this.email = '',
    this.password = '', this.favoriteQuestionId = '', this.createdAt});
}