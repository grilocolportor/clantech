import 'package:either_dart/either.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../core/error/login_error.dart';

abstract class IUserAuthentication {
   Future<Either<LoginError, User?>> signInWithEmailAndPassword(
      {required String email, required String password});
  Future<void> signOut();
  Future<Either<Exception, User?>> createUserWithEmailAndPassword({
   required  String email,
    required String password,
  });
}