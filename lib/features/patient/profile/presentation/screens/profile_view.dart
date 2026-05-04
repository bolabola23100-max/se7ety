import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:se7ety/core/constants/app_icons.dart';
import 'package:se7ety/core/routes/routes.dart';
import 'package:se7ety/core/services/firebase/firebase_provider.dart';
import 'package:se7ety/core/styles/colors.dart';
import 'package:se7ety/core/styles/text_styles.dart';
import 'package:se7ety/core/utils/image_uploader.dart';
import 'package:se7ety/core/utils/navigations.dart';
import 'package:se7ety/core/widgets/inputs/main_button.dart';
import 'package:se7ety/features/auth/data/model/patient_model.dart';
import 'package:se7ety/features/doctor/profile/presentation/widgets/tile_widget.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  String? _imagePath;
  File? file;

  String? userId;

  Future<void> _getUser() async {
    userId = FirebaseAuth.instance.currentUser?.uid;
  }

  Future<void> _pickImage() async {
    _getUser();
    final pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );

    if (pickedFile != null) {
      setState(() {
        _imagePath = pickedFile.path;
        file = File(pickedFile.path);
      });
    }
    String? profileUrl = await uploadImageToCloudinary(file!);
    FirebaseProvider.updatePatient(
      PatientModel(uid: userId, image: profileUrl),
    );
  }

  @override
  void initState() {
    super.initState();
    _getUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        elevation: 0,
        title: const Text('الحساب الشخصي'),
        iconTheme: const IconThemeData(color: Colors.black),
        actions: [
          IconButton(
            splashRadius: 20,
            icon: const Icon(Icons.settings, color: AppColors.accentColor),
            onPressed: () {
              pushTo(context, Routes.settings);
            },
          ),
        ],
      ),
      body: SafeArea(
        child: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('patient')
              .doc(userId)
              .snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(child: CircularProgressIndicator());
            }
            PatientModel model = PatientModel.fromJson(
              snapshot.data!.data() as Map<String, dynamic>,
            );
            return Padding(
              padding: const EdgeInsets.all(20),
              child: SingleChildScrollView(
                physics: const ClampingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
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
                                    (model.image?.isNotEmpty == true)
                                    ? NetworkImage(model.image!)
                                    : (_imagePath != null)
                                    ? FileImage(File(_imagePath!))
                                          as ImageProvider
                                    : const AssetImage(AppIcons.doc),
                              ),
                            ),
                            GestureDetector(
                              onTap: () async {
                                await _pickImage();
                              },
                              child: CircleAvatar(
                                radius: 15,
                                backgroundColor: Theme.of(
                                  context,
                                ).scaffoldBackgroundColor,
                                child: const Icon(
                                  Icons.camera_alt_rounded,
                                  size: 20,
                                ),
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
                                "${model.name}",
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyles.fs20,
                              ),
                              const SizedBox(height: 10),
                              (model.city?.isNotEmpty == true)
                                  ? Text(
                                      "${model.city}",
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyles.fs16,
                                    )
                                  : MainButton(
                                      text: 'تعديل الحساب',
                                      w: 100,
                                      onPressed: () {},
                                    ),
                              const SizedBox(height: 15),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 25),
                    Text(
                      "نبذه تعريفيه",
                      style: TextStyles.fs18.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      model.bio?.isNotEmpty == true
                          ? model.bio ?? ''
                          : 'لم تضاف',
                      style: TextStyles.fs16,
                    ),
                    const SizedBox(height: 20),
                    const Divider(),
                    const SizedBox(height: 20),
                    Text(
                      "معلومات التواصل",
                      style: TextStyles.fs18.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Container(
                      padding: const EdgeInsets.all(15),
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: AppColors.accentColor,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TileWidget(
                            text: model.email ?? 'لم تضاف',
                            icon: Icons.email,
                          ),
                          const SizedBox(height: 15),
                          TileWidget(
                            text: model.phone?.isNotEmpty == true
                                ? model.phone ?? ''
                                : 'لم تضاف',
                            icon: Icons.call,
                          ),
                        ],
                      ),
                    ),
                    const Divider(),
                    const SizedBox(height: 20),
                    Text(
                      "حجوزاتي",
                      style: TextStyles.fs18.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

