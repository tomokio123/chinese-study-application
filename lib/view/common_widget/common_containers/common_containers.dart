import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../utilities/app_colors.dart';
import '../../../utilities/app_text_styles.dart';
import '../../../utilities/view_model/question_page_view_model.dart';
import '../../main_screen/test_list_page/question_page/question_page.dart';
import '../../main_screen/vocabulary_list_page/vocabulary_page.dart';

class CurrentQuestionIndexContainer extends Container{
  //何問目？とかを表示するための共通Container。
  final int currentQuestionIndex;
  CurrentQuestionIndexContainer({super.key, required this.currentQuestionIndex});

  @override
  // TODO: implement child
  Widget get child => Container(
    width: double.infinity,
    //color: AppColors.mainPink,
    padding: const EdgeInsets.only(top: 30),
    child: Center(
        child: Text("${currentQuestionIndex + 1} 問目",
          style: const TextStyle(fontSize: 20, decoration: TextDecoration.underline, color: AppColors.mainBlue),)
    ),
  );
}

class CenteredCommentaryContainer extends Container{
  //解説を表示するための共通Container。
  final int currentQuestionIndex;
  final AsyncSnapshot<QuerySnapshot<Object?>> snapshot;
  CenteredCommentaryContainer({super.key, required this.currentQuestionIndex, required this.snapshot});

  @override
  // TODO: implement child
  Widget get child => Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: AppColors.mainBlue, width: 4),
                borderRadius: BorderRadius.circular(20),
              ),
              padding: EdgeInsets.fromLTRB(20, 0, 20, 50),
              child: Center(
                  child: Text(
                    "${snapshot.data!.docs[currentQuestionIndex].get("commentary")}",
                    //docs[currentQuestionIndex]でOK!
                    style: TextStyle(fontSize: 22),)),
            ),
          ),
        ],
      ));
}

class TitleAndAnswerResultContainer extends Container{
  //[問題文]と回答後の[正解不正解]を表示するための共通Container。
  final bool isAnswered;
  final bool isCorrect;
  final Size size;
  final int currentQuestionIndex;
  final AsyncSnapshot<QuerySnapshot<Object?>> snapshot;

  TitleAndAnswerResultContainer({super.key, required this.isAnswered,
    required this.size, required this.currentQuestionIndex, required this.isCorrect, required this.snapshot});

  @override
  // TODO: implement child
  Widget get child => Container(
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
      ),
      width: double.infinity,
      height: isAnswered ? size.height * 0.45 : size.height * 0.32,
      child: Center(
        //questionのタイトル
        child: isAnswered
            ? Column(
          children: [
            Container(
              height: 280,
              child: Image.asset(
                //TODO:正解と不正解のImageを作って貼り付ける。一旦はpngで作る
                  isCorrect ?
                  'images/maru2.png':
                  'images/batu2.png'
              ),
            ),
            Container(
              height: 45,//TODO:ここがこれ以上小さくなるとAndroidで見えんくなることがあるので注意
              child: Center(
                  child: Text(
                      isCorrect ? "正解!" : "不正解",
                      style: TextStyle(
                          color:isCorrect ? AppColors.mainRed : AppColors.mainBlue,
                          fontSize: 30
                      ))
              ),
            )
          ],
        )
            : Text(snapshot.data!.docs[currentQuestionIndex].get("title"),
            style: TextStyle(fontSize: 26)),
      )
  );
}

class ContainerInFourGridView extends Container{
  //何問目？とかを表示するための共通Container。
  final BuildContext context;
  final WidgetRef ref;
  final int currentQuestionIndex;
  final AsyncSnapshot<QuerySnapshot<Object?>> snapshot;

  ContainerInFourGridView({super.key, required this.context, required this.ref,
    required this.currentQuestionIndex, required this.snapshot});

  @override
  // TODO: implement child
  Widget get child => GridView.count(
      physics: const NeverScrollableScrollPhysics(),
      //上記でスクロール固定
      crossAxisCount: 2,
      mainAxisSpacing: 24,
      crossAxisSpacing: 24,
      children: List.generate(4, (index) => GestureDetector(
        onTap: () async{
          QuestionPageViewModel.onTapFunctionInFourGridView(context, ref, currentQuestionIndex, index, snapshot);
        },
        child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            color: AppColors.mainWhite,
            elevation: 5,
            child: Center(
                child: Text('${snapshot.data!.docs[currentQuestionIndex].get("answer${index + 1}")}', style: AppTextStyles.textBold)
            )
        ),
      ))
  );
}

class ListViewBuilderContainer extends Container{
  //何問目？とかを表示するための共通Container。
  final BuildContext context;
  final AsyncSnapshot<QuerySnapshot<Object?>> snapshot;
  final String destinationPageName;//navigatingのメソッドを渡してもらう

  ListViewBuilderContainer({super.key, required this.context, required this.snapshot,required this.destinationPageName});

  @override
  // TODO: implement child
  Widget get child => ListView.builder(
      padding: const EdgeInsets.all(2),
      itemCount: snapshot.data!.docs.length,
      itemBuilder: (BuildContext context, int index) {
        //category_titleを変数に格納
        final String title = snapshot.data!.docs[index].get("category_title");
        return Container(
          padding: EdgeInsets.all(4),
          child: GestureDetector(
            onTap: () async{
              final String _categoryId = snapshot.data!.docs[index].id;
              final String _categoryTitle = snapshot.data!.docs[index].get("category_title");
              if(destinationPageName == "QuestionPage")
              Navigator.push(context, MaterialPageRoute(builder: (context) => QuestionPage(
                  categoryId: _categoryId
              )));
              if(destinationPageName == "VocabularyPage")
                Navigator.push(context, MaterialPageRoute(builder: (context) => VocabularyPage(
                  categoryTitle: _categoryTitle,
                    categoryId: _categoryId
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
}

class LinerContainer extends Container{
  //ただの横棒線Container
  @override
  // TODO: implement child
  Widget get child => Container(
    margin: const EdgeInsets.only(top: 10, bottom: 10),
    decoration: const BoxDecoration(border: Border(
      bottom: BorderSide(
        color: AppColors.mainBlue,
        width: 1.5,),),),
    height: 10,
  );
}