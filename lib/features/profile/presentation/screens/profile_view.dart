import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:se7ety/core/routes/routes.dart';
import 'package:se7ety/core/styles/colors.dart';
import 'package:se7ety/core/styles/text_styles.dart';
import 'package:se7ety/core/utils/navigations.dart';
import 'package:se7ety/core/widgets/inputs/main_button.dart';
import 'package:se7ety/features/profile/presentation/Widgets/build_contact_item.dart';
import 'package:se7ety/features/profile/presentation/Widgets/build_section.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('الحساب الشخصي'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              pushTo(context, Routes.settings);
            },
            icon: const Icon(Icons.settings),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Stack(
              alignment: Alignment.bottomRight,
              children: [
                const CircleAvatar(
                  radius: 60,
                  backgroundColor: AppColors.accentColor,
                  child: Icon(
                    Icons.person,
                    size: 80,
                    color: AppColors.primaryColor,
                  ),
                ),
                CircleAvatar(
                  radius: 18,
                  backgroundColor: Colors.white,
                  child: CircleAvatar(
                    radius: 16,
                    backgroundColor: AppColors.primaryColor,
                    child: IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.camera_alt,
                        size: 16,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const Gap(15),
            Text(
              'بولا عاطف',
              style: TextStyles.fs20.copyWith(
                fontWeight: FontWeight.bold,
                color: AppColors.primaryColor,
              ),
            ),
            const Gap(10),
            MainButton(
              text: 'تعديل الحساب',
              onPressed: () {},
              w: 200,
              h: 40,
              borderRadius: 10,
            ),
            const Gap(30),
            buildSection(title: 'نبذه تعريفية', content: 'لم تضاف'),
            const Gap(20),
            buildSection(
              title: 'معلومات التواصل',
              child: Column(
                children: [
                  buildContactItem(Icons.email, 'bola@gmail.com'),
                  const Gap(10),
                  buildContactItem(Icons.phone, 'لم تضاف'),
                ],
              ),
            ),
            const Gap(30),
            Align(
              alignment: Alignment.centerRight,
              child: Text(
                'حجوزاتي',
                style: TextStyles.fs18.copyWith(fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
