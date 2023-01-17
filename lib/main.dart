import 'package:chinese_study_applicaion/utilities/app_colors.dart';
import 'package:chinese_study_applicaion/utilities/app_text_styles.dart';
import 'package:chinese_study_applicaion/view/login_screen/login_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'firebase_options.dart';

void main() async{
  //これがないとエラー、要調査
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
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
      home: LoginScreen(),//ここに最初の画面
    );
  }
}
