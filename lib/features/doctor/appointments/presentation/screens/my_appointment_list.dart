import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:se7ety/core/services/firebase/firebase_provider.dart';
import 'package:se7ety/core/styles/colors.dart';
import 'package:se7ety/core/styles/text_styles.dart';
import 'package:se7ety/core/utils/navigations.dart';
import 'package:se7ety/features/patient/booking/data/model/appointment_model.dart';

class MyAppointmentList extends StatefulWidget {
  const MyAppointmentList({super.key});

  @override
  State<MyAppointmentList> createState() => _MyAppointmentListState();
}

class _MyAppointmentListState extends State<MyAppointmentList> {
  late Future<QuerySnapshot> _appointmentsFuture;

  @override
  void initState() {
    super.initState();
    _appointmentsFuture = FirebaseProvider.getBookedAppointmentsByDoctorId();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: FutureBuilder(
        future: _appointmentsFuture,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
          return snapshot.data!.docs.isEmpty
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        'assets/images/no_scheduled.svg',
                        width: 250,
                      ),
                      Text('لا يوجد حجوزات قادمة', style: TextStyles.fs18),
                    ],
                  ),
                )
              : ListView.separated(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  scrollDirection: Axis.vertical,
                  itemCount: snapshot.data?.docs.length ?? 0,
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 15),
                  itemBuilder: (context, index) {
                    AppointmentModel model = AppointmentModel.fromJson(
                      snapshot.data!.docs[index].data() as Map<String, dynamic>,
                    );
                    String documentId = snapshot.data!.docs[index].id;

                    return ExpansionTile(
                      collapsedShape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      childrenPadding: const EdgeInsets.symmetric(vertical: 10),
                      expandedCrossAxisAlignment: CrossAxisAlignment.end,
                      backgroundColor: AppColors.accentColor,
                      collapsedBackgroundColor: AppColors.accentColor,
                      title: Text(
                        'اسم المريض: ${model.name}',
                        style: TextStyles.fs16,
                      ),
                      subtitle: Padding(
                        padding: const EdgeInsets.only(top: 5, left: 5),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                const Icon(
                                  Icons.calendar_month_rounded,
                                  color: AppColors.primaryColor,
                                  size: 16,
                                ),
                                const SizedBox(width: 10),
                                Text(
                                  DateFormat.yMMMMd(
                                    'ar',
                                  ).format(model.date).toString(),
                                  style: TextStyles.fs14,
                                ),
                                const SizedBox(width: 30),
                                Text(
                                  _compareDate(model.date) ? "اليوم" : "",
                                  style: TextStyles.fs14.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.green,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                const Icon(
                                  Icons.watch_later_outlined,
                                  color: AppColors.primaryColor,
                                  size: 16,
                                ),
                                const SizedBox(width: 10),
                                Text(
                                  DateFormat.jm(
                                    'ar',
                                  ).format(model.date).toString(),
                                  style: TextStyles.fs14,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                            bottom: 5,
                            right: 10,
                            left: 16,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Row(
                                children: [
                                  const Icon(
                                    Icons.location_on_rounded,
                                    color: AppColors.primaryColor,
                                    size: 16,
                                  ),
                                  const SizedBox(width: 10),
                                  Text(model.location, style: TextStyles.fs14),
                                ],
                              ),
                              const SizedBox(height: 10),
                              SizedBox(
                                width: double.infinity,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    foregroundColor: AppColors.accentColor,
                                    backgroundColor: AppColors.redColor,
                                  ),
                                  onPressed: () {
                                    showAlertDialog(context, documentId);
                                  },
                                  child: const Text('حذف الحجز'),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  },
                );
        },
      ),
    );
  }

  void showAlertDialog(BuildContext context, String docID) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog.adaptive(
          title: const Text("حذف الحجز"),
          content: const Text("هل متاكد من حذف هذا الحجز ؟"),
          actions: [
            TextButton(
              child: const Text("لا"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text("نعم"),
              onPressed: () async {
                await FirebaseProvider.deleteBookedAppointment(docID);
                setState(() {
                  _appointmentsFuture =
                      FirebaseProvider.getBookedAppointmentsByDoctorId();
                });
                if (context.mounted) pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  bool _compareDate(DateTime date) {
    DateTime now = DateTime.now();
    if (now.year == date.year &&
        now.month == date.month &&
        now.day == date.day) {
      return true;
    } else {
      return false;
    }
  }
}

