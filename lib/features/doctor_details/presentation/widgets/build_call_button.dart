import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:se7ety/core/styles/colors.dart';

Widget buildCallButton(IconData icon, String label) {
  return Container(
    height: 40,
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
    decoration: BoxDecoration(
      color: AppColors.accentColor,
      borderRadius: BorderRadius.circular(20),
    ),
    child: Row(
      children: [
        Icon(icon, size: 18, color: AppColors.primaryColor),
        const Gap(5),
        Text(label),
      ],
    ),
  );
}
