import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:tourist_app/features/auth/domain/repository/user_repository.dart';
import 'package:tourist_app/core/error/failure.dart';

class SignUpUseCase {
  final UserRepository _repository;

  SignUpUseCase(this._repository);

  Future<Either<Failure, User?>> call(final String email, final String password) async {
    final result = await _repository.signUp(email, password);
    return result;
  }
}