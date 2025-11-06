import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'tt_screen_record_plugin_platform_interface.dart';

/// An implementation of [TtScreenRecordPluginPlatform] that uses method channels.
class MethodChannelTtScreenRecordPlugin extends TtScreenRecordPluginPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('tt_screen_record_plugin');

  @override
  Future<Map<String,dynamic>> startRecording() async {
    try {
      Map<String,dynamic> _map =  Map<String, dynamic>.from(await methodChannel.invokeMethod('start'));
      print('startRecording=${_map}');
      return _map;
    } catch (e) {
      print('Failed to start recording: $e');
      return {};
    }
  }

  Future<Map<String,dynamic>> stopRecording() async {
    try {
      Map<String,dynamic> _map=  Map<String, dynamic>.from(await methodChannel.invokeMethod('stop'));
      print('stopRecording:${_map}');
      return _map;
    } catch (e) {
      print('Failed to stop recording: $e');
      return {};
    }
  }

  Future<bool> recording() async {
    try {
      bool recording  = await methodChannel.invokeMethod('recording');
      return recording;
    } catch (e) {
      print('Failed to get recording: $e');
      return false;
    }
  }

  Future<bool> isAvailable() async {
    try {
      bool available  = await methodChannel.invokeMethod('isAvailable');
      return available;
    } catch (e) {
      print('Failed to get isAvailable: $e');
      return false;
    }
  }
}
