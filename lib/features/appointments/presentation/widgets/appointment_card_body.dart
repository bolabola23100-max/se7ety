import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:se7ety/core/styles/colors.dart';
import 'package:se7ety/core/styles/text_styles.dart';
import 'package:se7ety/core/widgets/inputs/main_button.dart';

class AppointmentCardBody extends StatelessWidget {
  const AppointmentCardBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 11.0),
      child: Container(
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: AppColors.accentColor,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.person, color: AppColors.primaryColor),
                const Gap(10),
                Text(
                  'د. خالد علي عبد الله',
                  style: TextStyles.fs16.copyWith(
                    fontWeight: FontWeight.bold,
                    color: AppColors.primaryColor,
                  ),
                ),
                const Spacer(),
                const Icon(Icons.keyboard_arrow_up),
              ],
            ),
            const Gap(10),
            Row(
              children: [
                const Icon(Icons.calendar_month, size: 18),
                const Gap(5),
                const Text('٢٧ أبريل ٢٠٢٤'),
                const Spacer(),
                const Icon(Icons.access_time, size: 18),
                const Gap(5),
                const Text('٠٣:٠٠ م'),
              ],
            ),
            const Gap(10),
            const Text('اسم المريض: fghgfh'),
            const Gap(5),
            Row(
              children: [
                const Icon(
                  Icons.location_on,
                  size: 18,
                  color: AppColors.primaryColor,
                ),
                const Gap(5),
                const Text('مدينة نصر القاهرة'),
              ],
            ),
            const Gap(15),
            MainButton(
              text: 'حذف الحجز',
              onPressed: () {},
              w: double.infinity,
              h: 55,
            ),
          ],
        ),
      ),
    );
  }
}
