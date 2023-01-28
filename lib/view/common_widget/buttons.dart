import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../utilities/app_colors.dart';
import '../../utilities/provider/providers.dart';

class Buttons {
  static Widget normalOutlineButton(BuildContext context, WidgetRef ref){
    bool buttonState = ref.watch(buttonProvider);

    return OutlinedButton(
        style: OutlinedButton.styleFrom(
          padding: EdgeInsets.symmetric(vertical: 10,horizontal: 20),
          primary: AppColors.mainBlue,
          backgroundColor: AppColors.mainWhite,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          side: const BorderSide(color: AppColors.mainBlue),
          elevation: 3
        ),
        onPressed: (){
          if(ref.watch(buttonProvider) == false){
            ref.read(buttonProvider.notifier).state = true;
          } else {
            ref.read(buttonProvider.notifier).state = false;
          }
        },
        child: buttonState
            ? Text('元に戻す',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold))
            : Text('答えを見る',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold))
    );
  }

  static Widget normalButton(BuildContext context ,Future<void> function) {
    return ElevatedButton(
      child: const Text('次のp'),
      style: ElevatedButton.styleFrom(
        primary: Colors.red,
        onPrimary: Colors.black,
        shape: const StadiumBorder(),
      ),
      onPressed: () => function,
    );
  }
}