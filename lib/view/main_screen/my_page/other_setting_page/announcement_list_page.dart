import 'package:chinese_study_applicaion/Utilities/app_colors.dart';
import 'package:chinese_study_applicaion/utilities/firestore/announcement_firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../utilities/app_text_styles.dart';

class AnnouncementListPage extends StatelessWidget {
  const AnnouncementListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final announcementStream = AnnouncementFireStore.announcements.orderBy('created_at',descending: true).snapshots();
    return Scaffold(
      appBar: AppBar(
          iconTheme: const IconThemeData(color: AppColors.mainBlue),
          title: const Text('AnnouncementPage',style: TextStyle(color: AppColors.mainBlue)),
          backgroundColor: AppColors.mainWhite),
        body: SafeArea(
            child: Center(
              child: StreamBuilder<QuerySnapshot>(
                stream: announcementStream,
                builder: (context, snapshot) {
                  if(snapshot.hasData){
                    // final List<DocumentSnapshot> documents = snapshot.data!.docs;
                    return ListView.builder(
                        padding: const EdgeInsets.all(2),
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (BuildContext context, int index) {
                          //category_titleを変数に格納
                          final String title = snapshot.data!.docs[index].get("announcements_title");
                          final Timestamp createdAt = snapshot.data!.docs[index].get("created_at");
                          return Container(
                            padding: EdgeInsets.all(4),
                            child: GestureDetector(
                              onTap: (){
                                // Navigator.push(context, MaterialPageRoute(builder: (context) => VocabularyPage(
                                //     categoryId: snapshot.data!.docs[index].get("category_id")
                                // )));
                              },
                              child: Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                color: AppColors.mainWhite,
                                elevation: 3,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Container(
                                        height: 70,
                                        child: Center(child: Text(title,
                                            style: AppTextStyles.textBoldNormalSmaller,
                                            //maxLines: 1,
                                            overflow: TextOverflow.ellipsis
                                        )),
                                      ),
                                      Container(
                                        //height: 30,
                                        child: Center(
                                            child: Text(
                                                DateFormat('yyyy年MM月dd日-H時m分').format(createdAt.toDate()),
                                                style: AppTextStyles.textMini
                                            )
                                        ),
                                      ),
                                      // SizedBox(height: 20)
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        }
                    );
                  } else {
                    return Container();
                  }
                }
              ),
            ))
    );
  }
}
