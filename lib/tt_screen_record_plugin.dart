import 'dart:io';
import 'tt_screen_record_plugin_platform_interface.dart';
import 'package:device_screen_recorder/device_screen_recorder.dart';

class TtScreenRecordPlugin {
  bool _isRecording = false;

  Future<bool> startRecording() async {
    bool result = await this.recording();
    if (result) {
      print('Warning:Recording in progress, please end first');
      return false;
    }
    if (Platform.isAndroid) {
      bool? _result = await DeviceScreenRecorder.startRecordScreen(name: 'example');
      _isRecording = _result ?? false;
      return _result ?? false;
    } else {
      Map _map = await TtScreenRecordPluginPlatform.instance.startRecording();
      bool result = _map['success'] == 1;
      _isRecording = _map['success'] == 1;
      return result;
    }
  }

  /*
* 返回结果：停止录制信息，格式为{'path': 视频保存路径,'success' : 录制结果}
* Return result: Stop recording information, in the format {'path': video saving path, 'success': recording result}
* */
  Future<Map<String, dynamic>> stopRecording() async {
    if (Platform.isAndroid) {
      String? path = await DeviceScreenRecorder.stopRecordScreen();
      _isRecording = false;
      print('reslult:${{'path': path, 'success': path != null}}');
      return {'path': path, 'success': path != null};
    } else {
      final result = await TtScreenRecordPluginPlatform.instance.stopRecording();
      _isRecording = false;
      print('reslult:${result}');
      return result;
    }
  }

  Future<bool> recording() async {
    if (Platform.isAndroid) {
      return Future.value(_isRecording);
    } else {
      return await TtScreenRecordPluginPlatform.instance.recording();
    }
  }

  /*
*是否可使用录屏，仅仅适用iOS，安卓永远返回是true
* Whether to use screen recording, only use iOS, Android will always return true
*  */
  Future<bool> isAvailable() async {
    if (Platform.isAndroid) {
      return Future.value(true);
    }
    return TtScreenRecordPluginPlatform.instance.isAvailable();
  }
}
