import 'package:flutter/material.dart';
import 'package:tasky/core/utils/app_assets.dart';

class EmptyWidet extends StatelessWidget {
  const EmptyWidet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Image.asset(AppAssets.home1),
          SizedBox(height: 10),
          Text(
            "What do you want to do today?",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
          ),
          SizedBox(height: 10),
          Text(
            "Tap + to add your tasks",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
          ),
        ],
      ),
    );

  }
}
