import 'package:chinese_study_applicaion/utilities/app_colors.dart';
import 'package:chinese_study_applicaion/utilities/firestore/category_firestore.dart';
import 'package:chinese_study_applicaion/view/difficulty_screen/difficulty_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../../../utilities/app_text_styles.dart';

class WordsListPage extends StatelessWidget {
   WordsListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: FutureBuilder<QuerySnapshot>(
        future: CategoryFireStore.categories.get(),
          //Categoryをget。これメソッドをCategoryFireStoreにstaticで分けるよりCategoryFireStore.categories.get()
          //で直接書いた方なんか動きがいい。調べる。
        builder: (context, snapshot) {
          if(snapshot.hasData){
            return ListView.builder(
                padding: const EdgeInsets.all(8),
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (BuildContext context, int index) {
                  //category_titleを変数に格納
                  final String title = snapshot.data!.docs[index].get("category_title");
                  return Container(
                    padding: EdgeInsets.all(7),
                    child: GestureDetector(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => DifficultyScreen(
                          categoryId: title,
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
                          child: Center(child: Text(title,
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
    );
  }
}
