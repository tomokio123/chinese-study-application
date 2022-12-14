import 'package:flutter/material.dart';

import '../../../utilities/app_colors.dart';
import '../../../utilities/app_sized_boxes.dart';
import '../../first_screen/first_screen.dart';

class MyPage extends StatelessWidget {
  const MyPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('マイページ')),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Text('MyPage')
          ],
        ),
      ),
    );
  }
}