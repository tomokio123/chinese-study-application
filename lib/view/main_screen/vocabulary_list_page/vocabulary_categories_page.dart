import 'package:chinese_study_applicaion/view/main_screen/vocabulary_list_page/vocabulary_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../../../utilities/app_colors.dart';
import '../../../utilities/app_text_styles.dart';
import '../../../utilities/firestore/category_firestore.dart';
import '../../common_widget/Indicators/normal_circular_indicator.dart';
import '../../common_widget/common_containers/common_containers.dart';

class VocabularyCategoriesPage extends StatelessWidget {
  const VocabularyCategoriesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("単語帳ページ"),automaticallyImplyLeading: false,),
      body: SafeArea(
          child: FutureBuilder<QuerySnapshot>(
              future: CategoryFireStore.categories.get(),
              //Categoryをget。これメソッドをCategoryFireStoreにstaticで分けるよりCategoryFireStore.categories.get()
              //で直接書いた方なんか動きがいい。調べる。
              builder: (context, snapshot) {
                if(snapshot.hasData){
                  // Navigator.push(context, MaterialPageRoute(builder: (context) => QuestionPage(
                  //     categoryId: snapshot.data!.docs[index].id
                  // )));
                  return ListViewBuilderContainer(
                      context: context,
                      snapshot: snapshot, destinationPageName: 'VocabularyPage',//PageNameをしっかりかけ
                    // TODO:ここ改善案考えろ
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
