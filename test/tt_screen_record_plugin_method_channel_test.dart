import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tt_screen_record_plugin/tt_screen_record_plugin_method_channel.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  MethodChannelTtScreenRecordPlugin platform = MethodChannelTtScreenRecordPlugin();
  const MethodChannel channel = MethodChannel('tt_screen_record_plugin');

  setUp(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger.setMockMethodCallHandler(
      channel,
      (MethodCall methodCall) async {
        return '42';
      },
    );
  });

  tearDown(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger.setMockMethodCallHandler(channel, null);
  });

  test('getPlatformVersion', () async {
    expect(await platform.isAvailable(), '42');
  });
}
