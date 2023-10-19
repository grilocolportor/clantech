import 'package:background_locator_2/location_dto.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:logger/logger.dart';

import '../../../../core/entities/login/local_user.dart';
import '../../../../core/usercases/login/local_auth.dart';
import '../../../../firebase_options.dart';

class FirebaseRepository {
  //final injectionLocalAuth = locator.get<ILocalAuthInterface>();

  var logger = Logger();

  LocalAuthImpl injectionLocalAuth = LocalAuthImpl();

  late LocalUser localUser;

  FirebaseRepository() {
    _init();
  }

  void _init() async {
     await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  }

  Future<void> sendDataToFirestore(LocationDto locationDto) async {
    try {
      var u = (await injectionLocalAuth.getUser());
      localUser = injectionLocalAuth.deserializableduser(u);
      await FirebaseFirestore.instance
          .collection('locations')
          .doc(localUser.token)
          .set({
        'name': localUser.displayName,
        'latitude': locationDto.latitude,
        'longitude': locationDto.longitude
      }, SetOptions(merge: true));
      logger.d(
          'Envoiu para o firebase  ${localUser.displayName}: lat: ${locationDto.latitude}, lon: ${locationDto.longitude}');
    } catch (e) {
      logger.e(e);
    }
  }
}
