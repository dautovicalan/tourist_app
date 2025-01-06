import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tourist_app/core/app_route.dart';
import 'package:tourist_app/core/di.dart';
import 'package:tourist_app/core/style/style_extensions.dart';
import 'package:tourist_app/features/auth/presentation/controller/state/auth_state.dart';
import 'package:tourist_app/features/common/presentation/widget/custom_primary_button.dart';
import 'package:tourist_app/features/common/presentation/widget/custom_secondary_button.dart';
import 'package:tourist_app/features/common/presentation/widget/custom_snackbar.dart';
import 'package:tourist_app/features/profile/presentation/profile_detail/widget/gradient_text.dart';


class ProfileScreen extends StatefulHookConsumerWidget {
  const ProfileScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ProfileScreen();
}


class _ProfileScreen extends ConsumerState<ProfileScreen> {

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authNotifier);

    String? email;
    if (authState is AuthenticatedState) {
      email = authState.user.email;
    }

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text("My profile", style: context.textTitle, textAlign: TextAlign.left),
              Image.asset("assets/images/user_picture_placeholder.png", width: 250),
              const SizedBox(height: 10),
              Text("Alan Dautović", style: context.textHeading,),
              Text(email ?? "Email not available", style: context.textSubtitle),
              const SizedBox(height: 200),
              CustomSecondaryButton(
                onPressed: () => _deactivateProfile(),
                child: GradientText(
                    "Deactivate",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.bold
                    ),
                    gradient: LinearGradient(
                        colors: [context.colorGradientBegin, context.colorGradientEnd]
                    ),
                ),
              ),
              const SizedBox(height: 20),
              CustomPrimaryButton(
                onPressed: () => _logout(),
                child: Text("Logout", style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
              )
            ],
          ),
        ),
      ),
    );
  }

  void _deactivateProfile() {
    final authController = ref.read(authNotifier.notifier);
    authController.deactivateProfile();
    Navigator.of(context).pushReplacementNamed(AppRoute.signIn);
    showCustomSnackBar(context, "Your account has been deactivated.");
  }

  void _logout() {
    final authController = ref.read(authNotifier.notifier);
    authController.signOut();
    Navigator.of(context).pushReplacementNamed(AppRoute.signIn);
    showCustomSnackBar(context, "You have been logged out.");
  }
}