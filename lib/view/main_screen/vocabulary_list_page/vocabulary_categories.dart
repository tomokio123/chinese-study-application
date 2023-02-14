import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../../../utilities/app_colors.dart';
import '../../../utilities/app_text_styles.dart';
import '../../../utilities/firestore/category_firestore.dart';
import '../../common_widget/Indicators/normal_circular_indicator.dart';

class VocabularyCategoriesPage extends StatelessWidget {
  const VocabularyCategoriesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(title: Text("単語帳ページ")),
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
                              // Navigator.push(context, MaterialPageRoute(builder: (context) => QuestionPage(
                              //     categoryId: snapshot.data!.docs[index].id
                              // )));
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
