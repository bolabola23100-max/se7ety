import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:se7ety/core/styles/colors.dart';
import 'package:se7ety/core/styles/text_styles.dart';
import 'package:se7ety/features/patient/appointments/presentation/screens/appointment_card.dart';
import 'package:se7ety/features/patient/home/presentation/screens/patient_home_screen.dart';
import 'package:se7ety/features/patient/profile/presentation/screens/profile_view.dart';
import 'package:se7ety/features/patient/search/presentation/screens/search_screen.dart';

class PatientMainAppScreen extends StatefulWidget {
  const PatientMainAppScreen({super.key});

  @override
  State<PatientMainAppScreen> createState() => _MainPageState();
}

class _MainPageState extends State<PatientMainAppScreen> {
  int _selectedIndex = 0;
  List<Widget> _pages = [];

  @override
  void initState() {
    super.initState();
    _pages = [
      PatientHomeScreen(
        onSearch: () {
          setState(() {
            _selectedIndex = 1;
          });
        },
      ),
      SearchScreen(),
      MyAppointmentsScreen(),
      ProfileView(),
    ];
  }

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
            GButton(icon: Icons.search, text: 'البحث'),
            GButton(
              iconSize: 28,
              icon: Icons.calendar_month_rounded,
              text: 'المواعيد',
            ),
            GButton(iconSize: 29, icon: Icons.person, text: 'الحساب'),
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

