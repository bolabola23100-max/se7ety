import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:se7ety/core/card/doctor_card.dart';
import 'package:se7ety/core/services/firebase/firebase_provider.dart';
import 'package:se7ety/core/styles/colors.dart';
import 'package:se7ety/core/widgets/inputs/custom_text_form_field.dart';
import 'package:se7ety/features/auth/data/model/doctor_model.dart';
import 'package:se7ety/features/patient/home/presentation/screens/specialization_search_screen.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  String search = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('ابحث عن دكتور')),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            Container(
              height: 55,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(25)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(.3),
                    blurRadius: 15,
                    offset: const Offset(5, 5),
                  ),
                ],
              ),
              child: CustomTextFormField(
                onChanged: (searchKey) {
                  setState(() {
                    search = searchKey;
                  });
                },
                suffixIcon: const Icon(
                  Icons.search,
                  color: AppColors.primaryColor,
                ),
                hintText: 'ابحث',
              ),
            ),
            const Gap(15),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 10,
                ),
                child: SearchList(search: search),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SearchList extends StatelessWidget {
  const SearchList({super.key, required this.search});

  final String search;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: FirebaseProvider.searchForDoctorsByName(search),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot?> snapshot) {
        if (snapshot.hasError) {
          log(snapshot.error.toString());
          return const Center(child: Text('حدث خطأ'));
        } else if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }
        return snapshot.data!.docs.isEmpty
            ? const EmptyWidget()
            : Scrollbar(
                child: ListView.builder(
                  itemCount: snapshot.data?.docs.length,
                  itemBuilder: (context, index) {
                    DoctorModel doctor = DoctorModel.fromJson(
                      snapshot.data!.docs[index].data() as Map<String, dynamic>,
                    );
                    return DoctorCard(doctor: doctor);
                  },
                ),
              );
      },
    );
  }
}
