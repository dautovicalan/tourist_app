import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:tourist_app/core/error/failure.dart';

abstract interface class UserRepository {
  User? getCurrentUser();
  Future<Either<Failure, User?>> signIn(String email, String password);
  Future<Either<Failure, User?>> signUp(String email, String password);
  Future<void> signOut();
  Future<void> resetPassword(String email);
  Future<void> sendVerifyEmail();
  Future<void> deactivateProfile();
}