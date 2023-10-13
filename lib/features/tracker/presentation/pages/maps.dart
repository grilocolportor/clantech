import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart' as loc;

class MapsPage extends StatefulWidget {
  final String userId;
  const MapsPage({super.key, required this.userId});

  @override
  State<MapsPage> createState() => _MapsPageState();
}

class _MapsPageState extends State<MapsPage> {
  final location = loc.Location();
  late GoogleMapController _controller;
  bool _added = false;
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection('locations').snapshots(),
      builder: (context, snapshot) {
        if(_added){
          myMap(snapshot);
        }
        if (!snapshot.hasData) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        return GoogleMap(
          mapType: MapType.normal,
          initialCameraPosition: CameraPosition(
              target: LatLng(
                  snapshot.data!.docs.singleWhere(
                      (element) => element.id == widget.userId)['latitude'],
                  snapshot.data!.docs.singleWhere(
                      (element) => element.id == widget.userId)['longitude']),
              zoom: 15),
          onMapCreated: (controller) async {
            setState(() {
              _controller = controller;
              _added = true;
            });
          },
          markers: {
            Marker(
                icon: BitmapDescriptor.defaultMarkerWithHue(
                    BitmapDescriptor.hueMagenta),
                markerId: const MarkerId('id'),
                position: LatLng(
                    snapshot.data!.docs.singleWhere(
                        (element) => element.id == widget.userId)['latitude'],
                    snapshot.data!.docs.singleWhere(
                        (element) => element.id == widget.userId)['longitude']),
                infoWindow: InfoWindow(title: 'Marker 1'))
          },
        );
      },
    );
  }

  Future<void> myMap(AsyncSnapshot<QuerySnapshot<Object?>> snapshot) async {
    await _controller.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(
            target: LatLng(
                snapshot.data!.docs.singleWhere(
                    (element) => element.id == widget.userId)['latitude'],
                snapshot.data!.docs.singleWhere(
                    (element) => element.id == widget.userId)['longitude']),
            zoom: 15)));
  }
}
