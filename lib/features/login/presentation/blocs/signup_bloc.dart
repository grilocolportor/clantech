import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:clan_track/core/dependency_injection/local_auth_interface.dart';
import 'package:clan_track/core/dependency_injection/setup.dart';
import 'package:clan_track/core/usercases/login/local_auth.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../../core/entities/login/local_user.dart';
import '../../../../core/error/login_error.dart';
import '../../injections/setup_login.dart';
import '../../injections/user_authentication.dart';

abstract class AuthState {}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthAutenticating extends AuthState {}

class AuthError extends AuthState {
  final String error;

  AuthError(this.error);
}

class AuthAuthenticated extends AuthState {
  final LocalUser user;

  AuthAuthenticated(this.user);
}

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  final injection = locatorlogin.get<IUserAuthentication>();
  final injectionLocalAuth = locator.get<ILocalAuthInterface>();

  // Sign out the user
  Future<void> signOut() async {
    await injection.signOut();
    emit(AuthInitial());
  }

  Future<void> createUserWithEmailAndPassword(
      {required String email, required String password}) async {
    emit(AuthLoading());
    try {
      var result = await injection.createUserWithEmailAndPassword(
          email: email, password: password);

      result.fold((left) {}, (right) => getLocalUser());
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  // Sign in with email and password
  Future<void> signInWithEmailAndPassword(
      {required String email, required String password}) async {
    emit(AuthLoading());
    try {
      var result = await injection.signInWithEmailAndPassword(
          email: email, password: password);

      result.fold((left) => emit(AuthError(left.toString())),
          (right) => getLocalUser());
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  Future<void> getLocalUser() async {
    emit(AuthLoading());
    String user = await injectionLocalAuth.getUser() ?? '';
    
    if (user.isEmpty) {
      emit(AuthInitial());
      return;
    }
    emit(AuthAuthenticated(injectionLocalAuth.deserializableduser(user)));
  }
}
