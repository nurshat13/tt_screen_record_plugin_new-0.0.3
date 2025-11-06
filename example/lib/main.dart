import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:tt_screen_record_plugin/tt_screen_record_plugin.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _platformVersion = 'Unknown';
  final _ttScreenRecordPlugin = TtScreenRecordPlugin();
  bool recording = false; // 正在录制
  int recordingText = 0;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    String platformVersion;
    // Platform messages may fail, so we use a try/catch PlatformException.
    // We also handle the message potentially returning null.
    try {
      final _result = await _ttScreenRecordPlugin.isAvailable();
      print('platformVersion=${_result}');
      platformVersion = _result.toString();
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _platformVersion = platformVersion;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            title: const Text('Plugin example app'),
          ),
          body: Container(
            width: MediaQuery.of(context).size.width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () async {
                    // 按钮点击事件
                    bool result = await _ttScreenRecordPlugin.startRecording();
                    recording = await  _ttScreenRecordPlugin.recording();
                    if (result) {
                      _timer = Timer.periodic(Duration(seconds: 1), (timer) {
                        recordingText++;
                        setState(() {});
                      });
                    }
                  },
                  child: Text('Start'),
                ),
                SizedBox(
                  height: 16,
                ),
                ElevatedButton(
                  onPressed: () async{
                    // 按钮点击事件
                    Map result = await _ttScreenRecordPlugin.stopRecording();
                    print('result=${result['success']}');
                    recording = await  _ttScreenRecordPlugin.recording();
                    _timer?.cancel();
                    recordingText = 0;
                    setState(() {

                    });
                  },
                  child: Text('Stop'),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text('recording:'),
                    SizedBox(
                      width: 32,
                    ),
                    Text(recording ? '正在录制' : '空闲'),
                  ],
                ),
                SizedBox(
                  height: 16,
                ),
                Text(
                  recordingText.toString(),
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                ),
              ],
            ),
          )),
    );
  }
}
