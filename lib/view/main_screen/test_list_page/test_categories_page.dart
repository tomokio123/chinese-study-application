import 'package:chinese_study_applicaion/utilities/app_colors.dart';
import 'package:chinese_study_applicaion/utilities/firestore/category_firestore.dart';
import 'package:chinese_study_applicaion/view/common_widget/Indicators/normal_circular_indicator.dart';
import 'package:chinese_study_applicaion/view/common_widget/common_containers/common_containers.dart';
import 'package:chinese_study_applicaion/view/main_screen/test_list_page/question_page/question_page.dart';
import 'package:chinese_study_applicaion/view/main_screen/test_list_page/unannounced_test_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../../../utilities/app_text_styles.dart';
import '../../../utilities/firestore/question_firestore.dart';

class TestCategoriesPage extends StatelessWidget {
   const TestCategoriesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // final Size size = MediaQuery.of(context).size;
    return Scaffold(
      // backgroundColor: AppColors.mainWhite,
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
      body: SafeArea(
        child: FutureBuilder<QuerySnapshot>(
          future: CategoryFireStore.categories.get(),
            //Categoryをget。これメソッドをCategoryFireStoreにstaticで分けるよりCategoryFireStore.categories.get()
            //で直接書いた方なんか動きがいい。調べる
          builder: (context, snapshot) {
            if(snapshot.hasData){
              return ListViewBuilderContainer(context: context, snapshot: snapshot, destinationPageName: "QuestionPage");
            } else {
              return const NormalCircularIndicator();
            }
          }
        )
      ),
      floatingActionButton: FloatingActionButton.large(
        onPressed: () async{
          var totalNumberOfQuestion = await QuestionFireStore.getQuestionNumber();
          if(totalNumberOfQuestion is int){//int型が帰ってきた時だけ遷移できるようにする
            Navigator.push(context, MaterialPageRoute(builder: (context) => UnannouncedTestPage(
              totalNumberOfQuestions: totalNumberOfQuestion,
            )));
            print("totalNumberOfQuestion:$totalNumberOfQuestion");
          } else {
            print("questionNumberResultがFalse");
          }
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
