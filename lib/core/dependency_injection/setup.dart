import 'package:get_it/get_it.dart';

import '../../features/login/injections/setup_login.dart';
import '../usercases/login/firebase_auth.dart';
import 'firebase_auth_interface.dart';

final locator = GetIt.I;

void setupLocator() {
  
  setupLogin();

  locator.registerFactory<IFirebaseAuth>(() => FirebaseAuthImpl());
}
