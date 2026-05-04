import 'package:flutter/material.dart';
import 'package:se7ety/core/styles/colors.dart';

Widget buildTextField(String hint, {int maxLines = 1}) {
  return TextField(
    maxLines: maxLines,
    decoration: InputDecoration(
      hintText: hint,
      hintStyle: const TextStyle(fontSize: 14),
      filled: true,
      fillColor: AppColors.accentColor,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide.none,
      ),
    ),
  );
}
