import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:tourist_app/features/auth/domain/repository/user_repository.dart';
import 'package:tourist_app/core/error/failure.dart';

class GetCurrentUserUseCase {
  final UserRepository _repository;

  GetCurrentUserUseCase(this._repository);

  User? call() {
    final user = _repository.getCurrentUser();
    if (user == null) {
      return null;
    }
    return _repository.getCurrentUser();
  }
}