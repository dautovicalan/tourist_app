import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lottie/lottie.dart';
import 'package:tourist_app/core/app_route.dart';
import 'package:tourist_app/core/di.dart';
import 'package:tourist_app/features/auth/presentation/controller/state/auth_state.dart';

class SplashScreen extends StatefulHookConsumerWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {

  @override
  Widget build(BuildContext context) {
    _redirectToNextScreen(context);
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          width: double.maxFinite,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/images/camping_image.png', width: 300),
              SizedBox(height: 40),
              Lottie.asset('assets/animations/loading_dots.json', height: 100),
            ],
          ),
        ),
      ),
    );
  }

  void _redirectToNextScreen(final BuildContext context) {
    Future.delayed(const Duration(milliseconds: 1500), ()
    {
      final currentUser = ref.read(authNotifier.notifier).getCurrentUser();

      if (currentUser == null || currentUser.emailVerified == false) {
        Navigator.of(context).pushReplacementNamed(AppRoute.signIn);
      } else {
        Navigator.of(context).pushReplacementNamed(AppRoute.home);
      }
    });
  }
}
