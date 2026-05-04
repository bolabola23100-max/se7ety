import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:se7ety/core/routes/routes.dart';
import 'package:se7ety/core/services/local/shared_pref.dart';
import 'package:se7ety/core/styles/colors.dart';
import 'package:se7ety/core/styles/text_styles.dart';
import 'package:se7ety/core/utils/navigations.dart';
import 'package:se7ety/core/widgets/inputs/main_button.dart';
import 'package:se7ety/features/auth/data/model/doctor_model.dart';
import 'package:se7ety/features/doctor/profile/presentation/widgets/icon_tile.dart';
import 'package:se7ety/features/doctor/profile/presentation/widgets/tile_widget.dart';
import 'package:se7ety/core/services/firebase/firebase_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DoctorProfileScreen extends StatefulWidget {
  final DoctorModel? doctorModel;

  const DoctorProfileScreen({super.key, this.doctorModel});
  @override
  State<DoctorProfileScreen> createState() => _DoctorProfileScreenState();
}

class _DoctorProfileScreenState extends State<DoctorProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('بيانات الدكتور')),
      body: widget.doctorModel == null
          ? StreamBuilder<DocumentSnapshot>(
              stream: FirebaseProvider.getCurrentDoctor(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(child: CircularProgressIndicator());
                }
                var doctorData = DoctorModel.fromJson(
                  snapshot.data!.data() as Map<String, dynamic>,
                );
                return _buildProfileContent(doctorData);
              },
            )
          : _buildProfileContent(widget.doctorModel!),
      bottomNavigationBar: widget.doctorModel == null
          ? null
          : SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: MainButton(
                  text: 'احجز موعد الان',
                  onPressed: () {
                    pushTo(context, Routes.booking, extra: widget.doctorModel);
                  },
                ),
              ),
            ),
    );
  }

  Widget _buildProfileContent(DoctorModel doctorModel) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (widget.doctorModel == null)
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                    onPressed: () {
                      pushTo(
                        context,
                        Routes.doctorProfileComplete,
                        extra: doctorModel,
                      );
                    },
                    icon: const Icon(Icons.edit, color: AppColors.primaryColor),
                  ),
                ],
              ),
            const SizedBox(height: 20),
            Row(
              children: [
                Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    CircleAvatar(
                      radius: 60,
                      backgroundColor: AppColors.accentColor,
                      child: CircleAvatar(
                        backgroundColor: AppColors.accentColor,
                        radius: 60,
                        backgroundImage:
                            (doctorModel.imageUrl != null &&
                                doctorModel.imageUrl!.isNotEmpty)
                            ? NetworkImage(doctorModel.imageUrl!)
                            : const AssetImage('assets/doc.png')
                                  as ImageProvider,
                      ),
                    ),
                  ],
                ),
                const SizedBox(width: 30),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "د. ${doctorModel.name ?? ''}",
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyles.fs16.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        doctorModel.specialization ?? '',
                        style: TextStyles.fs16,
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          Text(
                            doctorModel.rating.toString(),
                            style: TextStyles.fs16,
                          ),
                          const SizedBox(width: 3),
                          const Icon(
                            Icons.star_rounded,
                            size: 20,
                            color: Colors.orange,
                          ),
                        ],
                      ),
                      const SizedBox(height: 15),
                      Row(
                        children: [
                          IconTile(
                            onTap: () {},
                            backColor: AppColors.accentColor,
                            imgAssetPath: Icons.phone,
                            num: '1',
                          ),
                          if (doctorModel.phone2?.isNotEmpty == true)
                            IconTile(
                              onTap: () {},
                              backColor: AppColors.accentColor,
                              imgAssetPath: Icons.phone,
                              num: '2',
                            ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),

            const SizedBox(height: 25),
            Text(
              "نبذه تعريفية",
              style: TextStyles.fs16.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text(doctorModel.bio ?? '', style: TextStyles.fs16),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.all(15),
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: AppColors.accentColor,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TileWidget(
                    text: '${doctorModel.openHour} - ${doctorModel.closeHour}',
                    icon: Icons.watch_later_outlined,
                  ),
                  const SizedBox(height: 15),
                  TileWidget(
                    text: doctorModel.address ?? '',
                    icon: Icons.location_on_rounded,
                  ),
                ],
              ),
            ),
            const Divider(),
            const SizedBox(height: 20),
            Text(
              "معلومات الاتصال",
              style: TextStyles.fs16.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.all(15),
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: AppColors.accentColor,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TileWidget(text: doctorModel.email ?? '', icon: Icons.email),
                  const SizedBox(height: 15),
                  TileWidget(text: doctorModel.phone1 ?? '', icon: Icons.call),
                  if (doctorModel.phone2?.isNotEmpty == true) ...[
                    const SizedBox(height: 15),
                    TileWidget(
                      text: doctorModel.phone2 ?? '',
                      icon: Icons.call,
                    ),
                  ],
                  if (widget.doctorModel == null)
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 15),
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: AppColors.redColor,
                      ),
                      child: TextButton(
                        onPressed: () async {
                          await FirebaseAuth.instance.signOut();
                          await SharedPref.removeData(SharedPref.userIdKey);
                          if (context.mounted) {
                            pushAndRemoveUntil(context, Routes.welcome);
                          }
                        },
                        child: Text(
                          'تسجيل الخروج',
                          style: TextStyles.fs16.copyWith(color: Colors.white),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
