import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tourist_app/core/app_route.dart';
import 'package:tourist_app/core/di.dart';
import 'package:tourist_app/core/style/style_extensions.dart';
import 'package:tourist_app/features/auth/presentation/controller/state/auth_state.dart';
import 'package:tourist_app/features/auth/presentation/screen/reset_password_screen.dart';
import 'package:tourist_app/features/auth/presentation/screen/sign_up_screen.dart';
import 'package:tourist_app/features/auth/utils/auth_utils.dart';
import 'package:tourist_app/features/common/presentation/widget/custom_primary_button.dart';
import 'package:tourist_app/features/auth/presentation/widget/custom_text_field.dart';
import 'package:tourist_app/features/common/presentation/widget/custom_snackbar.dart';

class SignInScreen extends StatefulHookConsumerWidget {
  const SignInScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SignInScreenState();
}

class _SignInScreenState extends ConsumerState<SignInScreen> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authNotifier);
    final isLoading = useState(false);

    final emailController = useTextEditingController();
    final passwordController = useTextEditingController();

    useValueChanged<AuthState, void>(authState, (_, newValue) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        switch (authState) {
          case AuthenticatedState():
            isLoading.value = false;
            Navigator.of(context).pushReplacementNamed(AppRoute.home);
          case LoadingState():
            isLoading.value = true;
          case UnauthenticatedState(failure: var failure):
            isLoading.value = false;
            showCustomSnackBar(context, failure!.message);
          case VerifyEmailState():
            isLoading.value = false;
            Navigator.of(context).pushNamed(AppRoute.verifyEmail);
          case UserDeactivatedState():
            isLoading.value = false;
          case ResetPasswordState():
            isLoading.value = false;
        }
      });
    });

    return Scaffold(
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
                    "Please sign in to your account.",
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
                  const SizedBox(height: 5),
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => ResetPasswordScreen())),
                      child: Text(
                        "Forgot password?",
                        style: context.textSubtitle,
                        textAlign: TextAlign.end,
                      ),
                    ),
                  ),
                  const SizedBox(height: 45),
                  CustomPrimaryButton(
                    child: isLoading.value
                        ? CircularProgressIndicator(backgroundColor: Colors.transparent, color: Colors.white)
                        : Text("Sign in", style: context.textButton.copyWith(color: Colors.white)),
                    onPressed: () => _signIn(emailController.text, passwordController.text),
                  ),
                  const Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Don't have an account?", style: context.textSubtitle),
                      TextButton(
                        onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => SignUpScreen())),
                        child: Text(
                            "Sign up",
                            style: context.textSubtitleColored,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _signIn(final String email, final String password) {
    if (_formKey.currentState!.validate()) {
      ref.read(authNotifier.notifier).signIn(email, password);
    }
  }
}
