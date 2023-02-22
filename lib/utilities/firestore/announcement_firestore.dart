import 'package:chinese_study_applicaion/model/difficulty.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
class AnnouncementFireStore {
  static final _fireStoreInstance = FirebaseFirestore.instance;
  static final CollectionReference announcements = _fireStoreInstance.collection('announcements');

  // static Future<dynamic> getAnnouncement() async {
  //   try {
  //     DocumentSnapshot documentSnapshot = await announcements.orderBy('created_at',descending: true).snapshots();
  //     Map<String, dynamic> data = documentSnapshot.data() as Map<String, dynamic>;
  //     Difficulty difficulty = Difficulty(
  //         difficultyId: data["difficulty_id"],
  //         difficultyTitle: data["difficulty_title"]
  //     );
  //     print('難易度取得完了');
  //     return difficulty;
  //   } on FirebaseException catch (e) {
  //     print('難易度取得完了エラー: $e');
  //     return false;
  //   }
  // }
}