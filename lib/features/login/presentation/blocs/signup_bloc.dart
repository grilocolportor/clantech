import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../injections/setup_login.dart';
import '../../injections/user_authentication.dart';

abstract class AuthState {}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthError extends AuthState {
  final String error;

  AuthError(this.error);
}

class AuthAuthenticated extends AuthState {
  final User user;

  AuthAuthenticated(this.user);
}

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  final injection = locatorlogin.get<IUserAuthentication>();

  // Register a new user with email and password
  Future<void> registerWithEmailAndPassword(
      String email, String password) async {
    emit(AuthLoading());
    try {
      var result = await injection.createUserWithEmailAndPassword(
          email: email, password: password);

      result.fold((left) => emit(AuthError(
       left.toString()
      )), (right) => emit(AuthAuthenticated(right!)));

      
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  // Sign in with email and password
  Future<void> signInWithEmailAndPassword(String email, String password) async {
    emit(AuthLoading());
    try {
    var result = await injection.signInWithEmailAndPassword(
          email: email, password: password);

      result.fold((left) => emit(AuthError(
       left.toString()
      )), (right) => emit(AuthAuthenticated(right!)));

    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  // Sign out the user
  Future<void> signOut() async {
    await injection.signOut();
    emit(AuthInitial());
  }
}
