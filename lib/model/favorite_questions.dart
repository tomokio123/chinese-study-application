import 'package:cloud_firestore/cloud_firestore.dart';

class FavoriteQuestion {
  String favoriteQuestionId;//このIdはFireBaseの自動IdでOK
  String accountId;
  String questionId;

  FavoriteQuestion({this.favoriteQuestionId = '', this.accountId = '', this.questionId = ''});
}