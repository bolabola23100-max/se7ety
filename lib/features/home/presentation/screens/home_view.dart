import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:se7ety/core/styles/colors.dart';
import 'package:se7ety/core/styles/text_styles.dart';
import 'package:se7ety/features/home/presentation/widgets/doctor_card_list_view.dart';
import 'package:se7ety/features/home/presentation/widgets/specializations_list_view.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('مرحباً،', style: TextStyles.fs18),
                      const Gap(5),
                      Text(
                        'بولا',
                        style: TextStyles.fs20.copyWith(
                          fontWeight: FontWeight.bold,
                          color: AppColors.primaryColor,
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  const CircleAvatar(
                    backgroundColor: AppColors.accentColor,
                    child: Icon(
                      Icons.notifications_none,
                      color: AppColors.primaryColor,
                    ),
                  ),
                ],
              ),
            ),
            const Gap(20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                'احجز الآن وكن جزءًا من رحلتك الصحية.',
                style: TextStyles.fs20.copyWith(fontWeight: FontWeight.bold),
              ),
            ),
            const Gap(20),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    'التخصصات',
                    style: TextStyles.fs18.copyWith(
                      fontWeight: FontWeight.bold,
                      color: AppColors.primaryColor,
                    ),
                  ),
                ),
              ],
            ),
            const Gap(15),
            SizedBox(height: 120, child: SpecializationsListView()),
            const Gap(25),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                'الأعلى تقييماً',
                style: TextStyles.fs18.copyWith(fontWeight: FontWeight.bold),
              ),
            ),
            const Gap(15),
            const Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: DoctorCardListView(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
