import 'package:chinese_study_applicaion/utilities/app_colors.dart';
import 'package:chinese_study_applicaion/utilities/app_font_sizes.dart';
import 'package:chinese_study_applicaion/utilities/app_text_styles.dart';
import 'package:chinese_study_applicaion/view/first_screen/first_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();//これがないとエラー、要調査
  runApp(ProviderScope(child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      darkTheme: ThemeData.dark(),
      theme: ThemeData(
        primaryColor: AppColors.mainBlue,
        backgroundColor: AppColors.subBlue,
        fontFamily: "KleeOne",//Textの字体や大きさ
        appBarTheme: const AppBarTheme(
            titleTextStyle: AppTextStyles.appBarTitle,
            backgroundColor: AppColors.mainWhite),
      ),
      title: 'Chinese-study-application',
      home: FirstScreen(),//ここに最初の画面
    );
  }
}
