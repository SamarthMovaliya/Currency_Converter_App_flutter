import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  navigatorTo() {
    Future.delayed(
      const Duration(seconds: 3),
      () {
        Navigator.pushReplacementNamed(context, 'HomeScreen');
      },
    );
  }

  @override
  void initState() {
    super.initState();
    navigatorTo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: TweenAnimationBuilder(
          tween: Tween<double>(begin: 1.3, end: 1),
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInToLinear,
          builder: (context, value, child) {
            return Transform.scale(
              scale: value,
              child: TweenAnimationBuilder(
                tween: Tween<double>(begin: 1, end: 0),
                curve: Curves.decelerate,
                duration: const Duration(milliseconds: 500),
                builder: (context, value, child) {
                  return Transform.rotate(
                    angle: value,
                    child: const Image(
                      image: AssetImage(
                          'assets/logo/currencyLogo-removebg-preview.png'),
                    ),
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
