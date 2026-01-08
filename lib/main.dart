import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:tasky/feature/auth/presenation/view/login_screen.dart';
import 'package:tasky/feature/auth/presenation/view/register_screen.dart';
import 'package:tasky/feature/home/presentation/view/home_screen.dart';
import 'package:tasky/feature/onboarding/onboarding.dart';
import 'package:tasky/feature/splashscreen/splash_screen.dart';

//636262Met#e234
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: const FirebaseOptions(
    apiKey: "AIzaSyCSwk92XqcgKWuTf8FTa_hgl-_j5vK_aXI",
    authDomain: "taskeyapp-1e7d2.firebaseapp.com",
    projectId: "taskeyapp-1e7d2",
    storageBucket: "taskeyapp-1e7d2.appspot.com",
    messagingSenderId: "183295420206",
    appId: "1:183295420206:web:721e28fa1a29d455b47cbf",
  ));
  await FirebaseAuth.instance.setPersistence(Persistence.LOCAL);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

     initialRoute:SplashScreen.routeName,
      routes: {
        SplashScreen.routeName: (context) => SplashScreen(),
        OnBoardingScreen.routeName: (context) => OnBoardingScreen(),
        LoginScreen.routeName: (context) => LoginScreen(),
         RegisterScreen.routeName: (context) => RegisterScreen(),
         HomeScreen.routeName: (context) => HomeScreen(),
      },
    );
  }
}
