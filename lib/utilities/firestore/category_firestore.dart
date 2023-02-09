import 'package:chinese_study_applicaion/model/category.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
class CategoryFireStore {
  static final _fireStoreInstance = FirebaseFirestore.instance;
  static final CollectionReference categories= _fireStoreInstance.collection('categories');

  static Future<QuerySnapshot> getCategory() async{
      return CategoryFireStore.categories.get();
  }

  static Future<dynamic> setCategory(Category newCategory, String categoryId) async{
    //解答をfireStoreに登録する処理
    try{
      await categories.doc(categoryId).set({//データの追加は「set」メソッド
        'category_id': newCategory.categoryId,
        'category_title': newCategory.categoryTitle
      })
          .then((value) => print("FireStore新規カテゴリ投稿に成功"));
      return true;
      //.catchError((error) => print("FireStore新規問題投稿に失敗: $error"));
    } on Exception catch(e){
      print('新規カテゴリ投稿エラー：$e');
    }
  }
}