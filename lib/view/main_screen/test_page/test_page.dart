import 'package:flutter/material.dart';

import '../../../utilities/app_colors.dart';

class TestPage extends StatelessWidget {
  const TestPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              automaticallyImplyLeading: false,
              pinned: false,
              snap: false,
              floating: true,
              expandedHeight: 10.0,
              flexibleSpace: Container(
                color: Colors.cyan,
                height: 300,
                child: const FlexibleSpaceBar(
                  title: Text('SliverAppBar',style: TextStyle(color: AppColors.mainBlue)),
                ),
              ),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                    (BuildContext context, int index) {
                  return Container(
                    color: index.isOdd ? Colors.white : Colors.black12,
                    height: 100.0,
                    child: Center(
                      child: Text('${index + 1}', textScaleFactor: 2),
                    ),
                  );
                },
                childCount: 20,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
