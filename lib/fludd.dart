import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart' show required;
import 'package:flutter/services.dart';

import 'models/dd_response.dart';

//class Fludd {
//  static const MethodChannel _channel =
//      const MethodChannel('fludd');
//
//  static Future<String> get platformVersion async {
//    final String version = await _channel.invokeMethod('getPlatformVersion');
//    return version;
//  }
//}
class Fludd {
  static final MethodChannel _channel = const MethodChannel('fludd')..setMethodCallHandler(_handler);

  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }

  Fludd._();

  static StreamController<DDAuthResponse> _responseAuthController = StreamController.broadcast();

  static Stream<DDAuthResponse> get responseFromAuth => _responseAuthController.stream;

  static Future<dynamic> _handler(MethodCall call) {
    switch (call.method) {
      case 'onAuthResponse':
        _responseAuthController.add(DDAuthResponse.fromMap(call.arguments));
        break;
    }
    return Future.value(true);
  }

  static Future<bool> registerApp({@required String appId}) {
    return _channel.invokeMethod("registerApp", {"appId": appId});
  }

  static Future unregisterApp() {
    return _channel.invokeMethod("unregisterApp");
  }

  static Future sendAuth({String bundleId}) {
    if (Platform.isIOS) {
      return _channel.invokeMethod("sendAuth", {"bundleId": bundleId});
    } else {
      return _channel.invokeMethod("sendAuth");
    }
  }

  static Future<bool> isDingDingInstalled() {
    return _channel.invokeMethod("isDingDingInstalled");
  }

  static closeStream() {
    _responseAuthController?.close();
  }
}
