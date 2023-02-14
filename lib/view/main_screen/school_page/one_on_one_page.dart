import 'package:chinese_study_applicaion/utilities/app_colors.dart';
import 'package:chinese_study_applicaion/utilities/firestore/category_firestore.dart';
import 'package:chinese_study_applicaion/utilities/firestore/favorite_question_firestore.dart';
import 'package:chinese_study_applicaion/utilities/firestore/question_firestore.dart';
import 'package:chinese_study_applicaion/view/common_widget/Indicators/normal_circular_indicator.dart';
import 'package:chinese_study_applicaion/view/main_screen/words_list_page/question_page/question_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../../../utilities/app_text_styles.dart';

class OneOnOnePage extends StatelessWidget {
  OneOnOnePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('一問一答ページ'), iconTheme: IconThemeData(color: AppColors.mainBlue)),
      body: Container(
        padding: EdgeInsets.fromLTRB(12,12,12,0),
        child: FutureBuilder<QuerySnapshot>(
          future: QuestionFireStore.questions.get(),
          builder: (context, snapshot) {
            if(snapshot.hasData){
              return GridView.count(
                  crossAxisCount: 3,
                  mainAxisSpacing: 12,
                  crossAxisSpacing: 12,
                  children: List.generate(snapshot.data!.size, (index) => GestureDetector(
                    onTap: (){
                      //Navigator.push(context, MaterialPageRoute(builder: (context)=> OneOnOnePage()));
                    },
                    child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        color: AppColors.mainWhite,
                        elevation: 5,
                        child: Center(child: Text('${index + 1}', style: AppTextStyles.textBold))
                    ),
                  ))
              );
            } else {
              return Container();
            }
          }
        ),
      ),
    );
  }
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     appBar: AppBar(title: Text('一問一答ページ'), iconTheme: IconThemeData(color: AppColors.mainBlue)),
  //     body: SafeArea(
  //       child: Container(
  //         color: AppColors.mainWhite,
  //         padding: EdgeInsets.fromLTRB(12,12,12,0),
  //         child: FutureBuilder<QuerySnapshot>(
  //           future: QuestionFireStore.questions.get(),
  //           builder: (context, snapshot) {
  //             if(snapshot.hasData){
  //               return GridView.count(
  //                   crossAxisCount: 2,
  //                   mainAxisSpacing: 12,
  //                   crossAxisSpacing: 12,
  //                   children: List.generate(snapshot.data!.size, (index) => GestureDetector(
  //                     onTap: (){
  //                       // Navigator.push(context, MaterialPageRoute(builder: (context)=> OneOnOnePage()));
  //                     },
  //                     child: Card(
  //                         shape: RoundedRectangleBorder(
  //                           borderRadius: BorderRadius.circular(10),
  //                         ),
  //                         color: AppColors.mainWhite,
  //                         elevation: 5,
  //                         child: Center(child: Text('${index + 1}', style: AppTextStyles.textBold))
  //                     ),
  //                   ))
  //               );
  //             } else {
  //               return Container();
  //             }
  //           }
  //         ),
  //       ),
  //     ),
  //   );
  // }
}