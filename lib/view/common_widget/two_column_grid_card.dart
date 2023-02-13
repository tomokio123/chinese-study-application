import 'package:flutter/material.dart';

import '../../utilities/app_colors.dart';
import '../../utilities/app_text_styles.dart';
import '../first_screen/first_screen.dart';
import '../main_screen/words_list_page/question_page/question_page.dart';

class TwoColumnGridCard extends StatelessWidget {
  const TwoColumnGridCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
          padding: EdgeInsets.fromLTRB(12,12,12,0),
          child: GridView.count(
              crossAxisCount: 2,
              mainAxisSpacing: 12,
              crossAxisSpacing: 12,
              children: List.generate(10, (index) => GestureDetector(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> QuestionPage(categoryId: "fruits",)));
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
        );
  }
}
