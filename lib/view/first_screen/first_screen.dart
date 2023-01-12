import 'dart:async';

import 'package:chinese_study_applicaion/Utilities/app_colors.dart';
import 'package:chinese_study_applicaion/view/main_screen/home_page/home_page.dart';
import 'package:chinese_study_applicaion/view/main_screen/main_screen.dart';
import 'package:flutter/material.dart';

class FirstScreen extends StatefulWidget {
  const FirstScreen({Key? key}) : super(key: key);

  @override
  State<FirstScreen> createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
  //Declare a timer
  Timer? timer;
  @override
  void initState() {
    super.initState();

    timer = Timer(
      const Duration(seconds: 2),
          () {
        print('遷移完了');
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const MainScreen(),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    timer?.cancel();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.mainWhite,
      body: SafeArea(
        child: Center(
          child: Text('FirstScreen',style: TextStyle(fontSize: 35)),
          /*child: ElevatedButton(
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => const MainScreen()));
              },
              child: const Text('次の画面へ遷移')),*/
        ),
      ),
    );
  }
}
