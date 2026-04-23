import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:se7ety/core/styles/colors.dart';
import 'package:se7ety/core/styles/text_styles.dart';
import 'package:se7ety/core/widgets/inputs/main_button.dart';
import 'package:se7ety/features/booking/presentation/widgets/build_date_field.dart';
import 'package:se7ety/features/booking/presentation/widgets/build_field_label.dart';
import 'package:se7ety/features/booking/presentation/widgets/build_text_field.dart';
import 'package:se7ety/features/booking/presentation/widgets/build_time_slot.dart';

class BookingView extends StatelessWidget {
  const BookingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('احجز مع دكتورك'), centerTitle: true),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: AppColors.accentColor,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Row(
                children: [
                  const Icon(
                    Icons.person,
                    size: 50,
                    color: AppColors.primaryColor,
                  ),
                  const Gap(15),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "بولا",
                        style: TextStyles.fs16.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text('دكتور قلب', style: TextStyles.fs14),
                      Row(
                        children: [
                          const Icon(Icons.star, color: Colors.amber, size: 18),
                          const Text(' 4'),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const Gap(20),
            const Center(
              child: Text(
                '-- ادخل بيانات الحجز --',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primaryColor,
                ),
              ),
            ),
            const Gap(20),
            buildFieldLabel('اسم المريض'),
            buildTextField(''),
            const Gap(15),
            buildFieldLabel('رقم الهاتف'),
            buildTextField(''),
            const Gap(15),
            buildFieldLabel('وصف الحاله'),
            buildTextField('', maxLines: 3),
            const Gap(20),
            buildFieldLabel('تاريخ الحجز'),
            buildDateField(),
            const Gap(20),
            buildFieldLabel('وقت الحجز'),
            const Gap(10),
            Row(
              spacing: 10,
              children: [
                buildTimeSlot('14:00'),
                buildTimeSlot('15:00'),
                buildTimeSlot('16:00'),
                buildTimeSlot('17:00'),
                buildTimeSlot('18:00'),
                buildTimeSlot('19:00'),
              ],
            ),
            const Gap(30),
            MainButton(
              onPressed: () {},
              text: 'تأكيد الحجز',
              w: double.infinity,
              h: 50,
            ),
          ],
        ),
      ),
    );
  }
}
