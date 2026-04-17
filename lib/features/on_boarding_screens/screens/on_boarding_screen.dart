import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:se7ety/core/routes/routes.dart';
import 'package:se7ety/core/services/local/shared_pref.dart';
import 'package:se7ety/core/styles/colors.dart';
import 'package:se7ety/core/styles/text_styles.dart';
import 'package:se7ety/core/utils/navigations.dart';
import 'package:se7ety/core/widgets/inputs/main_button.dart';
import 'package:se7ety/features/on_boarding_screens/screens/on_boarding_model.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  final controller = PageController();
  int currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          if (currentPage != pages.length - 1)
            TextButton(
              onPressed: () {
                SharedPref.cacheOnBoarding();
                pushReplacement(context, Routes.welcome);
              },
              child: Text("skip".tr()),
            ),
        ],
      ),

      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                controller: controller,
                onPageChanged: (index) {
                  setState(() {
                    currentPage = index;
                  });
                },
                itemCount: pages.length,
                itemBuilder: (BuildContext context, int index) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(pages[index].image, height: 300, width: 300),
                      Gap(30),
                      Text(
                        pages[index].title,
                        style: TextStyles.fs20.copyWith(
                          color: AppColors.primaryColor,
                        ),
                      ),
                      Gap(10),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25),
                        child: Text(
                          pages[index].description,
                          style: TextStyles.fs14.copyWith(
                            color: AppColors.gray,
                          ),

                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
            SizedBox(
              height: 100,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 25,
                  vertical: 30,
                ),
                child: Row(
                  children: [
                    SmoothPageIndicator(
                      count: pages.length,
                      controller: controller,
                      effect: const ExpandingDotsEffect(
                        activeDotColor: AppColors.primaryColor,
                        dotHeight: 10,
                        dotWidth: 10,
                      ),
                    ),
                    const Spacer(),
                    if (currentPage == pages.length - 1)
                      MainButton(
                        text: "لنبدأ",
                        onPressed: () {
                          if (controller.page == pages.length - 1) {
                            SharedPref.cacheOnBoarding();
                            pushReplacement(context, Routes.welcome);
                          } else {
                            controller.nextPage(
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.easeIn,
                            );
                          }
                        },
                        w: 100,
                        h: 50,
                        borderRadius: 15,
                        buttonColor: AppColors.primaryColor,
                      ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
