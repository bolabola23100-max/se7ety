import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:se7ety/core/constants/app_icons.dart';
import 'package:se7ety/core/styles/colors.dart';

enum DialogType { error, success }

void showAppSnackBar(
  BuildContext context,
  String errorMsg, {
  DialogType type = DialogType.error,
}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      duration: Duration(milliseconds: 500),
      margin: EdgeInsets.all(10),
      behavior: SnackBarBehavior.floating,
      shape: BeveledRectangleBorder(borderRadius: BorderRadius.circular(5)),
      backgroundColor: type == DialogType.error
          ? AppColors.redColor
          : AppColors.primaryColor,
      content: Text(errorMsg),
    ),
  );
}

void showLoading(BuildContext context) {
  showDialog(
    context: context,
    barrierColor: AppColors.dark.withValues(alpha: .8),
    barrierDismissible: false,
    builder: (context) => Center(child: Lottie.asset(AppIcons.loading)),
  );
}
