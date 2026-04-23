import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:se7ety/core/routes/routes.dart';
import 'package:se7ety/core/styles/colors.dart';
import 'package:se7ety/core/styles/text_styles.dart';
import 'package:se7ety/core/utils/navigations.dart';
import 'package:se7ety/core/widgets/inputs/main_button.dart';
import 'package:se7ety/features/doctor_profile/presentation/widgets/build_dropdown_field.dart';
import 'package:se7ety/features/doctor_profile/presentation/widgets/build_field_label.dart';
import 'package:se7ety/features/doctor_profile/presentation/widgets/build_text_field.dart';
import 'package:se7ety/features/doctor_profile/presentation/widgets/build_time_field.dart';

class DoctorProfileCompleteView extends StatefulWidget {
  const DoctorProfileCompleteView({super.key});

  @override
  State<DoctorProfileCompleteView> createState() =>
      _DoctorProfileCompleteViewState();
}

class _DoctorProfileCompleteViewState extends State<DoctorProfileCompleteView> {
  String? _selectedSpecialty;
  String _startTime = '10:00 AM';
  String _endTime = '10:00 PM';

  Future<void> _selectTime(BuildContext context, bool isStartTime) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null) {
      setState(() {
        if (isStartTime) {
          _startTime = picked.format(context);
        } else {
          _endTime = picked.format(context);
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          'إكمال عملية التسجيل',
          style: TextStyles.fs20.copyWith(color: AppColors.accentColor),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const Gap(20),
            Stack(
              alignment: Alignment.bottomRight,
              children: [
                const CircleAvatar(
                  radius: 60,
                  backgroundColor: AppColors.accentColor,
                  child: Icon(
                    Icons.person,
                    size: 80,
                    color: AppColors.primaryColor,
                  ),
                ),
                CircleAvatar(
                  radius: 18,
                  backgroundColor: AppColors.primaryColor,
                  child: const Icon(
                    Icons.camera_alt,
                    size: 16,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            const Gap(30),
            buildFieldLabel('التخصص'),
            SpecialtyDropDown(
              value: _selectedSpecialty,
              onChanged: (value) {
                setState(() {
                  _selectedSpecialty = value;
                });
              },
            ),
            const Gap(20),
            buildFieldLabel('نبذة تعريفية'),
            buildTextField(
              'سجل المعلومات الطبية العامة مثل تعليمك الأكاديمي وخبراتك السابقة..',
              maxLines: 5,
            ),
            const Gap(20),
            buildFieldLabel('عنوان العيادة'),
            buildTextField('٥ شارع مصدق - الدقي - الجيزة'),
            const Gap(20),
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      buildFieldLabel('ساعات العمل من'),
                      buildTimeField(
                        _startTime,
                        onTap: () => _selectTime(context, true),
                      ),
                    ],
                  ),
                ),
                const Gap(20),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      buildFieldLabel('الى'),
                      buildTimeField(
                        _endTime,
                        onTap: () => _selectTime(context, false),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const Gap(20),
            buildFieldLabel('رقم الهاتف ١'),
            buildTextField('+20xxxxxxxxxx'),
            const Gap(20),
            buildFieldLabel('رقم الهاتف ٢ (اختياري)'),
            buildTextField('+20xxxxxxxxxx'),
            const Gap(30),
            MainButton(
              onPressed: () {
                pushReplacement(context, Routes.navRoot);
              },
              text: 'التسجيل',
              w: double.infinity,
              h: 55,
            ),
          ],
        ),
      ),
    );
  }
}
