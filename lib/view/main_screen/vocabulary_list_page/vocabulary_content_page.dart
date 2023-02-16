import 'package:chinese_study_applicaion/utilities/firestore/answer_firestore.dart';
import 'package:chinese_study_applicaion/utilities/firestore/question_firestore.dart';
import 'package:chinese_study_applicaion/utilities/provider/providers.dart';
import 'package:chinese_study_applicaion/view/main_screen/test_list_page/question_page/question_result_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../utilities/app_colors.dart';
import '../../../../utilities/app_text_styles.dart';

class VocabularyContentPage extends ConsumerWidget {
  const VocabularyContentPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //現在の単語帳ナンバーのindexを保持する。
    final int currentVocabularyIndex = ref.watch(currentVocabularyIndexProvider);

    return Scaffold(
      body: Center(
        child: SafeArea(
          child: Container(
            width: double.infinity,//目一杯広げる
            color: AppColors.mainPink,
            child: FutureBuilder<QuerySnapshot>(
                future: QuestionFireStore.questions.get(),
                builder: (context, snapshot) {
                  if(snapshot.hasData){
                    return Column(
                      children: [
                        Container(child: Text('${snapshot.data!.docs[currentVocabularyIndex].get("title")}')),
                        Container(child: Text('${snapshot.data!.docs[currentVocabularyIndex].get("question_id")}')),
                        Container(child: Text('${snapshot.data!.docs[currentVocabularyIndex].get("category_id")}')),
                      ],
                    );
                  } else {
                    return Container(child: Text('questionFutureがfalse'),);
                  }
                }
            ),
          ),
        ),
      ),
    );
  }
}