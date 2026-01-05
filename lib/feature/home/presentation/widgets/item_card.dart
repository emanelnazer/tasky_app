import 'package:flutter/material.dart';
import 'package:tasky/core/utils/app_assets.dart';

class ItemCardWidgets extends StatelessWidget {
  const ItemCardWidgets(
      {super.key,
        required this.title,
        required this.dateTime,
        required this.priority,
        required this.iscompleted,
        this.onpressed});
  final String title;
  final DateTime dateTime;
  final int priority;
  final bool iscompleted;
  final void Function(bool)? onpressed;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Color(0xff6E6A7C))),
      child: Row(
        children: [
          SizedBox(
            width: 4,
          ),
          Radio(
              value: true,
              groupValue: iscompleted,
              onChanged: (value) {
                if (onpressed != null) onpressed!(value ?? false);
              }),
          SizedBox(
            width: 4,
          ),
          Column(
            children: [
              Text(
                title,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
              ),
              SizedBox(height: 5),
              Text(
                _fromatTime(dateTime),
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w200),
              ),
            ],
          ),
          Spacer(),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              border: Border.all(color: const Color(0xff27282F)),
              color: const Color(0xffFFFFFF),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 8),
            margin: const EdgeInsets.all(12),
            child: Column(
              children: [
                Image.asset(
                  AppAssets.flag,
                  width: 24,
                  height: 24,
                  color: Color(0xff000000),
                ),
                const SizedBox(height: 5),
                Text(
                  priority.toString(),
                  style: TextStyle(
                    color: Color(0xff000000),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _fromatTime(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }
}
