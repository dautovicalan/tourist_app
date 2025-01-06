import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tourist_app/core/app_route.dart';
import 'package:tourist_app/core/di.dart';
import 'package:tourist_app/core/style/style_extensions.dart';
import 'package:tourist_app/features/auth/presentation/controller/state/auth_state.dart';
import 'package:tourist_app/features/auth/utils/auth_utils.dart';
import 'package:tourist_app/features/common/presentation/widget/custom_primary_button.dart';
import 'package:tourist_app/features/auth/presentation/widget/custom_text_field.dart';

class SignUpScreen extends StatefulHookConsumerWidget {
  const SignUpScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends ConsumerState<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authNotifier);
    final isLoading = useState(false);

    final emailController = useTextEditingController();
    final passwordController = useTextEditingController();
    final confirmPasswordController = useTextEditingController();

    useValueChanged<AuthState, void>(authState, (_, newValue) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        switch (authState) {
          case AuthenticatedState():
            isLoading.value = false;
            Navigator.of(context).pushReplacementNamed(AppRoute.home);
          case LoadingState():
            isLoading.value = true;
          case UnauthenticatedState():
            isLoading.value = false;
          case VerifyEmailState():
            isLoading.value = false;
            Navigator.of(context).pushReplacementNamed(AppRoute.signIn);
            Navigator.of(context).pushNamed(AppRoute.verifyEmail);
          case UserDeactivatedState():
            isLoading.value = false;
            final snackBar = SnackBar(content: Text("Your account has been deactivated!"));
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          case ResetPasswordState():
            isLoading.value = false;
            final snackBar = SnackBar(content: Text("Verification email sent."));
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }
      });
    });

    return Scaffold(
      appBar: AppBar(
        title: Text("Register", style: context.textTitle),
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
                  Image.asset("assets/images/sign_in_image.png", width: 250),
                  const SizedBox(height: 20),
                  Text(
                    "Please create an account to continue.",
                    style: context.textSubtitle,
                  ),
                  const SizedBox(height: 20),
                  CustomTextField(
                    label: "Email",
                    controller: emailController,
                    validator: validateEmail,
                  ),
                  const SizedBox(height: 20),
                  CustomTextField(
                    label: "Password",
                    controller: passwordController,
                    validator: validatePassword,
                    isPassword: true,
                  ),
                  const SizedBox(height: 20),
                  CustomTextField(
                    label: "Confirm password",
                    controller: confirmPasswordController,
                    validator: (value) => validateConfirmPassword(passwordController.text, value),
                    isPassword: true,
                  ),
                  const SizedBox(height: 45),
                  CustomPrimaryButton(
                    child: isLoading.value
                        ? CircularProgressIndicator(backgroundColor: Colors.transparent, color: Colors.white)
                        : Text("Sign up", style: context.textButton.copyWith(color: Colors.white)),
                    onPressed: () => _signUp(emailController.text, passwordController.text),
                  ),
                  const Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Already have an account? ",
                        style: context.textSubtitle,
                      ),
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: Text("Sign in", style: context.textSubtitleColored,),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _signUp(final String email, final String password) {
    if (_formKey.currentState!.validate()) {
      ref.read(authNotifier.notifier).signUp(email, password);
    }
  }
}
