import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../utilities/app_colors.dart';
import '../../utilities/app_text_styles.dart';
import '../../utilities/firestore/difficulty_firestore.dart';
import '../main_screen/words_list_page/vocabulary_book/vocabulary_book_page.dart';

class DifficultyScreen extends StatelessWidget {
  final String categoryId;
  const DifficultyScreen({Key? key, required this.categoryId}) : super(key: key);



  @override
  Widget build(BuildContext context) {
    //final Size size = MediaQuery.of(context).size;
    return Container(
      color: AppColors.mainWhite,
      child: Scaffold(
        appBar: AppBar(
            title: const Text("DifficultyScreen"),
            iconTheme: const IconThemeData(color: AppColors.mainBlue)),
        body: SafeArea(
            child: FutureBuilder<QuerySnapshot>(
                future: DifficultyFireStore.difficulties.get(),
                builder: (context, snapshot) {
                  if(snapshot.hasData){
                    return ListView.builder(
                        padding: const EdgeInsets.all(8),
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Container(
                            padding: EdgeInsets.all(7),
                            child: GestureDetector(
                              onTap: (){
                                Navigator.push(context, MaterialPageRoute(builder: (context) => VocabularyBookPage(
                                    questionList: [],
                                )));
                              },
                              child: Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                color: AppColors.mainWhite,
                                elevation: 3,
                                child: Container(
                                  height: 120,
                                  child: Center(child: Text('${snapshot.data!.docs[index].get("difficulty_title")}',
                                      style: AppTextStyles.textNormal,
                                      //maxLines: 1,
                                      overflow: TextOverflow.ellipsis
                                  )),
                                ),
                              ),
                            ),
                          );
                        }
                    );
                  } else {
                    // return Text("${snapshot.hasData}です！");
                    return Container();
                  }
                }
            )
        ),
      ),
    );
  }
}
