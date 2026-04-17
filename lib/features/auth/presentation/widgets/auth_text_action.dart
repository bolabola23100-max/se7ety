import 'package:flutter/material.dart';
import 'package:se7ety/core/styles/colors.dart';

class AuthTextAction extends StatelessWidget {
  const AuthTextAction({
    super.key,
    required this.text1,
    required this.text2,
    required this.onPressed,
  });

  final String text1;
  final String text2;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 10),
      child: SafeArea(
        child: Text.rich(
          TextSpan(
            children: [
              TextSpan(text: text1, style: TextStyle(fontSize: 12)),
              WidgetSpan(
                alignment: PlaceholderAlignment.middle,
                child: TextButton(
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.zero,
                    minimumSize: Size.zero,
                  ),
                  onPressed: onPressed,
                  child: Text(
                    text2,
                    style: const TextStyle(
                      fontSize: 12,
                      color: AppColors.primaryColor,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
