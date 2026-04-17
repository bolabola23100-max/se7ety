import 'package:flutter/material.dart';
import 'package:se7ety/core/utils/navigations.dart';

class CustomBackButton extends StatelessWidget {
  const CustomBackButton({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        pop(context);
      },
      icon: Padding(
        padding: const EdgeInsets.only(left: 300),
        child: Icon(Icons.arrow_forward_ios, color: Colors.blue),
      ),
    );
  }
}
