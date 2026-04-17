import 'package:flutter/material.dart';
import 'package:se7ety/core/styles/colors.dart';
import 'package:se7ety/core/styles/text_styles.dart';

class PasswordTextFormField extends StatefulWidget {
  const PasswordTextFormField({
    super.key,
    required this.text,
    this.validator,
    required this.controller,
    this.suffixIcon,
    this.prefixIcon,
  });
  final String text;
  final String? Function(String?)? validator;
  final TextEditingController controller;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  @override
  State<PasswordTextFormField> createState() => _PasswordTextFormFieldState();
}

class _PasswordTextFormFieldState extends State<PasswordTextFormField> {
  bool obscureText = true;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 22),
      child: TextFormField(
        textInputAction: TextInputAction.next,
        onTapOutside: (event) {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        obscureText: obscureText,
        decoration: InputDecoration(
          hintText: widget.text,
          hintStyle: TextStyles.fs14.copyWith(color: AppColors.darkGray),
          prefixIcon:
              widget.prefixIcon ??
              const Icon(Icons.lock, color: AppColors.primaryColor),
          suffixIcon: IconButton(
            icon: Icon(
              obscureText ? Icons.visibility : Icons.visibility_off,
              color: AppColors.primaryColor,
            ),
            onPressed: () {
              setState(() {
                obscureText = !obscureText;
              });
            },
          ),
        ),
        validator: widget.validator,
        controller: widget.controller,
      ),
    );
  }
}
