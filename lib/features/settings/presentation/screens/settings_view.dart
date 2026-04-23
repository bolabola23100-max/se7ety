import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:se7ety/core/styles/colors.dart';
import 'package:se7ety/core/widgets/custom_back_button.dart';
import 'package:se7ety/core/widgets/inputs/main_button.dart';
import 'package:se7ety/features/settings/presentation/Widgets/build_settings_item.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const CustomBackButton(),
        title: const Text('الاعدادات'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            BuildSettingsItem(icon: Icons.person, title: 'إعدادات الحساب'),
            const Gap(15),
            BuildSettingsItem(icon: Icons.lock, title: 'كلمة السر'),
            const Gap(15),
            BuildSettingsItem(
              icon: Icons.notifications,
              title: 'إعدادات الإشعارات',
            ),
            const Gap(15),
            BuildSettingsItem(icon: Icons.security, title: 'الخصوصية'),
            const Gap(15),
            BuildSettingsItem(
              icon: Icons.help_center,
              title: 'المساعدة والدعم',
            ),
            const Gap(15),
            BuildSettingsItem(icon: Icons.share, title: 'دعوة صديق'),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              height: 55,
              child: MainButton(
                text: 'تسجيل الخروج',
                onPressed: () {},
                borderRadius: 12,
                w: double.infinity,
                h: 55,
                textColor: AppColors.pinkColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
