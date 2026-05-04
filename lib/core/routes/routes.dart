import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:se7ety/core/constants/user_type_enum.dart';
import 'package:se7ety/features/patient/appointments/presentation/screens/appointment_card.dart';
import 'package:se7ety/features/auth/data/model/doctor_model.dart';
import 'package:se7ety/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:se7ety/features/auth/presentation/screens/authentication/login_screen.dart';
import 'package:se7ety/features/auth/presentation/screens/authentication/register_screen.dart';
import 'package:se7ety/features/doctor/profile/presentation/screen/doctor_profile.dart';
import 'package:se7ety/features/patient/home/presentation/screens/specialization_search_screen.dart';
import 'package:se7ety/features/patient/main/main_patient_screen.dart';
import 'package:se7ety/features/doctor/main_doctor/main_doctor_screen.dart';
import 'package:se7ety/features/on_boarding_screens/screens/on_boarding_screen.dart';
import 'package:se7ety/features/on_boarding_screens/screens/welcome_screen.dart';
import 'package:se7ety/features/doctor/profile/presentation/screen/doctor_profile_complete_view.dart';
import 'package:se7ety/features/patient/booking/presentation/screens/booking_view.dart';
import 'package:se7ety/features/patient/doctor_details/presentation/screens/doctor_details_view.dart';
import 'package:se7ety/features/patient/settings/presentation/screens/account_information_screen.dart';
import 'package:se7ety/features/patient/settings/presentation/screens/settings_view.dart';
import 'package:se7ety/features/splash/splash_screen.dart';
import 'package:se7ety/features/patient/search/presentation/screens/search_screen.dart';

class Routes {
  static const String splash = "/";
  static const String login = "/login";
  static const String register = "/register";
  static const String welcome = "/welcome";
  static const String onBoarding = "/onBoarding";
  static const String patientMainAppScreen = "/patientMainAppScreen";
  static const String doctorMainAppScreen = "/doctorMainAppScreen";
  static const String doctorDetails = "/doctorDetails";
  static const String booking = "/booking";
  static const String settings = "/settings";
  static const String doctorProfileComplete = "/doctorProfileComplete";
  static const String searchView = "/searchView";
  static const String specializationSearch = "/specializationSearch";
  static const String doctorProfile = "/doctorProfile";
  static const String availableAppointments = "/availableAppointments";
  static const String accountInformation = "/accountInformation";
}

GoRouter router = GoRouter(
  routes: [
    GoRoute(path: Routes.splash, builder: (context, state) => SplashScreen()),
    GoRoute(
      path: Routes.onBoarding,
      builder: (context, state) => OnBoardingScreen(),
    ),
    GoRoute(path: Routes.welcome, builder: (context, state) => WelcomePage()),
    GoRoute(
      path: Routes.login,
      builder: (context, state) => BlocProvider(
        create: (context) => AuthCubit(),
        child: LoginScreen(userTypeEnum: state.extra as UserTypeEnum),
      ),
    ),
    GoRoute(
      path: Routes.register,
      builder: (context, state) => BlocProvider(
        create: (context) => AuthCubit(),
        child: RegisterScreen(userTypeEnum: state.extra as UserTypeEnum),
      ),
    ),
    GoRoute(
      path: Routes.patientMainAppScreen,
      builder: (context, state) => const PatientMainAppScreen(),
    ),
    GoRoute(
      path: Routes.doctorMainAppScreen,
      builder: (context, state) => const DoctorMainAppScreen(),
    ),
    GoRoute(
      path: Routes.doctorDetails,
      builder: (context, state) => const DoctorDetailsView(),
    ),
    GoRoute(
      path: Routes.booking,
      builder: (context, state) =>
          BookingScreen(doctor: state.extra as DoctorModel),
    ),
    GoRoute(
      path: Routes.settings,
      builder: (context, state) => const SettingsView(),
    ),
    GoRoute(
      path: Routes.doctorProfileComplete,
      builder: (context, state) => BlocProvider(
        create: (context) => AuthCubit(),
        child: DoctorProfileCompleteView(
          doctorModel: state.extra as DoctorModel?,
        ),
      ),
    ),
    GoRoute(
      path: Routes.searchView,
      builder: (context, state) => const SearchScreen(),
    ),
    GoRoute(
      path: Routes.specializationSearch,
      builder: (context, state) =>
          SpecializationSearchScreen(specialization: state.extra as String),
    ),
    GoRoute(
      path: Routes.doctorProfile,
      builder: (context, state) =>
          DoctorProfileScreen(doctorModel: state.extra as DoctorModel),
    ),
    GoRoute(
      path: Routes.availableAppointments,
      builder: (context, state) => const MyAppointmentsScreen(),
    ),

    GoRoute(
      path: Routes.accountInformation,
      builder: (context, state) => const AccountInformationScreen(),
    ),
  ],
);

