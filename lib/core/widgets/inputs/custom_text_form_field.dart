import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:se7ety/core/styles/colors.dart';
import 'package:se7ety/core/styles/text_styles.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    super.key,
    required this.hintText,
    this.validator,
    this.keyboardType,
    this.controller,
    this.prefixIcon,
    this.suffixIcon,
    this.onTap,
    this.readOnly = false,
    this.onChanged,
    this.maxLines = 1,
  });

  final String hintText;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
  final TextEditingController? controller;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final Function()? onTap;
  final Function(String)? onChanged;
  final bool readOnly;
  final int maxLines;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 22),
      child: TextFormField(
        controller: controller,
        readOnly: readOnly,
        keyboardType: keyboardType,
        maxLines: maxLines,
        inputFormatters: [
          if (keyboardType == TextInputType.phone)
            LengthLimitingTextInputFormatter(11),
        ],
        textInputAction: TextInputAction.next,
        onTapOutside: (event) {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        decoration: InputDecoration(
          prefixIcon: prefixIcon,
          suffixIcon: suffixIcon,
          hintText: hintText,
          hintStyle: TextStyles.fs14.copyWith(color: AppColors.darkGray),
        ),
        validator: validator,
        onChanged: onChanged,
        onTap: onTap,
      ),
    );
  }
}
