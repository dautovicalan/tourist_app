import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tourist_app/core/di.dart';
import 'package:tourist_app/features/auth/domain/usecase/deactivate_profile_use_case.dart';
import 'package:tourist_app/features/auth/domain/usecase/get_current_user_use_case.dart';
import 'package:tourist_app/features/auth/domain/usecase/reset_password_use_case.dart';
import 'package:tourist_app/features/auth/domain/usecase/send_verify_email_use_case.dart';
import 'package:tourist_app/features/auth/domain/usecase/sign_in_use_case.dart';
import 'package:tourist_app/features/auth/domain/usecase/sign_out_use_case.dart';
import 'package:tourist_app/features/auth/domain/usecase/sign_up_use_case.dart';
import 'package:tourist_app/features/auth/presentation/controller/state/auth_state.dart';

class AuthController extends Notifier<AuthState> {
  late final GetCurrentUserUseCase _getCurrentUserUseCase;
  late final SignInUseCase _signInUseCase;
  late final SignUpUseCase _signUpUseCase;
  late final ResetPasswordUseCase _resetPasswordUseCase;
  late final SendVerifyEmailUseCase _sendVerifyEmailUseCase;
  late final SignOutUseCase _signOutUseCase;
  late final DeactivateProfileUseCase _deactivateProfileUseCase;

  @override
  AuthState build() {
    _getCurrentUserUseCase = ref.watch(getCurrentUserUseCaseProvider);
    _signInUseCase = ref.watch(signInUseCaseProvider);
    _signUpUseCase = ref.watch(signUpUseCaseProvider);
    _resetPasswordUseCase = ref.watch(resetPasswordUseCaseProvider);
    _sendVerifyEmailUseCase = ref.watch(sendVerifyEmailUseCaseProvider);
    _signOutUseCase = ref.watch(signOutUseCaseProvider);
    _deactivateProfileUseCase = ref.watch(deactivateProfileUseCaseProvider);
    return UnauthenticatedState();
  }

  User? getCurrentUser() {
    state = LoadingState();

    final user = _getCurrentUserUseCase();
    if (user == null) {
      state = UnauthenticatedState();
      return null;
    }
    if (user.emailVerified == false) {
      state = VerifyEmailState();
    } else {
      state = AuthenticatedState(user);
    }
    return user;
  }


  void signIn(final String email, final String password) async {
    state = LoadingState();

    final result = await _signInUseCase(email, password);

    result.fold(
      (failure) => state = UnauthenticatedState(failure: failure), (user) => {
        if (user != null && user.emailVerified == false){
          state = VerifyEmailState()
        } else {
          state = AuthenticatedState(user!),
        }
      },
    );
  }

  void signUp(final String email, final String password) async {
    state = LoadingState();

    final result = await _signUpUseCase(email, password);

    result.fold(
      (failure) => state = UnauthenticatedState(failure: failure),
      (user) => state = VerifyEmailState(),
    );
  }

  void signOut() async {
    state = LoadingState();

    await _signOutUseCase();

    state = UnauthenticatedState();
  }

  void resetPassword(final String email) async {
    state = LoadingState();

    await _resetPasswordUseCase(email);

    state = ResetPasswordState(email);
  }

  void sendVerifyEmail() async {
    state = LoadingState();

    await _sendVerifyEmailUseCase();
  }

  void deactivateProfile() async {
    state = LoadingState();

    await _deactivateProfileUseCase();

    state = UserDeactivatedState();
  }
}
