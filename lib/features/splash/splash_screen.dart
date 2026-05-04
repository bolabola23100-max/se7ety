import 'package:flutter/material.dart';
import 'package:se7ety/core/constants/app_icons.dart';
import 'package:se7ety/core/routes/routes.dart';
import 'package:se7ety/core/services/local/shared_pref.dart';
import 'package:se7ety/core/utils/navigations.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    bool isOnBoardingShown = SharedPref.getOnBoarding();
    bool isLogin = SharedPref.getUserId().isNotEmpty;
    Future.delayed(const Duration(seconds: 3), () {
      if (!mounted) return;
      if (isLogin) {
        pushReplacement(context, Routes.patientMainAppScreen);
      } else if (isOnBoardingShown) {
        pushReplacement(context, Routes.welcome);
      } else {
        pushReplacement(context, Routes.onBoarding);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Image.asset(AppIcons.logo, height: 250, width: 250)),
    );
  }
}
