import 'dart:async';

import 'package:flutter/services.dart';

class Vungle {
  static const MethodChannel _channel =
      const MethodChannel('vungle');

  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }
}
