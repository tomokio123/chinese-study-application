import 'package:flutter/material.dart';

class MyPage extends StatelessWidget {
  const MyPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appBar: AppBar(title: const Text('マイページ')),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text('MyPage')
            ],
          ),
        ),
      ),
    );
  }
}