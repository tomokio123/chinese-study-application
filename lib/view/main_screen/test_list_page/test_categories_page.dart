import 'package:chinese_study_applicaion/utilities/app_colors.dart';
import 'package:chinese_study_applicaion/utilities/firestore/category_firestore.dart';
import 'package:chinese_study_applicaion/view/common_widget/Indicators/normal_circular_indicator.dart';
import 'package:chinese_study_applicaion/view/main_screen/test_list_page/question_page/question_page.dart';
import 'package:chinese_study_applicaion/view/main_screen/test_list_page/unannounced_test_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../../../utilities/app_text_styles.dart';

class TestCategoriesPage extends StatelessWidget {
   const TestCategoriesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
      body: SafeArea(
        child: FutureBuilder<QuerySnapshot>(
          future: CategoryFireStore.categories.get(),
            //Categoryをget。これメソッドをCategoryFireStoreにstaticで分けるよりCategoryFireStore.categories.get()
            //で直接書いた方なんか動きがいい。調べる。
          builder: (context, snapshot) {
            if(snapshot.hasData){
              return ListView.builder(
                  padding: const EdgeInsets.all(2),
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (BuildContext context, int index) {
                    //category_titleを変数に格納
                    final String title = snapshot.data!.docs[index].get("category_title");
                    return Container(
                      padding: EdgeInsets.all(4),
                      child: GestureDetector(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context) => QuestionPage(
                            categoryId: snapshot.data!.docs[index].id
                          )));
                        },
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          color: AppColors.mainWhite,
                          elevation: 3,
                          child: Container(
                            height: 90,
                            child: Center(child: Text(title,
                                style: AppTextStyles.textBoldNormal,
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
              return const NormalCircularIndicator();
            }
          }
        )
      ),
      floatingActionButton: FloatingActionButton.large(
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context) => UnannouncedTestPage(categoryId: "fruits")));
        },
          backgroundColor: AppColors.mainBlue,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(child: Text("抜き打ち", style: TextStyle(fontWeight: FontWeight.bold))),
              Center(child: Text('Test!', style: TextStyle(fontWeight: FontWeight.bold)))
            ],
          ),
        ),
      ),
    );
  }
}