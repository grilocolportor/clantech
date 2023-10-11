import 'package:clan_track/core/entities/login/auth.dart';

import 'package:clan_track/core/error/login_error.dart';

import 'package:either_dart/src/either.dart';

import 'package:firebase_auth/firebase_auth.dart';

import '../../../../core/dependency_injection/firebase_auth_interface.dart';
import '../../../../core/dependency_injection/setup.dart';
import '../../injections/user_authentication.dart';

class UserAuthImpl implements IUserAuthentication{

 var injection = locator.get<IFirebaseAuth>();


  @override
  Future<Either<LoginError, User?>> createUserWithEmailAndPassword({required String email, required String password}) async {
    return await injection.createUserWithEmailAndPassword(email: email, password: password);
  }
  

  @override
  Future<void> signOut() {
    // TODO: implement signOut
    throw UnimplementedError();
  }
  
  @override
  Future<Either<LoginError, User?>> signInWithEmailAndPassword({required String email, required String password}) {
    // TODO: implement signInWithEmailAndPassword
    throw UnimplementedError();
  }

}