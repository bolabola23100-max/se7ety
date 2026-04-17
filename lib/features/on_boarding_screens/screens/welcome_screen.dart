import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:se7ety/core/constants/app_icons.dart';
import 'package:se7ety/core/constants/user_type_enum.dart';
import 'package:se7ety/core/routes/routes.dart';
import 'package:se7ety/core/styles/colors.dart';
import 'package:se7ety/core/styles/text_styles.dart';
import 'package:se7ety/core/utils/navigations.dart';
import 'package:se7ety/core/widgets/inputs/main_button.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            AppIcons.bg,
            width: double.infinity,
            height: double.infinity,
            fit: BoxFit.cover,
          ),
          Positioned(
            left: 20,
            right: 20,
            top: 0,
            bottom: 0,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Gap(100),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      "welcome".tr(),
                      style: TextStyles.fs30.copyWith(
                        color: AppColors.primaryColor,
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      "welcome_subtitle".tr(),
                      style: TextStyles.fs16,
                    ),
                  ),
                  Spacer(flex: 3),
                  Column(
                    children: [
                      Container(
                        height: 230,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: AppColors.primaryColor.withValues(alpha: 0.7),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          children: [
                            Gap(20),
                            Center(
                              child: Text(
                                "register".tr(),
                                style: TextStyles.fs18.copyWith(
                                  color: AppColors.lightGray,
                                ),
                              ),
                            ),
                            Gap(20),

                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 20,
                              ),
                              child: MainButton(
                                w: 60,

                                onPressed: () {
                                  pushTo(
                                    context,
                                    Routes.login,
                                    extra: UserTypeEnum.doctor,
                                  );
                                },
                                text: "doctor".tr(),
                                borderRadius: 20,
                                buttonColor: AppColors.bgColor.withValues(
                                  alpha: 0.5,
                                ),
                                textColor: AppColors.dark,
                              ),
                            ),
                            Gap(20),

                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 20,
                              ),
                              child: MainButton(
                                onPressed: () {
                                  pushTo(
                                    context,
                                    Routes.login,
                                    extra: UserTypeEnum.patient,
                                  );
                                },
                                text: "patient".tr(),
                                borderRadius: 20,
                                buttonColor: AppColors.bgColor.withValues(
                                  alpha: 0.5,
                                ),
                                textColor: AppColors.dark,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Spacer(flex: 1),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
