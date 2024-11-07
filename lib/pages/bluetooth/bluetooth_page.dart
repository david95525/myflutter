import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_reactive_ble/flutter_reactive_ble.dart';
import 'package:permission_handler/permission_handler.dart';

class BluetoothPage extends StatefulWidget {
  const BluetoothPage({super.key});

  @override
  State<BluetoothPage> createState() => _BluetoothPageState();
}

class _BluetoothPageState extends State<BluetoothPage> {
  StreamSubscription<DiscoveredDevice>? _streamSubscription;
  StreamSubscription<ConnectionStateUpdate>? _connectionStreamSubscription;
  List<DiscoveredDevice> deviceList = [];
  List<String> buttonTextList = [];
  List<String> nameList = [];
  List<int> datalist = [];
  final flutterReactiveBle = FlutterReactiveBle();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final serviceuuid = Uuid.parse("CDEACB81-5235-4C07-8846-93A37EE6B86D");
  static const platform = MethodChannel("samples.flutter.dev/settings");
  String deviceid = "";
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: scaffoldKey,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ElevatedButton(
                key: const Key('scanButton'),
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                onPressed: () => _permission(),
                child: const Text('scan'),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: deviceList.length,
                  itemBuilder: (context, index) {
                    final item = deviceList[index];
                    return ListTile(
                      title: Text(item.id),
                      subtitle: Text("${item.name} ${item.id}"),
                      trailing: Wrap(
                        children: [
                          ElevatedButton(
                            key: const Key('connect'),
                            style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                backgroundColor:
                                    buttonTextList[index] == "Connect"
                                        ? Colors.white70
                                        : Colors.lightGreen),
                            onPressed: () => buttonTextList[index] == "Connect"
                                ? _connectDevice(index)
                                : _disconnectDevice(index),
                            child: Text(buttonTextList[index]),
                          ),
                          ElevatedButton(
                            key: const Key('find'),
                            style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                backgroundColor: Colors.lightBlue),
                            onPressed: () => _discoverServices(index),
                            child: const Text("Find",
                                style: TextStyle(color: Colors.white)),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: datalist.length,
                  itemBuilder: (context, index) {
                    final item = datalist[index];
                    return ListTile(title: Text(item.toString()));
                  },
                ),
              )
            ],
          ),
        ));
  }

  void _permission() async {
    // if (await Permission.location.serviceStatus.isEnabled) {
    //   debugPrint('Location services is enabled');
    // } else {
    //   debugPrint('Location services is NOT enabled');
    // }
    var status = await Permission.location.status;
    if (!status.isGranted) {
      debugPrint('Location permission is not granted');
      await Permission.location.request();
    }
    var blestatusisGranted = await Permission.bluetooth.request().isGranted;
    if (!blestatusisGranted) {
      debugPrint('ble is not granted');
      await platform.invokeMethod("openBluetoothSettings");
      await Permission.bluetooth.request();
    }
    var ScanStatus = await Permission.bluetoothScan.status;
    if (!ScanStatus.isGranted) {
      debugPrint('Scan permission is not granted');
      await Permission.bluetoothScan.request();
    }
    var ConnectStatus = await Permission.bluetoothConnect.status;
    if (ConnectStatus.isGranted) {
      _scanDevice();
    } else {
      debugPrint('Connect permission is NOT enabled');
      await Permission.bluetoothConnect.request();
      _scanDevice();
    }
  }

  void _scanDevice() {
    _streamSubscription = flutterReactiveBle
        .scanForDevices(withServices: [], scanMode: ScanMode.lowLatency).listen(
            (device) {
              if (device.name.isNotEmpty && !nameList.contains(device.name)) {
                debugPrint(device.name);
                buttonTextList.add("Connect");
                nameList.add(device.name);
                setState(() {
                  deviceList.add(device);
                });
              }
            },
            onDone: () {},
            onError: (e) {
              debugPrint("onError = $e");
            });
  }

  void _connectDevice(int index) {
    debugPrint(index.toString());
    DiscoveredDevice device = deviceList[index];
    _connectionStreamSubscription = flutterReactiveBle
        .connectToDevice(
      id: device.id,
      servicesWithCharacteristicsToDiscover: {}[serviceuuid],
      connectionTimeout: const Duration(seconds: 3),
    )
        .listen((connectionState) {
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      if (connectionState.connectionState == DeviceConnectionState.connecting) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [CircularProgressIndicator(), Text("Connecting...")],
          ),
          backgroundColor: Colors.grey,
        ));
      }
      if (connectionState.connectionState == DeviceConnectionState.connected) {
        setState(() {
          buttonTextList[index] = "Disconnect";
        });
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [CircularProgressIndicator(), Text("Connect Success")],
          ),
          backgroundColor: Colors.green,
        ));
        Timer(const Duration(seconds: 1), () {
          ScaffoldMessenger.of(context).hideCurrentSnackBar();
        });
        _qualifiedCharacteristic(serviceuuid, serviceuuid, device.id);
      }
      if (connectionState.connectionState ==
          DeviceConnectionState.disconnected) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [CircularProgressIndicator(), Text("Connect Fail")],
          ),
          backgroundColor: Colors.grey,
        ));
        Timer(const Duration(seconds: 1), () {
          ScaffoldMessenger.of(context).hideCurrentSnackBar();
        });
      }
    }, onError: (Object error) {
      debugPrint("error1 =$error");
    });
  }

  void _disconnectDevice(int index) {
    setState(() {
      buttonTextList[index] = "Connect";
    });
    _connectionStreamSubscription?.cancel();
  }

  _discoverServices(int index) async {
    DiscoveredDevice device = deviceList[index];
    List<Service> serviceList =
        await flutterReactiveBle.getDiscoveredServices(device.id);
    debugPrint("services=$serviceList");
    debugPrint(
        "deviceId:${serviceList[0].characteristics[0].service.deviceId}");
    for (int i = 0; i < serviceList.length; i++) {
      Service discoveredService = serviceList[i];
      for (int i = 0; i < discoveredService.characteristics.length; i++) {
        debugPrint(
            "uuid:${discoveredService.characteristics[i].service.id.toString()}");
      }
    }
  }

  void _qualifiedCharacteristic(
      Uuid serviceId, Uuid characteristicId, String deviceId) async {
    final characteristic = QualifiedCharacteristic(
        serviceId: serviceId,
        characteristicId: characteristicId,
        deviceId: deviceId);
    flutterReactiveBle.subscribeToCharacteristic(characteristic).listen((data) {
      for (int i = 0; i < data.length; i++) {
        setState(() {
          datalist.add(data[i]);
        });
      }
    }, onError: (dynamic error) {});
  }
}
  //Read characteristic
    // final response =
    //     await flutterReactiveBle.readCharacteristic(characteristic);
    //Write with response
    // await flutterReactiveBle
    //     .writeCharacteristicWithResponse(characteristic, value: [0x00]);
    //Write without response
    // await flutterReactiveBle
    //     .writeCharacteristicWithoutResponse(characteristic, value: [0x00]);
    //Negotiate MTU size
    // final mtu =
    //     await flutterReactiveBle.requestMtu(deviceId: deviceId, mtu: 250);

    /**Android specific operations**/
    //Request connection priority
    //Be cautious when setting the priority when communicating with multiple devices because
    //if you set highperformance for all devices the effect of increasing the priority will be lower
    // await flutterReactiveBle.requestConnectionPriority(
    //     deviceId: deviceId, priority: ConnectionPriority.highPerformance);
    //Clear GATT cache
    // await flutterReactiveBle.clearGattCache(deviceId);
