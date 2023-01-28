import 'package:chinese_study_applicaion/utilities/provider/providers.dart';
import 'package:chinese_study_applicaion/view/common_widget/buttons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../utilities/app_colors.dart';

class VocabularyBookPage extends ConsumerWidget {
  const VocabularyBookPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final Size size = MediaQuery.of(context).size;
    final buttonState = ref.watch(buttonProvider);

    List<String> questionTitleList = [
      'りんご1','りんご2','りんご3','りんご4','りんご5',
      'りんご6','りんご7','りんご8','りんご9''りんご10'
    ];

    return Scaffold(
      appBar: AppBar(
          iconTheme: IconThemeData(color: AppColors.mainBlue),
          backgroundColor: AppColors.mainWhite,
          automaticallyImplyLeading: true),
      //以上の記述一行だけでNavigationのBack矢印が消せる。),
      body: SingleChildScrollView(//これは多分いらん
        child: Center(
          child: SafeArea(
            child: Column(
              children: [
                Container(
                    width: double.infinity, height: size.height * 0.3,
                    child: Center(
                        child: Container(
                          color: AppColors.mainPink,
                          padding: EdgeInsets.symmetric(horizontal: 40),
                          child: Text(questionTitleList[1],
                            style: TextStyle(fontSize: 20),),
                        )
                    )
                ),
                Buttons.normalOutlineButton(context, ref),
                buttonState ? Container(
                    width: double.infinity, height: size.height * 0.3,
                    child: Center(
                        child: Container(
                          color: AppColors.mainPink,
                          padding: EdgeInsets.symmetric(horizontal: 40),
                          child: Text(questionTitleList[1],
                            style: TextStyle(fontSize: 20),),
                        )
                    )
                ) : Container()
              ],
            ),
          ),
        ),
      ),
    );
  }
}
