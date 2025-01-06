import 'package:tourist_app/features/auth/domain/repository/user_repository.dart';

class SendVerifyEmailUseCase {
  final UserRepository _repository;

  SendVerifyEmailUseCase(this._repository);

  Future<void> call() async {
    return _repository.sendVerifyEmail();
  }
}