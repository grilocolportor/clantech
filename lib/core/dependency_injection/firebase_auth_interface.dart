import 'package:either_dart/either.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../error/login_error.dart';

abstract class IFirebaseAuth {
  Future<User> signInWithEmailAndPassword(
      {required String email, required String password});
  Future<void> signOut();
  Future<Either<LoginError, User?>> createUserWithEmailAndPassword({
   required  String email,
    required String password,
  });
  Future<void> sendPasswordResetEmail({String email});
  Future<void> confirmPasswordReset({String code, String password});
  Future<void> sendEmailVerification({required String email});
  Future<void> updateUserProfile({User? user, String? urlPhoto, String? displayName, String? email, String? password});
}
