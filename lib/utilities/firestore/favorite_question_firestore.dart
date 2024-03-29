import 'package:chinese_study_applicaion/model/account.dart';
import 'package:chinese_study_applicaion/model/question.dart';
import 'package:chinese_study_applicaion/utilities/firestore/user_firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../model/favorite_questions.dart';
class FavoriteQuestionFireStore {
  static final _fireStoreInstance = FirebaseFirestore.instance;
  //static final CollectionReference questions = _fireStoreInstance.collection('questions');
  static final CollectionReference favoriteQuestions = _fireStoreInstance.collection('favorite_questions');
  static final String currentUserId = FirebaseAuth.instance.currentUser!.uid;
  //FireStoreをUsersっていうコレクション名にしたのはやらかした。。。。。以後リファクタリングする

  static Future<dynamic> setFavoriteQuestion({required String accountId, required String questionId}) async{
    //FavoriteQuestionをfireStoreに登録する処理
    try{
      //TODO:今回は[docID]=>[自動ID]とする
      //「favoriteQuestions」コレクションの、任意のドキュメントIdを自動生成してフィールドに値を登録。
      final String randomId = favoriteQuestions.doc().id;//TODO:ここでランダムなdocIdを作る
      await favoriteQuestions.doc(randomId).set({//TODO:上で作ったランダムなIdをdoc()とfavorite_question_id
        // 1.「set」メソッド => docIdを任意の文字列にしてデータ登録
        // 2.「add」メソッド => decIdを自動にしてデータ登録
        'favorite_question_id': randomId,//お気に入り問題特有のIDを持たせる。
        // お気に入り問題テーブルとはすなわち「question_id」と「user_id」の組み合わせであるので、その組み合わせに「自動ID」をつけるイメージ
        'question_id': questionId,//favorite_question_idフィールドには取ってきたquestionのidを入れ、
        'user_id': accountId //user_idフィールドにはQuestionテーブルのquestionIdを入れる

      })
          .then((value) => print("お気に入り問題保存に成功"));
      return true;
      //.catchError((error) => print("FireStore新規問題投稿に失敗: $error"));
    } on Exception catch(e){
      print('お気に入り問題保存エラー：$e');
    }
  }
  // static Future<dynamic> getFavoriteQuestionId(String favoriteQuestionId) async{
  //   //TODO:user_idに一致するものを取ってくる
  //   //今のところ使ってない
  //   try{
  //     DocumentSnapshot documentSnapshot = await favoriteQuestions.doc(favoriteQuestionId).get();//doc()に何か具体的な値を持たせないと'Null' is not a subtype 、、てなる
  //     Map<String, dynamic> data = documentSnapshot.data() as Map<String, dynamic>;
  //     FavoriteQuestion favoriteQuestion = FavoriteQuestion(
  //       //favoriteQuestionIdはFireStoreの自動ID,
  //       favoriteQuestionId: data['favorite_question_id'],
  //       questionId: data['question_id'],
  //       accountId: data['user_id']
  //     );
  //     if(favoriteQuestions != null){
  //       //fireStoreから取ってきたquestionId,accountIdが引数で渡したものと完全一致したら
  //       print('お気に入り問題取得完了');
  //       return favoriteQuestion;
  //     } else {
  //       return false;//すでにお気に入り登録されている
  //     }
  //   } on FirebaseException catch(e){
  //     print('お気に入り問題取得エラー: $e');
  //     return false;
  //   }
  // }
  static Future<dynamic> getFavoriteQuestion(String userId, String questionId) async{
    try{
      var result = await FavoriteQuestionFireStore.favoriteQuestions.
      where("question_id", isEqualTo: questionId).where("user_id", isEqualTo: userId).get();
      if(result == null){return false;}
      if(result != null){
        final String _result = result.docs.first.get("favorite_question_id");
        return _result;
      }
    } on FirebaseException catch(e){
      print('お気に入り問題取得エラー: $e');
      return false;
    } catch (e){
      return false;
    }
  }

  static Future<void> deleteFavoriteQuestion(String favoriteQuestionId) async{//TODO:次はお気に入り解除してデータを消すところまでやる
    try{
      await FavoriteQuestionFireStore.favoriteQuestions.doc(favoriteQuestionId).delete();//favoriteQuestionデーブルの中からfavoriteQuestionIdを消す
    } on FirebaseException catch(e){
      print('お気に入り問題取得エラー: $e');
    }
  }

  //TODO:currentUserId と同じフィールド値をもつfavoriteQuestionsを取得
  //TODO:からの(.then)、取ってきた複数の要素をforeachで展開してその要素のdocId(element.reference.id)を消していく。
  static Future<void> deleteAllFavoriteQuestion() async{//TODO:次はお気に入り解除してデータを消すところまでやる
    try{
      FavoriteQuestionFireStore.favoriteQuestions.where("user_id", isEqualTo: currentUserId).get().
      // TODO:以下で取得したdocIDを使ってドキュメント削除
      then((QuerySnapshot snapshot) => snapshot.docs.forEach((element) {
        FavoriteQuestionFireStore.favoriteQuestions.doc(element.reference.id).delete();
      }));//favoriteQuestionデーブルの中からfavoriteQuestionIdを消す
    } on FirebaseException catch(e){
      print('お気に入り問題取得エラー: $e');
    }
  }
}