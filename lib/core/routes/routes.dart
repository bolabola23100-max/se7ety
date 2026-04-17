import 'package:go_router/go_router.dart';
import 'package:se7ety/core/constants/user_type_enum.dart';
import 'package:se7ety/features/auth/presentation/screens/authentication/login_screen.dart';
import 'package:se7ety/features/auth/presentation/screens/authentication/register_screen.dart';
import 'package:se7ety/features/on_boarding_screens/screens/on_boarding_screen.dart';
import 'package:se7ety/features/on_boarding_screens/screens/welcome_screen.dart';
import 'package:se7ety/features/splash/splash_screen.dart';

class Routes {
  static const String splash = "/";
  static const String login = "/login";
  static const String register = "/register";
  static const String welcome = "/welcome";
  static const String onBoarding = "/onBoarding";
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
      builder: (context, state) =>
          LoginScreen(userTypeEnum: state.extra as UserTypeEnum),
    ),
    GoRoute(
      path: Routes.register,
      builder: (context, state) =>
          RegisterScreen(userTypeEnum: state.extra as UserTypeEnum),
    ),
  ],
);
