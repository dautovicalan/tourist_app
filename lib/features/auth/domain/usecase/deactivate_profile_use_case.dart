import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:tourist_app/features/auth/domain/repository/user_repository.dart';
import 'package:tourist_app/core/error/failure.dart';

class DeactivateProfileUseCase {
  final UserRepository _repository;

  DeactivateProfileUseCase(this._repository);

  Future<void> call() async {
    return _repository.deactivateProfile();
  }
}