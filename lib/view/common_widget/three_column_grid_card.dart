import 'package:flutter/material.dart';

import '../../utilities/app_colors.dart';
import '../../utilities/app_text_styles.dart';
import '../first_screen/first_screen.dart';

class ThreeColumnGridCard extends StatelessWidget {
  const ThreeColumnGridCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(12,12,12,0),
      child: GridView.count(
          crossAxisCount: 3,
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
    );
  }
}
