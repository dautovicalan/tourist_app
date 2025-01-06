import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:tourist_app/core/error/failure.dart';
import 'package:tourist_app/features/auth/data/api/user_api.dart';
import 'package:tourist_app/features/auth/domain/repository/user_repository.dart';

class UserRepositoryImpl implements UserRepository {
  final UserApi _userApi;

  UserRepositoryImpl(this._userApi);

  @override
  User? getCurrentUser() {
    final user = _userApi.getCurrentUser();
    if (user == null) {
      return null;
    }
    return user;

  }

  @override
  Future<Either<Failure, User?>> signIn(String email, String password) async {
    try {
      final user = await _userApi.signIn(email, password);
      if (user != null && !user.emailVerified) {
        await _userApi.sendVerifyEmail();
      }
      return Right(user);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return Left(FirebaseAuthFailure("Invalid email or password."));
      }
      return Left(FirebaseAuthFailure("Authentication error. Please try again."));
    } catch (e) {
      return Left(NetworkFailure("Network error. Please try again."));
    }
  }

  @override
  Future<Either<Failure, User?>> signUp(String email, String password) async {
    try {
      final user = await _userApi.signUp(email, password);
      await _userApi.sendVerifyEmail();
      return Right(user);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        return Left(FirebaseAuthFailure("Email already in use."));
      }
      return Left(FirebaseAuthFailure("Authentication error. Please try again."));
    } catch (e) {
      return Left(NetworkFailure("Network error. Please try again."));
    }
  }

  @override
  Future<void> signOut() async {
    await _userApi.signOut();
  }

  @override
  Future<void> resetPassword(String email) async {
    await _userApi.resetPassword(email);
  }

  @override
  Future<void> sendVerifyEmail() async {
    await _userApi.sendVerifyEmail();
  }

  @override
  Future<void> deactivateProfile() async {
    await _userApi.deactivateProfile();
  }

}
