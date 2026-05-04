import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:se7ety/core/styles/colors.dart';
import 'package:se7ety/core/styles/text_styles.dart';
import 'package:se7ety/features/doctor/profile/presentation/screen/doctor_profile.dart';
import 'package:se7ety/features/doctor/appointments/presentation/screens/my_appointment_list.dart';

class DoctorMainAppScreen extends StatefulWidget {
  const DoctorMainAppScreen({super.key});

  @override
  State<DoctorMainAppScreen> createState() => _MainPageState();
}

class _MainPageState extends State<DoctorMainAppScreen> {
  int _selectedIndex = 0;
  final List<Widget> _pages = [const DoctorProfileScreen(), const MyAppointmentList()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: Container(
        padding: const EdgeInsets.only(
          left: 10,
          right: 10,
          top: 10,
          bottom: 12,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
          boxShadow: [
            BoxShadow(blurRadius: 20, color: Colors.black.withOpacity(.2)),
          ],
        ),
        child: GNav(
          curve: Curves.easeIn,
          gap: 4,
          rippleColor: Colors.grey,
          hoverColor: Colors.grey,
          haptic: true,
          tabBorderRadius: 20,

          activeColor: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
          duration: const Duration(milliseconds: 400),
          tabBackgroundColor: AppColors.primaryColor,
          textStyle: TextStyles.fs18.copyWith(color: Colors.black),
          tabs: const [
            GButton(iconSize: 28, icon: Icons.home, text: 'الرئيسية'),
            GButton(icon: Icons.calendar_today, text: 'المواعيد'),
          ],
          selectedIndex: _selectedIndex,
          onTabChange: (value) {
            setState(() {
              _selectedIndex = value;
            });
          },
        ),
      ),
    );
  }
}
