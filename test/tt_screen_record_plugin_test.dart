import 'package:flutter_test/flutter_test.dart';
import 'package:tt_screen_record_plugin_new/tt_screen_record_plugin.dart';
import 'package:tt_screen_record_plugin_new/tt_screen_record_plugin_platform_interface.dart';
import 'package:tt_screen_record_plugin_new/tt_screen_record_plugin_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockTtScreenRecordPluginPlatform
    with MockPlatformInterfaceMixin
    implements TtScreenRecordPluginPlatform {

  @override
  Future<Map<String,dynamic>> stopRecording() => Future.value(Map());
  @override
  Future<Map<String,dynamic>> startRecording() => Future.value(Map());
  @override
  Future<bool> recording() => Future.value(true);
  @override
  Future<bool> isAvailable() => Future.value(true);
}

void main() {
  final TtScreenRecordPluginPlatform initialPlatform = TtScreenRecordPluginPlatform.instance;

  test('$MethodChannelTtScreenRecordPlugin is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelTtScreenRecordPlugin>());
  });

  test('getPlatformVersion', () async {
    TtScreenRecordPlugin ttScreenRecordPlugin = TtScreenRecordPlugin();
    MockTtScreenRecordPluginPlatform fakePlatform = MockTtScreenRecordPluginPlatform();
    TtScreenRecordPluginPlatform.instance = fakePlatform;

    expect(await ttScreenRecordPlugin.isAvailable(), '42');
  });
}
