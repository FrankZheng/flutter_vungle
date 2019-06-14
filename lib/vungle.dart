import 'dart:async';

import 'package:flutter/services.dart';

enum UserConsentStatus {
  Accepted,
  Denied,
}

typedef void OnInitilizeListener();

typedef void OnAdPlayableListener(String placementId, bool playable);

typedef void OnAdStartedListener(String placementId);

typedef void OnAdFinishedListener(String placementId, bool isCTAClicked, bool isCompletedView);

class Vungle {
  static const MethodChannel _channel =
      const MethodChannel('vungle');

  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }

  static OnInitilizeListener onInitilizeListener;
  
  static OnAdPlayableListener onAdPlayableListener;
  
  static OnAdStartedListener onAdStartedListener;
  
  static OnAdFinishedListener onAdFinishedListener;

  static void init(String appId) {
    
  }

  static void loadAd(String placementId) {

  }

  static void playAd(String placementId) {

  }

  static Future<bool> isAdAvailable(String placementId) async {
    return false;
  }

  static void updateConsentStatus(UserConsentStatus status, String consentMessageVersion) {

  }

  static Future<UserConsentStatus> getConsentStatus() async {
    return null;
  }

  static Future<String> getConsentMessageVersion() async {
    return null;
  }
  


}
