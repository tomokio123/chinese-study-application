import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../utilities/app_colors.dart';

class NormalButton extends StatelessWidget{
  final String buttonText;
  final VoidCallback onPressed;//ここがVoidCallBackじゃ無かったら以下のonPressedが回らん、なぜ

  const NormalButton({super.key, required this.buttonText, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: AppColors.mainBlue,
          onPrimary: AppColors.mainWhite,
          shape: const StadiumBorder(),
        ),
        onPressed: onPressed,
        child: Container(
            padding: EdgeInsets.symmetric(vertical: 12,horizontal: 30),
            child: Text(buttonText,style: const TextStyle(fontSize: 20),)
        ),
      ),
    );
  }
}