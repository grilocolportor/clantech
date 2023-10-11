

import 'package:get_it/get_it.dart';

import '../domain/usecases/user_auth.dart';
import 'user_authentication.dart';

final locatorlogin = GetIt.I;

void setupLogin() {
  
  locatorlogin.registerFactory<IUserAuthentication>(() => UserAuthImpl());
  
}