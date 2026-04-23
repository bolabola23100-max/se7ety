import 'package:flutter/material.dart';

import 'package:se7ety/features/home/presentation/widgets/doctor_card_list_view_item.dart';

class DoctorCardListView extends StatelessWidget {
  const DoctorCardListView({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 3,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: DoctorCardListViewItem(),
        );
      },
    );
  }
}
