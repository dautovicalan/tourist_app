import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tourist_app/core/di.dart';
import 'package:tourist_app/core/style/style_extensions.dart';
import 'package:tourist_app/features/common/presentation/widget/custom_snackbar.dart';

class VerifyEmailScreen extends StatefulHookConsumerWidget {
  const VerifyEmailScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _VerifyEmailScreenState();
}

class _VerifyEmailScreenState extends ConsumerState<VerifyEmailScreen> {

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text("Verify email", style: context.textTitle),
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
                    "Please check your inbox and verify your email address.",
                    style: context.textSubtitle,
                    textAlign: TextAlign.center,
                  ),
                  Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Didn't receive an email?", style: context.textSubtitle),
                      TextButton(
                        onPressed: () => _resendVerifyEmail(),
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

  void _resendVerifyEmail() {
    ref.read(authNotifier.notifier).sendVerifyEmail();
    showCustomSnackBar(context, "Email resent!");
  }
}
