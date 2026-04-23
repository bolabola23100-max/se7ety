import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:se7ety/core/styles/colors.dart';
import 'package:se7ety/core/styles/text_styles.dart';

class SpecializationsListViewItem extends StatelessWidget {
  const SpecializationsListViewItem({super.key, required this.index});
  final int index;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      width: 100,
      decoration: BoxDecoration(
        color: AppColors.primaryColor.withValues(alpha: index * 0.15),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.medication, color: Colors.white, size: 40),
          const Gap(10),
          Text(
            index % 2 == 0 ? 'جراحة عامة' : 'دكتور قلب',
            style: TextStyles.fs14.copyWith(color: Colors.white),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
