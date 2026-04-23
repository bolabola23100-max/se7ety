import 'package:flutter/material.dart';
import 'package:se7ety/core/styles/colors.dart';
import 'package:se7ety/core/styles/text_styles.dart';

import 'package:se7ety/features/appointments/presentation/widgets/appointment_card.dart';

class AppointmentsView extends StatelessWidget {
  const AppointmentsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'مواعيد الحجز',
          style: TextStyles.fs16.copyWith(
            fontWeight: FontWeight.bold,
            color: AppColors.accentColor,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: AppointmentCard(),
      ),
    );
  }
}
