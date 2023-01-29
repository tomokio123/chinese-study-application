import 'package:chinese_study_applicaion/utilities/provider/providers.dart';
import 'package:chinese_study_applicaion/view/main_screen/words_list_page/question_page/question_result_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../utilities/app_colors.dart';
import '../../../../utilities/app_text_styles.dart';

class QuestionPage extends ConsumerWidget {
  const QuestionPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final Size size = MediaQuery.of(context).size;
    int questionCounter = ref.watch(counterProvider);

    return Scaffold(
      // appBar: AppBar(
      //     iconTheme: IconThemeData(color: AppColors.mainBlue),
      //     title: Text('${ref.read(counterProvider) + 1}問目'),
      //     backgroundColor: AppColors.mainWhite,
      //     automaticallyImplyLeading: true),
        //以上の記述一行だけでNavigationのBack矢印が消せる。),
      body: Center(
        child: SafeArea(
          child: Column(
            children: [
              Container(
                width: double.infinity,
                //color: AppColors.mainPink,
                padding: EdgeInsets.symmetric(horizontal: 30,vertical: 10),
                  child: Center(
                      child: Text('${questionCounter + 1}問目',
                        style: TextStyle(fontSize: 30),)
                  )),
              Container(
                  width: double.infinity, height: size.height * 0.3,
                  //color: AppColors.mainBlue,
                  child: Center(child: Text('Container'))
              ),
              Expanded(
                child: Container(
                  padding: EdgeInsets.fromLTRB(12,12,12,0),
                  child: GridView.count(
                      physics: const NeverScrollableScrollPhysics(),
                      //上記でスクロール固定
                      crossAxisCount: 2,
                      mainAxisSpacing: 24,
                      crossAxisSpacing: 24,
                      children: List.generate(4, (index) => GestureDetector(
                        onTap: (){
                          if(ref.read(counterProvider) < 9){
                            ref.read(counterProvider.notifier).state++;
                          }
                          if(questionCounter == 9){
                            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> QuestionResultPage(
                              numberOfQuestions: questionCounter + 1,
                              numberOfCorrectAnswers: 3,
                            )
                            ));
                            ref.refresh(counterProvider.notifier).state;
                          }
                          print('${questionCounter + 1}');
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
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
