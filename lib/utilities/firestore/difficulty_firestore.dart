import 'package:chinese_study_applicaion/model/difficulty.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
class DifficultyFireStore {
  static final _fireStoreInstance = FirebaseFirestore.instance;
  static final CollectionReference difficulties = _fireStoreInstance.collection('difficulties');

  static Future<dynamic> getCategory(String difficultyId) async {
    try {
      DocumentSnapshot documentSnapshot = await difficulties.doc(difficultyId).get();
      Map<String, dynamic> data = documentSnapshot.data() as Map<String, dynamic>;
      Difficulty difficulty = Difficulty(
        difficultyId: data["difficulty_id"],
        difficultyTitle: data["difficulty_title"]
      );
      print('難易度取得完了');
      return difficulty;
    } on FirebaseException catch (e) {
      print('難易度取得完了エラー: $e');
      return false;
    }
  }
}