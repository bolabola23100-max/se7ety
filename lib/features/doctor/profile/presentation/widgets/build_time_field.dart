import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:se7ety/core/styles/colors.dart';

Widget buildTimeField(String time, {required VoidCallback onTap}) {
  return InkWell(
    onTap: onTap,
    borderRadius: BorderRadius.circular(10),
    child: Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
      decoration: BoxDecoration(
        color: AppColors.accentColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          const Icon(
            Icons.access_time,
            size: 18,
            color: AppColors.primaryColor,
          ),
          const Gap(10),
          Text(time, style: const TextStyle(fontSize: 14)),
        ],
      ),
    ),
  );
}
