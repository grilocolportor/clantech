import 'package:clan_track/core/components/form_validator.dart';
import 'package:clan_track/core/dependency_injection/local_auth_interface.dart';
import 'package:clan_track/core/entities/login/local_user.dart';
import 'package:clan_track/core/error/login_error.dart';
import 'package:clan_track/core/error/validator_form_error.dart';
import 'package:clan_track/core/usercases/login/local_auth.dart';

import 'package:either_dart/src/either.dart';

import 'package:firebase_auth/firebase_auth.dart';

import '../../../../core/dependency_injection/firebase_auth_interface.dart';
import '../../../../core/dependency_injection/setup.dart';
import '../../injections/user_authentication.dart';

class UserAuthImpl implements IUserAuthentication {
  var injection = locator.get<IFirebaseAuth>();
  var injectionLocalAuth = locator.get<ILocalAuthInterface>();

  @override
  Future<Either<Exception, User?>> createUserWithEmailAndPassword(
      {required String email, required String password}) async {
    try {
      if (FormValidator.validateEmail(email).isEmpty) {
        var result = await injection.createUserWithEmailAndPassword(
            email: email, password: password);
        _saveUser(result.right!);    
        return Right(result.right);
      }

      return Left(ValidatorFormError('Email inválido'));
    } catch (e) {
      return Left(LoginError(e.toString()));
    }
  }

  @override
  Future<void> signOut() async {
    print('Chegou aqui');
  }

  @override
  Future<Either<ValidatorFormError, User?>> signInWithEmailAndPassword(
      {required String email, required String password}) async {
    try {
      if (FormValidator.validateEmail(email).isEmpty) {
        var result = await injection.signInWithEmailAndPassword(
            email: email, password: password);
        _saveUser(result.right!);
        return Right(result.right);
      }

      return Left(ValidatorFormError('Email inválido'));
    } catch (e) {
      return Left(ValidatorFormError(e.toString()));
    }
  }

  _saveUser(User user) async {
    String userSerializabled = injectionLocalAuth.serializableduser(user);
    await injectionLocalAuth.saveUser(user: userSerializabled);
  }

}
