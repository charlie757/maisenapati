import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:mainsenapatirajasthan/utils/routes.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    callSplash();
    super.initState();
  }

  callSplash() async {
    Future.delayed(Duration(seconds: 2), () {
      Get.offAllNamed(Routes.dashboard);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Align(
          alignment: Alignment.center,
          child: Lottie.asset('assets/lottie/splashlottie.json')),
    );
  }
}
