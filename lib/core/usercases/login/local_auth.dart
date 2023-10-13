import 'dart:convert';

import 'package:clan_track/core/dependency_injection/local_auth_interface.dart';
import 'package:clan_track/core/entities/login/local_user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalAuth implements ILocalAuthInterface {
  @override
  Future<String?> getUser() async {
    return await SharedPreferences.getInstance()
        .then((value) => value.getString('user') ?? '');
  }

  @override
  Future<bool> saveUser({required String user}) async {
    return await SharedPreferences.getInstance()
        .then((value) => value.setString('user', user));
  }

  @override
  LocalUser deserializableduser(String user) {
    return  LocalUser.fromJson(jsonDecode(user));
  }

  @override
  String serializableduser(User user) {
    LocalUser localUser = LocalUser(
        email: user.email ?? ' ',
        token: user.uid,
        displayName: user.displayName ?? ' ',
        urlPhoto: user.photoURL ?? ' ');
    return localUser.toJson().toString();
  }
}
