import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});
  static const String routeName = "onboardingscreen";

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  List<OnBoarding> onboardinglist = dataBoarding();
  int index = 0;
  PageController controller = PageController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          SizedBox(
            height: 200,
            child: PageView.builder(
              controller: controller,
              onPageChanged: (value) {
                setState(() {
                  index = value;
                });
              },
              itemBuilder: (context, index) {
                return CustomAntimatedwidget(
                    index: index,
                    delay: index,
                    child: Image.asset(onboardinglist[index].image));
              },
              itemCount: onboardinglist.length,
            ),
          ),
          SizedBox(
            height: 35,
          ),
          SmoothPageIndicator(
            controller: controller,
            count: onboardinglist.length,
            effect: ExpandingDotsEffect(
                spacing: 10,
                radius: 10,
                dotWidth: 15,
                dotHeight: 5,
                activeDotColor: Color(0xff5F33E1)),
          ),
          SizedBox(
            height: 30,
          ),
          CustomAntimatedwidget(
            delay: (index + 1) * 100,
            index: index,
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 40),
              width: double.infinity,
              child: Column(
                children: [
                  Text(
                    onboardinglist[index].title,
                    style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Color(0xff24262C)),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    onboardinglist[index].description,
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: Color(0xff6E6A7C)),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: MaterialButton(
                      onPressed: () {
                        if (index < onboardinglist.length - 1) {
                          controller.nextPage(
                              duration: Duration(milliseconds: 500),
                              curve: Curves.easeIn);
                        } else {
                          Navigator.of(context).pushNamed('LoginScreen');
                        }
                      },
                      color: Color(0xff5F33E1),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          index < onboardinglist.length - 1
                              ? "Next"
                              : "Get Started",
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              color: Color(0xffFFFFFF)),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          )
        ]),
      ),
    );
  }
}

class OnBoarding {
  final String title;

  final String image;
  final String description;
  OnBoarding(
      {required this.title, required this.image, required this.description});
}

List<OnBoarding> dataBoarding() {
  return [
    OnBoarding(
        title: "Manage your tasks",
        image: "assets/images/onboard1.png",
        description:
            "You can easily manage all of your daily tasks in DoMe for free"),
    OnBoarding(
        title: " Create daily routine",
        image: "assets/images/onboard2.png",
        description:
            "asky  you can create your personalized routine to stay productive"),
    OnBoarding(
        title: " Orgonaize your tasks",
        image: "assets/images/onboard3.png",
        description:
            "You can organize your daily tasks by adding your tasks into separate categories"),
  ];
}

class CustomAntimatedwidget extends StatelessWidget {
  CustomAntimatedwidget(
      {required this.index, required this.delay, required this.child});
  final int index;
  final int delay;
  final Widget child;
  @override
  Widget build(BuildContext context) {
    if (index == 1) {
      return FadeInDown(delay: Duration(milliseconds: delay), child: child);
    }
    return FadeInUp(delay: Duration(milliseconds: delay), child: child);
  }
}
