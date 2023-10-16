import 'dart:async';

import 'package:clan_track/features/tracker/presentation/pages/maps.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart' as loc;
import 'package:permission_handler/permission_handler.dart';

import '../../../../core/dependency_injection/local_auth_interface.dart';
import '../../../../core/dependency_injection/setup.dart';
import '../../../../core/entities/login/local_user.dart';

class TrackPage extends StatefulWidget {
  const TrackPage({super.key});

  @override
  State<TrackPage> createState() => _TrackPageState();
}

class _TrackPageState extends State<TrackPage> {
  final location = loc.Location();
  StreamSubscription<loc.LocationData>? _locationSubscription;

  final injectionLocalAuth = locator.get<ILocalAuthInterface>();

  late LocalUser localUser;

  @override
  initState()  {
    super.initState();
    _init();
    
  }

  Future<bool> _init() async {
    await _requestPermission();
    var u = (await injectionLocalAuth.getUser())!;
    localUser = injectionLocalAuth.deserializableduser(u);
    await _getLocation();
    return true;
  }

  @override
  Widget build(BuildContext context) {
    _listeningLocation();
    return Scaffold(
        body: SafeArea(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // TextButton(
          //     onPressed: () {
          //       _getLocation();
          //     },
          //     child: Text('Get Location')),
          // TextButton(
          //     onPressed: () {
          //       _listeningLocation();
          //     },
          //     child: Text('Listem Location')),
          // TextButton(
          //     onPressed: () {
          //       _stopLocation();
          //     },
          //     child: Text('Stop Location')),
          FutureBuilder(
            future: _init(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Expanded(
                    child: MapsPage(
                  userId: localUser.token,
                ));
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          )
        ],
      ),
    ));
  }

  _getLocation() async {
    try {
      final loc.LocationData _locationResult = await location.getLocation();
      await FirebaseFirestore.instance
          .collection('locations')
          .doc(localUser.token)
          .set({
        'name': 'Location 1',
        'latitude': _locationResult.latitude,
        'longitude': _locationResult.longitude
      }, SetOptions(merge: true));
    } catch (e) {
      print(e);
    }
  }

  Future<void> _listeningLocation() async {
    _locationSubscription = location.onLocationChanged.handleError((onError) {
      _locationSubscription?.cancel();
    }).listen((loc.LocationData currentLocation) async {
      await FirebaseFirestore.instance
          .collection('locations')
          .doc(localUser.token)
          .set({
        'name': 'Location 1',
        'latitude': currentLocation.latitude,
        'longitude': currentLocation.longitude
      }, SetOptions(merge: true));
    });
  }

  _stopLocation() {
    _locationSubscription?.cancel();
    setState(() {
      _locationSubscription = null;
    });
  }

  Future<void> _requestPermission() async {
    var status = await Permission.location.request();
    if (status.isGranted) {
      print('denied');
    } else if (status.isDenied) {
      print('denied');
    } else if (status.isPermanentlyDenied) {
      print('permanently denied');
      openAppSettings();
    }
  }
}
