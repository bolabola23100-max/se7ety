import 'package:flutter/material.dart';
import 'package:se7ety/features/home/presentation/widgets/specializations_list_view_item.dart';

class SpecializationsListView extends StatelessWidget {
  const SpecializationsListView({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: 5,
      itemBuilder: (context, index) {
        return SpecializationsListViewItem(index: index);
      },
    );
  }
}
