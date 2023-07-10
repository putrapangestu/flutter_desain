import 'package:aplikasi_scanner/app/modules/login/login.dart';
import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();
    Future.delayed(
      const Duration(seconds: 3),
      () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const Login(),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff5C715E),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/logos.png',
              width: 150,
            ),
            const SizedBox(
              height: 30,
            ),
            const SizedBox(
              height: 70,
              child: LoadingIndicator(
                indicatorType: Indicator.ballPulse,
                colors: [Colors.white],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
