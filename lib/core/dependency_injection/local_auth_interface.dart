import 'package:firebase_auth/firebase_auth.dart';

import '../entities/login/local_user.dart';

abstract class ILocalAuthInterface {
  Future<bool> saveUser({required String user});
  Future<String?> getUser();
  String serializableduser(User user);
  LocalUser deserializableduser(String user);
}
