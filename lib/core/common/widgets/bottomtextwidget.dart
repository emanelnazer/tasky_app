import 'package:flutter/material.dart';

class Bottomtextwidget extends StatelessWidget {
  const Bottomtextwidget(
      {super.key, required this.title, required this.subtitle, this.ontap});
  final String title;
  final String subtitle;
  final void Function()? ontap;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ontap,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(title),
          Text(subtitle),
        ],
      ),
    );
  }
}
