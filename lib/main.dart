import 'package:chinese_study_applicaion/utilities/app_colors.dart';
import 'package:chinese_study_applicaion/utilities/app_text_styles.dart';
import 'package:chinese_study_applicaion/view/first_screen/first_screen.dart';
import 'package:chinese_study_applicaion/view/login_screen/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
      key: GlobalKey(),
      //darkTheme: ThemeData.dark(),//TODO:darkモードについて要調査
      theme: ThemeData(
        scaffoldBackgroundColor: AppColors.mainWhite, /*Scaffoldの背景色*/
        primaryColor: AppColors.mainBlue,
        fontFamily: "KleeOne",//Textの字体や大きさ
        appBarTheme: const AppBarTheme(
            titleTextStyle: AppTextStyles.appBarTitle,
            backgroundColor: AppColors.mainWhite),
      ),
      title: 'Chinese-study-application',
      home: StreamBuilder<User?>(//ここに最初の画面
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            // スプラッシュ画面などに書き換えても良い
            return const SizedBox();
          }
          else if (snapshot.hasData) {
            // User が null でなない、つまりサインイン済みのホーム画面へ
            return const FirstScreen();
          } else {
            // User が null である、つまり未サインインのサインイン画面へ
            return LoginScreen();
          }
        },
      ),
    );
  }
}
