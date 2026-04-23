import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:se7ety/core/constants/user_type_enum.dart';
import 'package:se7ety/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:se7ety/features/auth/presentation/screens/authentication/login_screen.dart';
import 'package:se7ety/features/auth/presentation/screens/authentication/register_screen.dart';
import 'package:se7ety/features/main/main_screen.dart';
import 'package:se7ety/features/on_boarding_screens/screens/on_boarding_screen.dart';
import 'package:se7ety/features/on_boarding_screens/screens/welcome_screen.dart';
import 'package:se7ety/features/doctor_profile/presentation/screen/doctor_profile_complete_view.dart';
import 'package:se7ety/features/booking/presentation/screens/booking_view.dart';
import 'package:se7ety/features/doctor_details/presentation/screens/doctor_details_view.dart';
import 'package:se7ety/features/settings/presentation/screens/settings_view.dart';
import 'package:se7ety/features/splash/splash_screen.dart';
import 'package:se7ety/features/search/presentation/screens/search_view.dart';

class Routes {
  static const String splash = "/";
  static const String login = "/login";
  static const String register = "/register";
  static const String welcome = "/welcome";
  static const String onBoarding = "/onBoarding";
  static const String navRoot = "/navRoot";
  static const String doctorDetails = "/doctorDetails";
  static const String booking = "/booking";
  static const String settings = "/settings";
  static const String doctorProfileComplete = "/doctorProfileComplete";
  static const String searchView = "/searchView";
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
      path: Routes.navRoot,
      builder: (context, state) => const MainScreen(),
    ),
    GoRoute(
      path: Routes.doctorDetails,
      builder: (context, state) => const DoctorDetailsView(),
    ),
    GoRoute(
      path: Routes.booking,
      builder: (context, state) => const BookingView(),
    ),
    GoRoute(
      path: Routes.settings,
      builder: (context, state) => const SettingsView(),
    ),
    GoRoute(
      path: Routes.doctorProfileComplete,
      builder: (context, state) => const DoctorProfileCompleteView(),
    ),
    GoRoute(
      path: Routes.searchView,
      builder: (context, state) => const SearchView(),
    ),
  ],
);
