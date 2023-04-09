import 'package:chinese_study_applicaion/model/answer.dart';
import 'package:chinese_study_applicaion/model/category.dart';
import 'package:chinese_study_applicaion/model/question.dart';
import 'package:chinese_study_applicaion/utilities/provider/providers.dart';
import 'package:chinese_study_applicaion/view/common_widget/buttons/normal_button.dart';
import 'package:chinese_study_applicaion/view/main_screen/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../utilities/app_colors.dart';
import '../../../../utilities/app_snack_bars.dart';
import '../../../../utilities/firestore/answer_firestore.dart';
import '../../../../utilities/firestore/category_firestore.dart';
import '../../../../utilities/firestore/question_firestore.dart';

class PostQuestionPage extends ConsumerWidget {
  PostQuestionPage({Key? key}) : super(key: key);

  final titleController = TextEditingController();
  final documentIdController = TextEditingController();
  final answerIdController = TextEditingController();
  final answer1Controller = TextEditingController();
  final answer2Controller = TextEditingController();
  final answer3Controller = TextEditingController();
  final answer4Controller = TextEditingController();
  final correctAnswerIdController = TextEditingController();
  final commentaryController = TextEditingController();
  final categoryTitleController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final Size size = MediaQuery.of(context).size;

    String isSelectedValue = ref.watch(dramProvider);
    final categoryIdController = TextEditingController(text: isSelectedValue);

    return GestureDetector(
      onTap: () => primaryFocus?.unfocus(),
      child: Scaffold(
          appBar: AppBar(
              iconTheme: const IconThemeData(color: AppColors.mainBlue),
              title: const Text('PostQuestionPage',style: TextStyle(color: AppColors.mainBlue)),
              backgroundColor: AppColors.mainWhite),
          body: SingleChildScrollView(
            child: SafeArea(
                child: Center(
                  child: Column(
                    children: [
                      const SizedBox(height: 30),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          DropdownButton(
                            items: const[//TODO：ここの構成も見直す必要がありそう
                              DropdownMenuItem(
                                value: 'fruits',
                                child: Text('フルーツ'),
                              ),
                              DropdownMenuItem(
                                value: 'home_appliances',
                                child: Text('家具・家電'),
                              ),
                              DropdownMenuItem(
                                value: 'vegetables',
                                child: Text('野菜'),
                              ),
                              DropdownMenuItem(
                                value: 'people',
                                child: Text('人称'),
                              ),
                              DropdownMenuItem(
                                value: 'vehicles',
                                child: Text('乗り物'),
                              ),
                              DropdownMenuItem(
                                value: 'sports',
                                child: Text('スポーツ'),
                              ),
                              DropdownMenuItem(
                                value: 'countries',
                                child: Text('国'),
                              ),
                              DropdownMenuItem(
                                value: 'formosan',
                                child: Text('台語'),
                              ),
                              DropdownMenuItem(
                                value: 'verb',
                                child: Text('動詞'),
                              ),
                              DropdownMenuItem(
                                value: 'fruits2',
                                child: Text('フルーツ2'),
                              ),
                              DropdownMenuItem(
                                value: 'school',
                                child: Text('学校'),
                              ),
                              DropdownMenuItem(
                                value: 'premium',
                                child: Text('特別問題'),
                              ),
                              DropdownMenuItem(
                                value: 'taiwanFood',
                                child: Text('台灣美食'),
                              ),
                            ],
                            value: isSelectedValue,
                            onChanged: (String? value) {
                              try{
                                ref.read(dramProvider.notifier).state = value!;
                              } on TypeError catch(e) {//NullThrownErrorからTypeErrorに変更しろと言われていたので変更
                                print(e.toString());
                              }
                            },
                          )
                        ],
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        width: size.width * 0.85,
                        child: TextFormField(
                          autofillHints: const [AutofillHints.telephoneNumber],
                          cursorColor: AppColors.mainBlue,
                          decoration: const InputDecoration(
                            labelStyle: TextStyle(color: AppColors.mainBlue),
                            labelText: 'category_id',
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                width: 2,
                                color: AppColors.mainBlue,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: AppColors.mainBlue, width: 2)
                            ),
                            //enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: AppColors.mainBlue)),
                            hintText: 'category_id',
                          ),
                          controller: categoryIdController,
                          keyboardType: TextInputType.visiblePassword,
                          textInputAction: TextInputAction.done,
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        width: size.width * 0.85,
                        child: TextFormField(
                          autofillHints: const [AutofillHints.telephoneNumber],
                          cursorColor: AppColors.mainBlue,
                          decoration: const InputDecoration(
                            labelStyle: TextStyle(color: AppColors.mainBlue),
                            labelText: 'category_title',
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                width: 2,
                                color: AppColors.mainBlue,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: AppColors.mainBlue, width: 2)
                            ),
                            //enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: AppColors.mainBlue)),
                            hintText: 'category_Title',
                            helperText: '※カテゴリの日本語記入',
                          ),
                          controller: categoryTitleController,
                          autofocus: true,
                          keyboardType: TextInputType.text,
                          textInputAction: TextInputAction.next,
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        width: size.width * 0.85,
                        child: TextFormField(
                          cursorColor: AppColors.mainBlue,
                          maxLines: 6,
                          minLines: 1,
                          decoration: const InputDecoration(
                            labelStyle: TextStyle(color: AppColors.mainBlue),
                            labelText: 'documentId',
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                width: 2,
                                color: AppColors.mainBlue,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: AppColors.mainBlue, width: 2)
                            ),
                            //enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: AppColors.mainBlue)),
                            hintText: 'documentId',
                            helperText: '※FireStoreドキュメントID(問題IDと呼んでもOK)',
                          ),
                          controller:documentIdController,
                          keyboardType: TextInputType.phone,
                          textInputAction: TextInputAction.next,
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        width: size.width * 0.85,
                        child: TextFormField(
                          cursorColor: AppColors.mainBlue,
                          decoration: const InputDecoration(
                            labelStyle: TextStyle(color: AppColors.mainBlue),
                            labelText: 'answer_id',
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                width: 2,
                                color: AppColors.mainBlue,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: AppColors.mainBlue, width: 2)
                            ),
                            //enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: AppColors.mainBlue)),
                            hintText: 'answer_id',
                            helperText: '※answer_idだがdocumentIdと同じ値を原則入れる',
                          ),
                          controller: documentIdController,//ほんとはanswerIdController
                          keyboardType: TextInputType.phone,
                          textInputAction: TextInputAction.next,
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        width: size.width * 0.85,
                        child: TextFormField(
                          cursorColor: AppColors.mainBlue,
                          maxLines: 6,
                          minLines: 1,
                          decoration: const InputDecoration(
                            labelStyle: TextStyle(color: AppColors.mainBlue),
                            labelText: 'title',
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  width: 2,
                                  color: AppColors.mainBlue,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: AppColors.mainBlue, width: 2)
                              ),
                              //enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: AppColors.mainBlue)),
                              hintText: 'title',
                              helperText: '※問題文',
                          ),
                          controller: titleController,
                          keyboardType: TextInputType.visiblePassword,
                          textInputAction: TextInputAction.next,
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        width: size.width * 0.85,
                        child: TextFormField(
                          cursorColor: AppColors.mainBlue,
                          maxLines: 6,
                          minLines: 1,
                          decoration: const InputDecoration(
                            labelStyle: TextStyle(color: AppColors.mainBlue),
                            labelText: 'answer1',
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                width: 2,
                                color: AppColors.mainBlue,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: AppColors.mainBlue, width: 2)
                            ),
                            //enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: AppColors.mainBlue)),
                            hintText: 'answer1',
                            helperText: '※answer1',
                          ),
                          controller: answer1Controller,
                          keyboardType: TextInputType.visiblePassword,
                          textInputAction: TextInputAction.next,
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        width: size.width * 0.85,
                        child: TextFormField(
                          cursorColor: AppColors.mainBlue,
                          maxLines: 6,
                          minLines: 1,
                          decoration: const InputDecoration(
                            labelStyle: TextStyle(color: AppColors.mainBlue),
                            labelText: 'answer2',
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                width: 2,
                                color: AppColors.mainBlue,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: AppColors.mainBlue, width: 2)
                            ),
                            //enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: AppColors.mainBlue)),
                            hintText: 'answer2',
                            helperText: '※answer2',
                          ),
                          controller: answer2Controller,
                          keyboardType: TextInputType.visiblePassword,
                          textInputAction: TextInputAction.next,
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        width: size.width * 0.85,
                        child: TextFormField(
                          cursorColor: AppColors.mainBlue,
                          maxLines: 6,
                          minLines: 1,
                          decoration: const InputDecoration(
                            labelStyle: TextStyle(color: AppColors.mainBlue),
                            labelText: 'answer3',
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                width: 2,
                                color: AppColors.mainBlue,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: AppColors.mainBlue, width: 2)
                            ),
                            //enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: AppColors.mainBlue)),
                            hintText: 'answer3',
                            helperText: '※answer3',
                          ),
                          controller: answer3Controller,
                          keyboardType: TextInputType.visiblePassword,
                          textInputAction: TextInputAction.next,
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        width: size.width * 0.85,
                        child: TextFormField(
                          cursorColor: AppColors.mainBlue,
                          maxLines: 6,
                          minLines: 1,
                          decoration: const InputDecoration(
                            labelStyle: TextStyle(color: AppColors.mainBlue),
                            labelText: 'answer4',
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                width: 2,
                                color: AppColors.mainBlue,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: AppColors.mainBlue, width: 2)
                            ),
                            //enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: AppColors.mainBlue)),
                            hintText: 'answer4',
                            helperText: '※answer4',
                          ),
                          controller: answer4Controller,
                          keyboardType: TextInputType.visiblePassword,
                          textInputAction: TextInputAction.next,
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        width: size.width * 0.85,
                        child: TextFormField(
                          cursorColor: AppColors.mainBlue,
                          maxLines: 6,
                          minLines: 1,
                          decoration: const InputDecoration(
                            labelStyle: TextStyle(color: AppColors.mainBlue),
                            labelText: 'correct_answer_id',
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                width: 2,
                                color: AppColors.mainBlue,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: AppColors.mainBlue, width: 2)
                            ),
                            //enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: AppColors.mainBlue)),
                            hintText: 'correct_answer_id',
                            helperText: '※「indexナンバーで」正答番号を与える。',
                          ),
                          controller: correctAnswerIdController,
                          keyboardType: TextInputType.visiblePassword,
                          textInputAction: TextInputAction.next,
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        width: size.width * 0.85,
                        child: TextFormField(
                          cursorColor: AppColors.mainBlue,
                          maxLines: 6,
                          minLines: 1,
                          decoration: const InputDecoration(
                            labelStyle: TextStyle(color: AppColors.mainBlue),
                            labelText: 'commentary',
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                width: 2,
                                color: AppColors.mainBlue,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: AppColors.mainBlue, width: 2)
                            ),
                            //enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: AppColors.mainBlue)),
                            hintText: 'commentary',
                            helperText: '※問題の解説記入欄',
                          ),
                          controller: commentaryController,
                          keyboardType: TextInputType.visiblePassword,
                          textInputAction: TextInputAction.done,
                        ),
                      ),
                      NormalButton(
                          buttonText: '問題を投稿',
                          onPressed: () async{
                            // TODO:answerIdControllerをdocumentIdControllerに吸収させている(原則,documentId=answerIdだから)
                            if(titleController.text.isNotEmpty &&
                                documentIdController.text.isNotEmpty &&
                                //answerIdController.text.isNotEmpty && //原則,documentId=answerIdだからコメントアウト
                                categoryIdController.text.isNotEmpty &&
                                answer1Controller.text.isNotEmpty &&
                                answer2Controller.text.isNotEmpty &&
                                answer3Controller.text.isNotEmpty &&
                                answer4Controller.text.isNotEmpty &&
                                correctAnswerIdController.text.isNotEmpty &&
                                commentaryController.text.isNotEmpty
                            ){
                              var postingQuestionResult = await postQuestion(categoryIdController.text);
                              var postingAnswerResult = await postAnswer();
                              var postingCategoryResult = await postCategory(categoryIdController.text);
                              if(postingQuestionResult == true && postingAnswerResult == true && postingCategoryResult == true){
                                ScaffoldMessenger.of(context).showSnackBar(AppSnackBar.postingQuestionAndAnswerIsSuccessful);
                                ScaffoldMessenger.of(context).showSnackBar(AppSnackBar.postingCategoryIsSuccessful);
                                Navigator.push(context, MaterialPageRoute(builder: (context) => MainScreen()));
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(AppSnackBar.postingQuestionIsFailed);
                              }
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(AppSnackBar.blankIsNotFilled);
                              print('全部の空欄を埋めてください');
                            }
                      }),
                      const SizedBox(height: 30)
                    ],
                  ),
                )),
          )),
    );

  }

  Future<dynamic> postQuestion(String categoryIdControllerText) async{//FireStoreに送るデータ
    //!でnull回避 await をつけておく一応
    Question newQuestion = Question(
      questionId: documentIdController.text,
      categoryId: categoryIdControllerText,
      title: titleController.text,
      answerId: documentIdController.text
    );
    var result = await QuestionFireStore.setQuestion(newQuestion, documentIdController.text);
    return result;
  }

  Future<dynamic> postCategory(String categoryIdControllerText) async{//FireStoreに送るデータ
    //!でnull回避 await をつけておく一応
    Category newCategory = Category(
        categoryId: categoryIdControllerText,
        categoryTitle: categoryTitleController.text
    );
    var result = await CategoryFireStore.setCategory(newCategory);
    return result;
  }

  Future<dynamic> postAnswer() async{//FireStoreに送るデータ
    Answer newAnswer = Answer(
      answerId: documentIdController.text,
      answer1: answer1Controller.text,
      answer2: answer2Controller.text,
      answer3: answer3Controller.text,
      answer4: answer4Controller.text,
      correctAnswerIndexNumber: correctAnswerIdController.text,
      commentary: commentaryController.text
    );
    var result = await AnswerFireStore.setAnswer(newAnswer, documentIdController.text);
    return result;
  }
}
