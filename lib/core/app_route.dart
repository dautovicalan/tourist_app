import 'package:flutter/material.dart';
import 'package:tourist_app/features/auth/presentation/screen/reset_password_screen.dart';
import 'package:tourist_app/features/auth/presentation/screen/reset_password_success_screen.dart';
import 'package:tourist_app/features/auth/presentation/screen/sign_in_screen.dart';
import 'package:tourist_app/features/auth/presentation/screen/sign_up_screen.dart';
import 'package:tourist_app/features/auth/presentation/screen/verify_email_screen.dart';
import 'package:tourist_app/features/common/presentation/screen/home_screen.dart';
import 'package:tourist_app/features/initialisation/presentation/screen/splash_screen.dart';
import 'package:tourist_app/features/locations/presentation/location_detail/screen/location_detail_screen.dart';

class AppRoute {
  AppRoute._();

  static const splash = '/';
  static const signIn = '/signIn';
  static const signUp = '/signUp';
  static const resetPassword = '/resetPassword';
  static const resetPasswordSuccess = '/resetPasswordSuccess';
  static const verifyEmail = '/verifyEmail';
  static const home = '/home';
  static const details = '/details';

  static Route<dynamic> generateRoute(final RouteSettings settings) {
    switch (settings.name) {
      case splash:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case signIn:
        return MaterialPageRoute(builder: (_) => const SignInScreen());
      case signUp:
        return MaterialPageRoute(builder: (_) => const SignUpScreen());
      case resetPassword:
        return MaterialPageRoute(builder: (_) => const ResetPasswordScreen());
      case resetPasswordSuccess:
        return MaterialPageRoute(builder: (_) => const ResetPasswordSuccessScreen());
      case verifyEmail:
        return MaterialPageRoute(builder: (_) => const VerifyEmailScreen());
      case home:
        return MaterialPageRoute(builder: (_) => const HomeScreen());
      case details:
        return MaterialPageRoute(builder: (_) => LocationDetailScreen());
      default:
        throw Exception("Route not found...");
    }
  }
}