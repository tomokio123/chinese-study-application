import 'package:chinese_study_applicaion/Utilities/app_colors.dart';
import 'package:chinese_study_applicaion/utilities/app_font_sizes.dart';
import 'package:chinese_study_applicaion/view/first_screen/first_screen.dart';
import 'package:flutter/material.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();//これがないとエラー、要調査
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
            titleTextStyle: TextStyle(color: Colors.black54, fontSize: AppFontSizes.normal),
            backgroundColor: AppColors.mainWhite),
      ),
      title: 'Chinese-study-application',
      home: FirstScreen(),//ここに最初の画面
    );
  }
}
