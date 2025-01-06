import 'package:firebase_auth/firebase_auth.dart';

class UserApi {
  final FirebaseAuth instance;

  const UserApi(this.instance);

  User? getCurrentUser() {
    return instance.currentUser;
  }

  Future<User?> signIn(final String email, final String password) async {
    final credentials = await instance.signInWithEmailAndPassword(email: email, password: password);
    return credentials.user;
  }

  Future<User?> signUp(final String email, final String password) async {
    final credentials = await instance.createUserWithEmailAndPassword(email: email, password: password);
    return credentials.user;
  }

  Future<void> signOut() async {
    await instance.signOut();
  }

  Future<void> resetPassword(final String email) async {
    await instance.sendPasswordResetEmail(email: email);
  }

  Future<void> sendVerifyEmail() async {
    final user = instance.currentUser;
    await user?.sendEmailVerification();
  }

  Future<void> deactivateProfile() async {
    final user = instance.currentUser;
    await user?.delete();
  }
}