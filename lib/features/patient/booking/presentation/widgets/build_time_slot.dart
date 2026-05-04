import 'package:flutter/material.dart';
import 'package:se7ety/core/styles/colors.dart';

Widget buildTimeSlot(String time) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
    decoration: BoxDecoration(
      color: AppColors.accentColor,
      border: Border.all(color: AppColors.primaryColor.withValues(alpha: 0.2)),
      borderRadius: BorderRadius.circular(10),
    ),
    child: Text(time),
  );
}
