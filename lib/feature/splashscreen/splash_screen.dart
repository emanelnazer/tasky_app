import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:tasky/feature/onboarding/onboarding.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  static const String routeName = "splashscreen";

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 2), () {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => OnBoardingScreen()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xff5F33E1),
        body: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FadeInLeft(child: Image.asset("assets/icons/task.png")),
              BounceInDown(child: Image.asset("assets/icons/y.png")),
            ],
          ),
        ));
  }
}
