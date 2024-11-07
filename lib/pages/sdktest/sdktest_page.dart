import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SDKTestPage extends StatefulWidget {
  const SDKTestPage({super.key});

  @override
  State<SDKTestPage> createState() => _SDKTestPageState();
}

class _SDKTestPageState extends State<SDKTestPage> {
  String _batteryLevel = 'Unknown battery level.';
  static const platform = MethodChannel('samples.flutter.dev/setting');
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Weather API Sample'),
      ),
      body: Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ElevatedButton(
                onPressed: _getBatteryLevel,
                child: const Text('Get Battery Level'),
              ),
              Text(
                _batteryLevel,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 15),
              )
            ]),
      ),
    );
  }

  Future<void> _getBatteryLevel() async {
    String batteryLevel;
    try {
      final int result = await platform.invokeMethod('getBatteryLevel');
      batteryLevel = 'Battery level at $result % .';
    } on PlatformException catch (e) {
      batteryLevel = "Failed to get battery level: '${e.message}'.";
    }

    setState(() {
      _batteryLevel = batteryLevel;
    });
  }
}
