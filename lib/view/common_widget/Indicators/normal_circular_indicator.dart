import 'package:flutter/material.dart';
import '../../../utilities/app_colors.dart';

class NormalCircularIndicator extends StatelessWidget {
  const NormalCircularIndicator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(
        //基本の青色円型インジケーター。くるくる。
        color: AppColors.mainBlue,
      ),
    );
  }
}
