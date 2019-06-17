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
      const MethodChannel('flutter_vungle');

  static OnInitilizeListener onInitilizeListener;
  
  static OnAdPlayableListener onAdPlayableListener;
  
  static OnAdStartedListener onAdStartedListener;
  
  static OnAdFinishedListener onAdFinishedListener;

  static void init(String appId) {

    //register callback method handler
    _channel.setMethodCallHandler(_handleMethod);

    _channel.invokeMethod('init', <String, dynamic>{
      'appId': appId,
    });
  }

  static void loadAd(String placementId) {
    _channel.invokeMethod('loadAd', <String, dynamic>{
      'placementId': placementId,
    });
  }

  static void playAd(String placementId) {
    _channel.invokeMethod('playAd', <String, dynamic>{
      'placementId': placementId,
    });
  }

  static Future<bool> isAdPlayable(String placementId) async {
    final bool isAdAvailable = await _channel.invokeMethod('isAdPlayable', <String, dynamic>{
      'placementId': placementId,
    });
    return isAdAvailable;
  }

  static void updateConsentStatus(UserConsentStatus status, String consentMessageVersion) {
    _channel.invokeMethod('updateConsentStatus', <String, dynamic>{
      'consentStatus': status.toString(),
      'consentMessageVersion': consentMessageVersion,
    });
  }

  static Future<UserConsentStatus> getConsentStatus() async {
    final String status = await _channel.invokeMethod('getConsentStatus', null);
    return _statusStringToUserConsentStatus[status];
  }

  static Future<String> getConsentMessageVersion() async {
    final String version = await _channel.invokeMethod('getConsentMessageVersion', null);
    return version;
  }
  
  static const Map<String, UserConsentStatus> _statusStringToUserConsentStatus = {
    'Accepted': UserConsentStatus.Accepted,
    'Denied': UserConsentStatus.Denied,
  };

  static Future<dynamic> _handleMethod(MethodCall call) {
    print('_handleMethod: ${call.method}, ${call.arguments}');
    final Map<dynamic, dynamic> arguments = call.arguments;
    final String method = call.method;

    if(method == 'onInitialize') {
      if(onInitilizeListener != null) {
        onInitilizeListener();
      }
    } else {
      final String placementId = arguments['placementId'];
      if(method == 'onAdPlayable') {
        final bool playable = arguments['playable'];
        if(onAdPlayableListener != null) {
          onAdPlayableListener(placementId, playable);
        }
      } else if(method == 'onAdStarted') {
        if(onAdStartedListener != null) {
          onAdStartedListener(placementId);
        }
      } else if(method == 'onAdFinished') {
        final bool isCTAClicked = arguments['isCTAClicked']; 
        final bool isCompletedView = arguments['isCompletedView'];
        onAdFinishedListener(placementId, isCTAClicked, isCompletedView);
      } else {
        throw new MissingPluginException("Method not implemented, $method");
      }
    }
    return Future<dynamic>.value(null);
  }


}
