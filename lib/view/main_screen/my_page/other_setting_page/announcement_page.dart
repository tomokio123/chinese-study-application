import 'package:chinese_study_applicaion/Utilities/app_colors.dart';
import 'package:chinese_study_applicaion/utilities/app_text_styles.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AnnouncementPage extends StatelessWidget {
  final String announcementContent;
  final String announcementTitle;
  final Timestamp createdAt;
  const AnnouncementPage({Key? key,
    required this.announcementContent, required this.announcementTitle, required this.createdAt
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
          iconTheme: IconThemeData(color: AppColors.mainBlue),
          title: Text(announcementTitle,style: AppTextStyles.appBarTitleMini),
          backgroundColor: AppColors.mainWhite),
      body: Center(
        child: SafeArea(
          child: Container(
            // color: AppColors.mainPink,
            width: size.width,
            padding: EdgeInsets.all(40),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  margin: EdgeInsets.only(bottom: 20),
                  child: Padding(
                    padding: const EdgeInsets.all(6.0),
                    child: Text(announcementTitle),
                  ),
                  decoration: BoxDecoration(
                    // color: AppColors.mainGreen,
                    border: const Border(
                      bottom: const BorderSide(
                        color: AppColors.mainBlue,
                        width: 2,
                      ),
                    ),
                  ),
                ),
                Expanded(
                    child: Container(
                        child: Text("あ井上おっかいくけこさしせ絵おおおおおおおおおおおおあ井上おっかいくけこさしせ絵おおおおおおおおおおおおあ井上おっかいくけこさしせ絵おおおおおおおおおおおおあ井上おっかいくけこさしせ絵おおおおおおおおおおおお"),
                        // child: Text(announcementContent)
                    )
                ),
                Text(
                    DateFormat('yyyy年MM月dd日-H時m分更新').format(createdAt.toDate()),
                    style: AppTextStyles.textMini),
              ],
            ),
          )
        ),
      ),
    );
  }
}