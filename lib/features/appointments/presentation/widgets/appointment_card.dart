import 'package:flutter/material.dart';
import 'package:se7ety/features/appointments/presentation/widgets/appointment_card_body.dart';

class AppointmentCard extends StatelessWidget {
  const AppointmentCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView.builder(
        itemCount: 2,
        itemBuilder: (context, index) {
          return AppointmentCardBody();
        },
      ),
    );
  }
}
