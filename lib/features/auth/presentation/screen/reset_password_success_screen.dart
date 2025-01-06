import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tourist_app/core/di.dart';
import 'package:tourist_app/core/style/style_extensions.dart';
import 'package:tourist_app/features/common/presentation/widget/custom_snackbar.dart';

class ResetPasswordSuccessScreen extends StatefulHookConsumerWidget {
  const ResetPasswordSuccessScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ResetPasswordSuccessScreenState();
}

class _ResetPasswordSuccessScreenState extends ConsumerState<ResetPasswordSuccessScreen> {

  @override
  Widget build(BuildContext context) {
    final email = ModalRoute.of(context)?.settings.arguments as String;

    return Scaffold(
      appBar: AppBar(
        title: Text("Reset password", style: context.textTitle),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: SizedBox(
            width: double.maxFinite,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Spacer(),
                Image.asset("assets/images/verify_email_image.png", width: 250),
                const SizedBox(height: 20),
                Text(
                  "Please check your inbox and reset your password.",
                  style: context.textSubtitle,
                  textAlign: TextAlign.center,
                ),
                Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Didn't receive an email?", style: context.textSubtitle),
                    TextButton(
                      onPressed: () => _resendResetPassword(email),
                      child: Text(
                        "Resend",
                        style: context.textSubtitleColored,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _resendResetPassword(final String email) {
    ref.read(authNotifier.notifier).resetPassword(email);
    showCustomSnackBar(context, "Email resent!");
  }
}
