import 'package:flutter/material.dart';
import 'package:gear_up/utils/Strings.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      // backgroundColor: Colors.black,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [SplashScreenText()],
        ),
      ),
    );
  }
}

class SplashScreenText extends StatelessWidget {
  const SplashScreenText({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Text(
      Strings.splashScreenText,
      style: TextStyle(
        color: Colors.white,
        fontSize: 32,
        fontStyle: FontStyle.italic,
        fontFamily: 'General Sans',
        fontWeight: FontWeight.w700,
        height: 0,
        letterSpacing: -0.41,
      ),
    );
  }
}
