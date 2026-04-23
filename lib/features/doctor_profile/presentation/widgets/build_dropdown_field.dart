import 'package:flutter/material.dart';
import 'package:se7ety/core/styles/colors.dart';

class SpecialtyDropDown extends StatefulWidget {
  final String? value;
  final ValueChanged<String?> onChanged;

  const SpecialtyDropDown({
    super.key,
    required this.value,
    required this.onChanged,
  });

  @override
  State<SpecialtyDropDown> createState() => _SpecialtyDropDownState();
}

class _SpecialtyDropDownState extends State<SpecialtyDropDown> {
  final List<String> specialties = [
    'دكتور عظام',
    'دكتور قلب',
    'دكتور جراحة',
    'دكتور عيون',
    'دكتور أطفال',
    'دكتور نساء وتوليد',
    'دكتور أسنان',
    'دكتور نفساني',
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
        color: AppColors.accentColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          isExpanded: true,
          hint: const Text('اختر التخصص', style: TextStyle(fontSize: 14)),
          value: widget.value,
          icon: const Icon(
            Icons.keyboard_arrow_down,
            color: AppColors.primaryColor,
            size: 30,
          ),
          onChanged: widget.onChanged,
          items: specialties.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Align(
                alignment: Alignment.centerRight,
                child: Text(value),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}