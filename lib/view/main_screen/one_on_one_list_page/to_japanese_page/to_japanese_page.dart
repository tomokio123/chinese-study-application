import 'package:chinese_study_applicaion/view/common_widget/three_column_grid_card.dart';
import 'package:flutter/material.dart';

import '../../../../utilities/app_colors.dart';
import '../../../../utilities/app_text_styles.dart';
import '../../../first_screen/first_screen.dart';

class ToJapanesePage extends StatelessWidget {
  const ToJapanesePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ThreeColumnGridCard()
    );
  }
}
