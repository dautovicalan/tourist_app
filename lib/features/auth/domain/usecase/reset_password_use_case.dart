import 'package:tourist_app/features/auth/domain/repository/user_repository.dart';

class ResetPasswordUseCase {
  final UserRepository _repository;

  ResetPasswordUseCase(this._repository);

  Future<void> call(final String email) async {
    return _repository.resetPassword(email);
  }
}