import 'package:flutter/material.dart';

abstract class AppDialog {
  static void showloading(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => const AlertDialog(
        content: Row(
          children: [
            CircularProgressIndicator(),
            Text(
              "Loading",
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w400,
                  color: Color(0xff000000)),
            )
          ],
        ),
      ),
    );
  }

  static void showerror(BuildContext context, {required String error}) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("error"),
        content: Text(error),
        actions: [
          MaterialButton(
            onPressed: () {},
            child: Text("ok"),
          )
        ],
      ),
    );
  }
}
