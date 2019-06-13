import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:vungle/vungle.dart';

void main() {
  const MethodChannel channel = MethodChannel('vungle');

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('getPlatformVersion', () async {
    expect(await Vungle.platformVersion, '42');
  });
}
