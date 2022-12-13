import 'package:flutter/material.dart';

import '../../../utilities/app_colors.dart';
import '../../../utilities/app_sized_boxes.dart';
import '../../first_screen/first_screen.dart';

class MyPage extends StatelessWidget {
  const MyPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('MyPage')),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(height: 20),
            Center(
              child: Container(
                color: Colors.green,
                height: 50,
                child: Text('height40'),
              ),
            ),
            Container(
              width: double.infinity,//横いっぱいに広げる
              color: Colors.blue,
              child: Column(
                children: [
                  Container(
                    color: Colors.grey,
                    height: 40,
                    child: Text('height40'),
                  ),
                  Text('MyPage'),
                  Text('MyPage')
                ],
              ),
            ),
            GestureDetector(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => FirstScreen()));
              },
              child: Container(
                margin: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: AppColors.mainWhite,
                  border: Border.all(color: Colors.black, width: 2),
                  borderRadius: BorderRadius.circular(9),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black12,
                        blurRadius: 10.0,
                        spreadRadius: 1.0,
                        offset: Offset(10, 10))
                  ],
                ),
                width: double.infinity,
                height: 70,
                child: Center(child: Text('QuestionContainer',
                  style: TextStyle(fontSize: 20),)),
              ),
            ),
            AppSizedBoxes.bigSizedBox,
            GestureDetector(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => FirstScreen()));
              },
              child: Container(
                margin: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: AppColors.mainWhite,
                  border: Border.all(color: Colors.black, width: 2),
                  borderRadius: BorderRadius.circular(9),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black12,
                        blurRadius: 10.0,
                        spreadRadius: 1.0,
                        offset: Offset(10, 10))
                  ],
                ),
                width: double.infinity,
                height: 70,
                child: Center(child: Text('QuestionContainer',
                  style: TextStyle(fontSize: 20),)),
              ),
            ),
            AppSizedBoxes.bigSizedBox,
            GestureDetector(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => FirstScreen()));
              },
              child: Container(
                margin: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: AppColors.mainWhite,
                  border: Border.all(color: Colors.black, width: 2),
                  borderRadius: BorderRadius.circular(9),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black12,
                        blurRadius: 10.0,
                        spreadRadius: 1.0,
                        offset: Offset(10, 10))
                  ],
                ),
                width: double.infinity,
                height: 70,
                child: Center(child: Text('QuestionContainer',
                  style: TextStyle(fontSize: 20),)),
              ),
            ),
            AppSizedBoxes.bigSizedBox,
            GestureDetector(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => FirstScreen()));
              },
              child: Container(
                margin: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: AppColors.mainWhite,
                  border: Border.all(color: Colors.black, width: 2),
                  borderRadius: BorderRadius.circular(9),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black12,
                        blurRadius: 10.0,
                        spreadRadius: 1.0,
                        offset: Offset(10, 10))
                  ],
                ),
                width: double.infinity,
                height: 70,
                child: Center(child: Text('QuestionContainer',
                  style: TextStyle(fontSize: 20),)),
              ),
            ),
            AppSizedBoxes.bigSizedBox,
            GestureDetector(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => FirstScreen()));
              },
              child: Container(
                margin: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: AppColors.mainWhite,
                  border: Border.all(color: Colors.black, width: 2),
                  borderRadius: BorderRadius.circular(9),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black12,
                        blurRadius: 10.0,
                        spreadRadius: 1.0,
                        offset: Offset(10, 10))
                  ],
                ),
                width: double.infinity,
                height: 70,
                child: Center(child: Text('QuestionContainer',
                  style: TextStyle(fontSize: 20),)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}