import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:se7ety/core/styles/colors.dart';

Widget buildDateField() {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
    decoration: BoxDecoration(
      color: AppColors.accentColor,
      borderRadius: BorderRadius.circular(10),
    ),
    child: Row(
      children: [
        const Icon(Icons.calendar_month, color: AppColors.primaryColor),
        const Gap(10),
        const Spacer(),
      ],
    ),
  );
}
