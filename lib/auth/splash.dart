import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  String nextPage = "";
  @override
  void initState() {
    initNextPage();
    super.initState();
  }

  initNextPage() async {
    if (FirebaseAuth.instance.currentUser != null) {
      nextPage = "/home";
    } else {
      nextPage = "/login";
    }
    await Future.delayed(
      const Duration(seconds: 5),
    );
    Navigator.pushReplacementNamed(context, nextPage);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Lottie.asset(
          'assets/Animation - 1713511158332.json',
          repeat: true,
        ),
        // child: Image(
        //   image: AssetImage(
        //       'assets/images/photo_2024-04-19_08-25-52-removebg-preview.png'),
        // ),
      ),
    );
  }
}
