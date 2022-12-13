import 'package:flutter/material.dart';

import '../../../utilities/app_colors.dart';
import '../../../utilities/app_sized_boxes.dart';
import '../../first_screen/first_screen.dart';

class BookMarkPage extends StatelessWidget {
  const BookMarkPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('HomePage')),
      body: Container(
        margin: EdgeInsets.all(12),
        child: GridView.count(
            crossAxisCount: 2,
            children: List.generate(10, (index) => GestureDetector(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=> FirstScreen()));
              },
              child: Card(
                  color: AppColors.mainWhite,
                  child: Center(child: Text('${index + 1}'))),
            ))
        ),
      )
    );
  }
}
