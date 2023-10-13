

import 'package:clan_track/core/dependency_injection/local_auth_interface.dart';
import 'package:clan_track/core/usercases/login/local_auth.dart';
import 'package:get_it/get_it.dart';

import '../../features/login/injections/setup_login.dart';
import '../usercases/login/firebase_auth.dart';
import 'firebase_auth_interface.dart';

final locator = GetIt.I;

void setupLocator() {
  
  setupLogin();

  locator.registerFactory<IFirebaseAuth>(() => FirebaseAuthImpl());
   locator.registerFactory<ILocalAuthInterface>(() => LocalAuth());
}
