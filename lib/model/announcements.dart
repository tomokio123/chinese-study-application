import 'package:cloud_firestore/cloud_firestore.dart';

class Announcement {
  String announcementId;
  String announcementTitle;
  String announcementContent;
  Timestamp? createdAt;
  bool isRead;

  Announcement({this.announcementId = '',this.announcementTitle = '' , this.announcementContent = '',this.createdAt, required this.isRead});
}