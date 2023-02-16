import 'package:chinese_study_applicaion/utilities/firestore/question_firestore.dart';
import 'package:chinese_study_applicaion/view/main_screen/vocabulary_list_page/vocabulary_content_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../../../utilities/app_colors.dart';
import '../../../utilities/app_text_styles.dart';
import '../../common_widget/Indicators/normal_circular_indicator.dart';

class VocabularyPage extends StatelessWidget {
  final String categoryId;
  const VocabularyPage({Key? key, required this.categoryId}) : super(key: key);

  final bool isFavorite = false;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final questionFuture = QuestionFireStore.questions.where('category_id', isEqualTo: categoryId).get();

    return Scaffold(
      appBar: AppBar(title: Text("vocabularyPage"), iconTheme: IconThemeData(color: AppColors.mainBlue),),
      body: SafeArea(
          child: FutureBuilder<QuerySnapshot>(
              future: questionFuture,
              builder: (context, snapshot) {
                if(snapshot.hasData){
                  return ListView.builder(
                      padding: const EdgeInsets.all(2),
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (BuildContext context, int index) {
                        //category_titleを変数に格納
                        final String questionTitle = snapshot.data!.docs[index].get("title");
                        return Container(
                          padding: EdgeInsets.all(4),
                          child: GestureDetector(
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context) => VocabularyContentPage()));
                            },
                            child: Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              color: AppColors.mainWhite,
                              elevation: 3,
                              child: Container(
                                height: 90,
                                child: Center(
                                  child: Container(
                                    child: Stack(
                                      alignment: Alignment.topLeft,
                                      children: [
                                        Center(child: Text("title:$questionTitle",
                                            style: AppTextStyles.textBoldNormal,
                                            overflow: TextOverflow.ellipsis
                                        )),
                                        Align(
                                          alignment: Alignment.centerRight,
                                          child: GestureDetector(
                                            onTap: (){print("tapped");},
                                            child: Container(
                                              height: 50,
                                              width: 50,
                                              child: Center(
                                                  child: isFavorite
                                                  ? Icon(Icons.star_outline, size: 20)
                                                  : Icon(Icons.star_rate_sharp, size: 20, color: AppColors.mainPink,)
                                              ),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
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
    );
  }
// Widget build(BuildContext context) {
//   return Scaffold(
//     body: SafeArea(
//       child: CustomScrollView(
//         slivers: <Widget>[
//           SliverAppBar(
//             automaticallyImplyLeading: false,
//             pinned: false,
//             snap: false,
//             floating: true,
//             expandedHeight: 10.0,
//             flexibleSpace: Container(
//               color: Colors.cyan,
//               height: 300,
//               child: const FlexibleSpaceBar(
//                 title: Text('SliverAppBar',style: TextStyle(color: AppColors.mainBlue)),
//               ),
//             ),
//           ),
//           SliverList(
//             delegate: SliverChildBuilderDelegate(
//                   (BuildContext context, int index) {
//                 return Container(
//                   color: index.isOdd ? Colors.white : Colors.black12,
//                   height: 100.0,
//                   child: Center(
//                     child: Text('${index + 1}', textScaleFactor: 2),
//                   ),
//                 );
//               },
//               childCount: 20,
//             ),
//           ),
//         ],
//       ),
//     ),
//   );
// }
}