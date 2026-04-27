import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:se7ety/core/card/doctor_card.dart';
import 'package:se7ety/core/services/firebase/firebase_provider.dart';
import 'package:se7ety/core/styles/colors.dart';
import 'package:se7ety/core/styles/text_styles.dart';
import 'package:se7ety/features/auth/data/model/doctor_model.dart';

class SpecializationSearchScreen extends StatelessWidget {
  final String specialization;
  const SpecializationSearchScreen({super.key, required this.specialization});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: AppColors.lightGray,
        backgroundColor: AppColors.primaryColor,
        title: Text(specialization),
      ),
      body: FutureBuilder(
        future: FirebaseProvider.getDoctors(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
          return snapshot.data?.docs.isEmpty == true
              ? EmptyWidget()
              : Padding(
                  padding: const EdgeInsets.all(15),
                  child: ListView.builder(
                    physics: const ClampingScrollPhysics(),
                    itemCount: snapshot.data?.docs.length,
                    itemBuilder: (context, index) {
                      DoctorModel doctor = DoctorModel.fromJson(
                        snapshot.data!.docs[index].data()
                            as Map<String, dynamic>,
                      );
                      if (doctor.specialization == '' ||
                          doctor.specialization == null) {
                        return const SizedBox();
                      }
                      return DoctorCard(doctor: doctor);
                    },
                  ),
                );
        },
      ),
    );
  }
}

class EmptyWidget extends StatelessWidget {
  const EmptyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.search_off_rounded, size: 250),
            Text('لا يوجد دكتور بهذا التخصص حاليا', style: TextStyles.fs18),
          ],
        ),
      ),
    );
  }
}
