import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

 class LoadingWidet extends StatelessWidget {
   const LoadingWidet({Key? key}) : super(key: key);

   @override
   Widget build(BuildContext context) {
     return Expanded(
       child: Column(
         mainAxisAlignment: MainAxisAlignment.center,
         children: [
           CircularProgressIndicator(),
         ],
       ),
     );
   }
 }