import 'dart:async';
import 'dart:isolate';
import 'dart:math';
import 'dart:ui';

import 'package:background_locator_2/location_dto.dart';
import 'package:clan_track/features/tracker/presentation/background_service/firebase_repository.dart';
import 'package:logger/logger.dart';

import 'file_manager.dart';

class LocationServiceRepository {
  static LocationServiceRepository _instance = LocationServiceRepository._();

  LocationServiceRepository._();

  factory LocationServiceRepository() {
    return _instance;
  }

  static const String isolateName = 'LocatorIsolate';

  int _count = -1;

  double latBefore = 0.0;
  double longBefore = 0.0;

  var logger = Logger();

  FirebaseRepository firebaseRepository = FirebaseRepository();

  Future<void> init(Map<dynamic, dynamic> params) async {
    //TODO change logs
    print("***********Init callback handler");
    if (params.containsKey('countInit')) {
      dynamic tmpCount = params['countInit'];
      if (tmpCount is double) {
        _count = tmpCount.toInt();
      } else if (tmpCount is String) {
        _count = int.parse(tmpCount);
      } else if (tmpCount is int) {
        _count = tmpCount;
      } else {
        _count = -2;
      }
    } else {
      _count = 0;
    }
    print("$_count");
    await setLogLabel("start");
    final SendPort? send = IsolateNameServer.lookupPortByName(isolateName);
    send?.send(null);
  }

  Future<void> dispose() async {
    print("***********Dispose callback handler");
    print("$_count");
    await setLogLabel("end");
    final SendPort? send = IsolateNameServer.lookupPortByName(isolateName);
    send?.send(null);
  }

  Future<void> callback(LocationDto locationDto) async {
    print('$_count location in dart: ${locationDto.toString()}');
    await setLogPosition(_count, locationDto);
    await _isMoved(locationDto);
    final SendPort? send = IsolateNameServer.lookupPortByName(isolateName);
    send?.send(locationDto.toJson());
    _count++;
  }

  Future<void> sendDatatoFirestore(LocationDto locationDto) async {
    await firebaseRepository.sendDataToFirestore(locationDto);
  }

  static Future<void> setLogLabel(String label) async {
    final date = DateTime.now();
    await FileManager.writeToLogFile(
        '------------\n$label: ${formatDateLog(date)}\n------------\n');
  }

  static Future<void> setLogPosition(int count, LocationDto data) async {
    final date = DateTime.now();
    await FileManager.writeToLogFile(
        '$count : ${formatDateLog(date)} --> ${formatLog(data)} --- isMocked: ${data.isMocked}\n');
  }

  static double dp(double val, int places) {
    num mod = pow(10.0, places);
    return ((val * mod).round().toDouble() / mod);
  }

  static String formatDateLog(DateTime date) {
    return "${date.hour}:${date.minute}:${date.second}";
  }

  static String formatLog(LocationDto locationDto) {
    return "${dp(locationDto.latitude, 4)} ${dp(locationDto.longitude, 4)}";
  }

  Future<void> _isMoved(LocationDto locationDto) async {
    if (latBefore != locationDto.latitude ||
        longBefore != locationDto.longitude) {
      longBefore = locationDto.longitude;
      latBefore = locationDto.latitude;
      Future.delayed(const Duration(seconds: 5));
      await sendDatatoFirestore(locationDto);
    }
  }
}
