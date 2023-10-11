import 'package:clan_track/core/config/app_strings.dart';
import 'package:either_dart/either.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../dependency_injection/firebase_auth_interface.dart';
import '../../error/login_error.dart';

class FirebaseAuthImpl implements IFirebaseAuth {
  @override
  Future<void> confirmPasswordReset({String? code, String? password}) {
    // TODO: implement confirmPasswordReset
    throw UnimplementedError();
  }

  @override
  Future<Either<LoginError, User?>> createUserWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return Right(credential.user);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        return Left(LoginError(AppStrings.txtLoginWeakPassword));
      } else if (e.code == 'email-already-in-use') {
        return Left(LoginError(AppStrings.txtEmailAreadyExist));
      }
    } catch (e) {
      print(e);
      return Left(LoginError(e.toString()));
    }
    return Left(LoginError('An unknown error occurred.'));
  }

  @override
  Future<void> sendEmailVerification({required String email}) async {
    await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
  }

  @override
  Future<void> sendPasswordResetEmail({String? email}) {
    // TODO: implement sendPasswordResetEmail
    throw UnimplementedError();
  }

  @override
  Future<User> signInWithEmailAndPassword(
      {required String email, required String password}) {
    // TODO: implement signInWithEmailAndPassword
    throw UnimplementedError();
  } 

  @override
  Future<void> signOut() {
    // TODO: implement signOut
    throw UnimplementedError();
  }

  @override
  Future<void> updateUserProfile(
      {User? user,
      String? urlPhoto,
      String? displayName,
      String? email,
      String? password}) async {
    password ?? await user?.updatePassword(password!);
  }
}
