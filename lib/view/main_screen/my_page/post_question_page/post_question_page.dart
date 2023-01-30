import 'package:chinese_study_applicaion/model/question.dart';
import 'package:chinese_study_applicaion/utilities/provider/providers.dart';
import 'package:chinese_study_applicaion/view/common_widget/buttons/normal_button.dart';
import 'package:chinese_study_applicaion/view/main_screen/main_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../utilities/app_colors.dart';
import '../../../../utilities/app_snack_bars.dart';
import '../../../../utilities/firestore/question_firestore.dart';

class PostQuestionPage extends ConsumerWidget {
  PostQuestionPage({Key? key}) : super(key: key);

  final titleController = TextEditingController();
  final answerIdController = TextEditingController();
  final documentIdController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final Size size = MediaQuery.of(context).size;

    String isSelectedValue = ref.watch(dramProvider);
    final categoryIdController = TextEditingController(text: isSelectedValue);

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
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          DropdownButton(
                            items: const[
                              DropdownMenuItem(
                                value: 'fruits',
                                child: Text('フルーツ'),
                              ),
                              DropdownMenuItem(
                                value: 'home_appliances',
                                child: Text('家電'),
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

                            ],
                            value: isSelectedValue,
                            onChanged: (String? value) {
                              try{
                                ref.read(dramProvider.notifier).state = value!;
                              } on NullThrownError catch(e) {
                                print(e.toString());
                              }
                            },
                          )
                        ],
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
                          ),
                          controller: categoryIdController,
                          keyboardType: TextInputType.visiblePassword,
                          textInputAction: TextInputAction.done,
                        ),
                      ),
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
                          keyboardType: TextInputType.phone,
                          textInputAction: TextInputAction.next,
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(vertical: 20),
                        width: size.width * 0.85,
                        child: TextFormField(
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
                          keyboardType: TextInputType.phone,
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
                      NormalButton(
                          buttonText: '問題を投稿',
                          onPressed: () async{
                            if(titleController.text.isNotEmpty &&
                                documentIdController.text.isNotEmpty &&
                                answerIdController.text.isNotEmpty &&
                                categoryIdController.text.isNotEmpty
                            ){
                              var result = await postQuestion(categoryIdController.text);
                              if(result == true){
                                ScaffoldMessenger.of(context).showSnackBar(AppSnackBar.postingQuestionIsSuccessful);
                                Navigator.push(context, MaterialPageRoute(builder: (context) => MainScreen()));
                              } else {
                                print('${result}');
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

  Future<dynamic> postQuestion(String categoryIdControllerText) async{//FireStoreに送るデータ
    //!でnull回避 await をつけておく一応
    Question newQuestion = Question(
      title: titleController.text,
      answerId: answerIdController.text,
      categoryId: categoryIdControllerText
    );
    var result = await QuestionFireStore.setQuestion(newQuestion, documentIdController.text);
    return result;
  }
}
