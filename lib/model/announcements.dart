import 'package:cloud_firestore/cloud_firestore.dart';

class Announcements {
  String announcementsId;
  String announcementsTitle;
  String announcementContent;
  Timestamp? createdAt;

  Announcements({this.announcementsId = '',this.announcementsTitle = '' , this.announcementContent = ''});
}