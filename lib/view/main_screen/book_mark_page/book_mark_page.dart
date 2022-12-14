import 'package:chinese_study_applicaion/utilities/app_text_styles.dart';
import 'package:flutter/material.dart';

import '../../../utilities/app_colors.dart';
import '../../../utilities/app_sized_boxes.dart';
import '../../first_screen/first_screen.dart';

class BookMarkPage extends StatelessWidget {
  const BookMarkPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('ブックマーク')),
      body: Container(
        padding: EdgeInsets.fromLTRB(12,12,12,0),
        child: GridView.count(
            crossAxisCount: 2,
            mainAxisSpacing: 12,
            crossAxisSpacing: 12,
            children: List.generate(10, (index) => GestureDetector(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=> FirstScreen()));
              },
              child: Card(
                  color: AppColors.mainWhite,
                  elevation: 5,
                  child: Center(child: Text('${index + 1}', style: AppTextStyles.textBold))
              ),
            ))
        ),
      )
    );
  }
}
