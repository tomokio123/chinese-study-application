import 'package:chinese_study_applicaion/model/question.dart';
import 'package:chinese_study_applicaion/view/common_widget/buttons/normal_button.dart';
import 'package:chinese_study_applicaion/view/main_screen/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../utilities/app_colors.dart';
import '../../../../utilities/app_snack_bars.dart';
import '../../../../utilities/firestore/question_firestore.dart';

class PostQuestionPage extends ConsumerWidget {
  PostQuestionPage({Key? key}) : super(key: key);

  final documentIdController = TextEditingController();
  final titleController = TextEditingController();
  final answerIdController = TextEditingController();
  final categoryIdController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () => primaryFocus?.unfocus(),
      child: Scaffold(
          appBar: AppBar(
              iconTheme: IconThemeData(color: AppColors.mainBlue),
              title: Text('PostQuestionPage',style: TextStyle(color: AppColors.mainBlue)),
              backgroundColor: AppColors.mainWhite),
          body: SingleChildScrollView(
            child: SafeArea(
                child: Center(
                  child: Column(
                    children: [
                      SizedBox(height: 50),
                      Container(
                        padding: EdgeInsets.symmetric(vertical: 20),
                        width: size.width * 0.85,
                        child: TextFormField(
                          autofocus: true,
                          cursorColor: AppColors.mainBlue,
                          maxLines: 6,
                          minLines: 1,
                          decoration: const InputDecoration(
                            labelStyle: TextStyle(color: AppColors.mainBlue),
                            labelText: 'documentId',
                            enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
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
                            helperText: '※FireStoreのドキュメントID',
                          ),
                          controller:documentIdController,
                          keyboardType: TextInputType.visiblePassword,
                          textInputAction: TextInputAction.next,
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(vertical: 20),
                        width: size.width * 0.85,
                        child: TextFormField(
                          cursorColor: AppColors.mainBlue,
                          maxLines: 6,
                          minLines: 1,
                          decoration: const InputDecoration(
                            labelStyle: TextStyle(color: AppColors.mainBlue),
                            labelText: 'title',
                              enabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
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
                        padding: EdgeInsets.symmetric(vertical: 20),
                        width: size.width * 0.85,
                        child: TextFormField(
                          autofillHints: const [AutofillHints.telephoneNumber],
                          cursorColor: AppColors.mainBlue,
                          decoration: const InputDecoration(
                            labelStyle: TextStyle(color: AppColors.mainBlue),
                            labelText: 'answer_id',
                            enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
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
                            helperText: '※answer_id',
                          ),
                          controller: answerIdController,
                          keyboardType: TextInputType.visiblePassword,
                          textInputAction: TextInputAction.next,
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(vertical: 20),
                        width: size.width * 0.85,
                        child: TextFormField(
                          autofillHints: const [AutofillHints.telephoneNumber],
                          cursorColor: AppColors.mainBlue,
                          decoration: const InputDecoration(
                            labelStyle: TextStyle(color: AppColors.mainBlue),
                            labelText: 'category_id',
                            enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
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
                            helperStyle: TextStyle(color: AppColors.mainBlue),
                            helperText: '※category_id',
                          ),
                          controller: categoryIdController,
                          keyboardType: TextInputType.visiblePassword,
                          textInputAction: TextInputAction.done,
                        ),
                      ),
                      NormalButton(
                          buttonText: '問題を投稿',
                          onPressed: () async{
                            if(titleController.text.isNotEmpty &&
                                documentIdController.text.isNotEmpty &&
                                answerIdController.text.isNotEmpty &&
                                categoryIdController.text.isNotEmpty
                            ){
                              var _result = await postQuestion();
                              if(_result == true){
                                ScaffoldMessenger.of(context).showSnackBar(AppSnackBar.postingQuestionIsSuccessful);
                                Navigator.push(context, MaterialPageRoute(builder: (context) => MainScreen()));
                              } else {
                                print('_result == true');
                                ScaffoldMessenger.of(context).showSnackBar(AppSnackBar.postingQuestionIsFailed);
                              }
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(AppSnackBar.blankIsNotFilled);
                              print(titleController.text);
                              print('全部の空欄を埋めてください');
                            }
                      })
                    ],
                  ),
                )),
          )),
    );
  }

  Future<dynamic> postQuestion() async{//FireStoreに送るデータ
    //!でnull回避 await をつけておく一応
    Question newQuestion = Question(
      title: titleController.text,
      answerId: answerIdController.text,
      categoryId: categoryIdController.text
    );
    var _result = await QuestionFireStore.setQuestion(newQuestion, documentIdController.text);
    return _result;
  }
}
