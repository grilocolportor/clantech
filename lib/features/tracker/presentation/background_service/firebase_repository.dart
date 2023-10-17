import 'package:background_locator_2/location_dto.dart';
import 'package:clan_track/core/dependency_injection/local_auth_interface.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../../core/dependency_injection/setup.dart';
import '../../../../core/entities/login/local_user.dart';

class FirebaseRepository {
  final injectionLocalAuth = locator.get<ILocalAuthInterface>();

  late LocalUser localUser;

  FirebaseRepository() {
    _init();
  }

  void _init() async {
    var u = (await injectionLocalAuth.getUser())!;
    localUser = injectionLocalAuth.deserializableduser(u);
  }

  Future<void> sendDataToFirestore(LocationDto locationDto) async{
    try{
      await FirebaseFirestore.instance
          .collection('locations')
          .doc(localUser.token)
          .set({
        'name': localUser.displayName,
        'latitude': locationDto.latitude,
        'longitude': locationDto.longitude
      }, SetOptions(merge: true));
    } catch (e) {
      print(e);
    }
  }
}
