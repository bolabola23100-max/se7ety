import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:se7ety/core/styles/colors.dart';
import 'package:se7ety/core/styles/text_styles.dart';
import 'package:se7ety/core/widgets/inputs/main_button.dart';
import 'package:se7ety/features/doctor_details/presentation/widgets/build_call_button.dart';
import 'package:se7ety/features/doctor_details/presentation/widgets/build_info_row.dart';

class DoctorDetailsView extends StatelessWidget {
  const DoctorDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('بيانات الدكتور'), centerTitle: true),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'د. خالد علي عبد الله',
                      style: TextStyles.fs20.copyWith(
                        fontWeight: FontWeight.bold,
                        color: AppColors.primaryColor,
                      ),
                    ),
                    Text('دكتور قلب', style: TextStyles.fs16),
                    Row(
                      children: [
                        const Icon(Icons.star, color: Colors.amber, size: 20),
                        const Text(' 4'),
                      ],
                    ),
                    const Gap(15),
                    Row(
                      children: [
                        buildCallButton(Icons.phone, '1'),
                        const Gap(10),
                        buildCallButton(Icons.phone_android, '2'),
                      ],
                    ),
                  ],
                ),
                const Spacer(),
                const CircleAvatar(
                  radius: 50,
                  backgroundColor: AppColors.accentColor,
                  child: Icon(
                    Icons.person,
                    size: 60,
                    color: AppColors.primaryColor,
                  ),
                ),
              ],
            ),
            const Gap(30),
            const Text(
              'نبذه تعريفية',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const Gap(10),
            const Text(
              'ماجستير في العلوم والتكنولوجيا والنقل البحري في هذا المنتدي في نفس الوقت',
              style: TextStyle(fontSize: 14),
            ),
            const Gap(30),
            Container(
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: AppColors.accentColor,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Column(
                children: [
                  buildInfoRow(Icons.access_time, '14 - 20'),
                  const Gap(15),
                  buildInfoRow(Icons.location_on, 'مدينة نصر القاهرة'),
                ],
              ),
            ),
            const Gap(20),
            Container(
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: AppColors.accentColor,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Column(
                children: [
                  buildInfoRow(Icons.email, 'khaled@gmail.com'),
                  const Gap(10),
                  buildInfoRow(Icons.phone, '01222222222'),
                  const Gap(10),
                  buildInfoRow(Icons.phone, '01222222222'),
                ],
              ),
            ),
            const Gap(30),
            MainButton(
              onPressed: () {},
              text: 'احجز موعد الان',
              w: double.infinity,
              h: 50,
            ),
          ],
        ),
      ),
    );
  }
}
