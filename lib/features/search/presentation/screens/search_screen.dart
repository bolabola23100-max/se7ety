import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:se7ety/core/styles/colors.dart';
import 'package:se7ety/core/widgets/inputs/custom_text_form_field.dart';
import 'package:se7ety/features/search/presentation/Widgets/custom_search_item.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('ابحث عن دكتور'), centerTitle: true),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: CustomTextFormField(
              hintText: 'ابحث عن دكتور',
              prefixIcon: Icon(Icons.search, color: AppColors.primaryColor),
            ),
          ),
          const Gap(20),
          Expanded(child: CustomSearchItem()),
        ],
      ),
    );
  }
}
