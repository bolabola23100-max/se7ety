import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:se7ety/core/styles/colors.dart';
import 'package:se7ety/core/styles/text_styles.dart';

Widget buildSection({required String title, String? content, Widget? child}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(title, style: TextStyles.fs18.copyWith(fontWeight: FontWeight.bold)),
      const Gap(10),
      Container(
        width: double.infinity,
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: AppColors.accentColor,
          borderRadius: BorderRadius.circular(15),
        ),
        child: child ?? Text(content ?? '', style: TextStyles.fs14),
      ),
    ],
  );
}
