import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tourist_app/core/app_route.dart';
import 'package:tourist_app/core/di.dart';
import 'package:tourist_app/core/style/style_extensions.dart';
import 'package:tourist_app/features/auth/presentation/controller/state/auth_state.dart';
import 'package:tourist_app/features/auth/presentation/screen/reset_password_success_screen.dart';
import 'package:tourist_app/features/auth/utils/auth_utils.dart';
import 'package:tourist_app/features/common/presentation/widget/custom_primary_button.dart';
import 'package:tourist_app/features/auth/presentation/widget/custom_text_field.dart';
import 'package:tourist_app/features/common/presentation/widget/custom_snackbar.dart';

class ResetPasswordScreen extends StatefulHookConsumerWidget {
  const ResetPasswordScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends ConsumerState<ResetPasswordScreen> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final isLoading = useState(false);
    final emailController = useTextEditingController();


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
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset("assets/images/reset_password_image.png", width: 250),
                  const SizedBox(height: 20),
                  Text(
                    "Please enter your email address to reset your password.",
                    style: context.textSubtitle,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),
                  CustomTextField(
                    label: "Email",
                    controller: emailController,
                    validator: validateEmail,
                  ),
                  const SizedBox(height: 45),
                  CustomPrimaryButton(
                    child: isLoading.value
                        ? CircularProgressIndicator(backgroundColor: Colors.transparent, color: Colors.white)
                        : Text("Reset password", style: context.textButton.copyWith(color: Colors.white)),
                    onPressed: () => _resetPassword(emailController.text),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _resetPassword(final String email) {
    if (_formKey.currentState!.validate()) {
      ref.read(authNotifier.notifier).resetPassword(email);
      Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => ResetPasswordSuccessScreen(),
            settings: RouteSettings(arguments: email),
          )
      );
      showCustomSnackBar(context, "Verification email sent!");
    }
  }
}
