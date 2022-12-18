import 'package:flutter/material.dart';

import '../../../../../utilities/app_colors.dart';

class EditAccountPage extends StatelessWidget {
  const EditAccountPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            iconTheme: IconThemeData(color: AppColors.mainBlue),
            title: Text('EditAccountPage',style: TextStyle(color: AppColors.mainBlue)),
            backgroundColor: AppColors.mainWhite),
        body: SafeArea(child: Container(child: Text('EditAccountPage'),)));
  }
}
