import 'dart:convert';

import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter_p2p/flutter_p2p.dart';
import 'package:flutter_p2p/gen/protos/protos.pb.dart';

Future<bool> _checkPermission() async {
  if (!await FlutterP2p.isLocationPermissionGranted()) {
    await FlutterP2p.requestLocationPermission();
    return false;
  }
  return true;
}