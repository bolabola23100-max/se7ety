import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:se7ety/core/styles/colors.dart';
import 'package:se7ety/core/styles/text_styles.dart';

Widget buildContactItem(IconData icon, String text) {
  return Row(
    children: [
      Icon(icon, color: AppColors.primaryColor, size: 20),
      const Gap(15),
      Text(text, style: TextStyles.fs14),
    ],
  );
}
