import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:marcacion_admin/src/common/helpers/helpers.dart';

class SplashLayout extends StatelessWidget {
  const SplashLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: getTheme(context).primary,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset('assets/lottiefiles/loader.json'),
          ],
        ),
      ),
    );
  }
}
