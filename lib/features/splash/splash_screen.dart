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
    Future.delayed(const Duration(seconds: 3), () {
      if (isOnBoardingShown) {
        pushTo(context, Routes.onBoarding);
      } else {
        pushTo(context, Routes.onBoarding);
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
