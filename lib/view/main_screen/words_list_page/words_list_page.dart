import 'package:chinese_study_applicaion/utilities/app_colors.dart';
import 'package:chinese_study_applicaion/view/main_screen/words_list_page/vocabulary_book/vocabulary_book_page.dart';
import 'package:flutter/material.dart';

import '../../../utilities/app_text_styles.dart';

class WordsListPage extends StatelessWidget {
   WordsListPage({Key? key}) : super(key: key);

  final List<String> entries = <String>['1章　果物', '2　野菜', 'さいだいじゅうはちもじ。さいだいじゅ', '4', '5', '6', '7', '8'];

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: ListView.builder(
          padding: const EdgeInsets.all(8),
          itemCount: entries.length,
          itemBuilder: (BuildContext context, int index) {
            return Container(
              padding: EdgeInsets.all(7),
              child: GestureDetector(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => VocabularyBookPage()));
                },
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  color: AppColors.mainWhite,
                  elevation: 3,
                  child: Container(
                    height: 120,
                    child: Center(child: Text('${entries[index]}',
                        style: AppTextStyles.textNormal,
                    //maxLines: 1,
                    overflow: TextOverflow.ellipsis
                    )),
                  ),
                ),
              ),
            );
          }
      )
    );
  }
}