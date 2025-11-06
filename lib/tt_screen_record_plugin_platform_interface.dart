import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'tt_screen_record_plugin_method_channel.dart';

abstract class TtScreenRecordPluginPlatform extends PlatformInterface {
  /// Constructs a TtScreenRecordPluginPlatform.
  TtScreenRecordPluginPlatform() : super(token: _token);

  static final Object _token = Object();

  static TtScreenRecordPluginPlatform _instance = MethodChannelTtScreenRecordPlugin();

  /// The default instance of [TtScreenRecordPluginPlatform] to use.
  ///
  /// Defaults to [MethodChannelTtScreenRecordPlugin].
  static TtScreenRecordPluginPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [TtScreenRecordPluginPlatform] when
  /// they register themselves.
  static set instance(TtScreenRecordPluginPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<Map<String,dynamic>> startRecording() {
    throw UnimplementedError('startRecording() has not been implemented.');
  }

  Future<Map<String,dynamic>> stopRecording() {
    throw UnimplementedError('stopRecording() has not been implemented.');
  }

  Future<bool> recording(){
    throw UnimplementedError('recording() has not been implemented.');
  }

  Future<bool> isAvailable() {
    throw UnimplementedError('isAvailable() has not been implemented.');
  }
}
