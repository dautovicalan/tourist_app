import 'package:tourist_app/features/auth/domain/repository/user_repository.dart';

class SignOutUseCase {
  final UserRepository _repository;

  SignOutUseCase(this._repository);

  Future<void> call() async {
    return _repository.signOut();
  }

}