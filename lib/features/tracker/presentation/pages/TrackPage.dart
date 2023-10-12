import 'dart:async';

import 'package:clan_track/features/tracker/presentation/pages/maps.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart' as loc;
import 'package:permission_handler/permission_handler.dart';

class TrackPage extends StatefulWidget {
  const TrackPage({super.key});

  @override
  State<TrackPage> createState() => _TrackPageState();
}

class _TrackPageState extends State<TrackPage> {
  final location = loc.Location();
  StreamSubscription<loc.LocationData>? _locationSubscription;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Column(
        children: [
          TextButton(
              onPressed: () {
                _getLocation();
              },
              child: Text('Get Location')),
          TextButton(
              onPressed: () {
                _listeningLocation();
              },
              child: Text('Listem Location')),
          TextButton(
              onPressed: () {
                _stopLocation();
              },
              child: Text('Stop Location')),
          Expanded(
            child: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('locations')
                  .snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return ListView.builder(
                    itemCount: snapshot.data?.docs.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(snapshot.data?.docs[index]['name']),
                        subtitle: Row(
                          children: [
                            Text(snapshot.data!.docs[index]['latitude']
                                .toString()),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(snapshot.data!.docs[index]['longitude']
                                .toString())
                          ],
                        ),
                        trailing: IconButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => MapsPage(
                                            userId:
                                                snapshot.data!.docs[index].id,
                                          )));
                            },
                            icon: const Icon(Icons.directions)),
                      );
                    });
              },
            ),
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
          .doc('user 1')
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
      print(onError);
      _locationSubscription?.cancel();
    }).listen((loc.LocationData currentLocation) async {
      await FirebaseFirestore.instance
          .collection('locations')
          .doc('user 1')
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

  _requestPermission() async {
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
