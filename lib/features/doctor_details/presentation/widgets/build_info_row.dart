import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:se7ety/core/styles/colors.dart';

Widget buildInfoRow(IconData icon, String text) {
  return Row(
    children: [
      CircleAvatar(
        radius: 18,
        backgroundColor: AppColors.primaryColor,
        child: Icon(icon, size: 18, color: Colors.white),
      ),
      const Gap(15),
      Expanded(child: Text(text, style: const TextStyle(fontSize: 16))),
    ],
  );
}
