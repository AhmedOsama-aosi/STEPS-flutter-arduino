import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bluetooth_serial_example/ChatPage.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';

import './MainPage.dart';

void main() => runApp(new ExampleApplication());

class ExampleApplication extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeRight]);
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: [SystemUiOverlay.bottom]);

    // BluetoothDevice server = new BluetoothDevice(address: "");
    // return MaterialApp(
    //     debugShowCheckedModeBanner: false,
    //     home: ChatPage(
    //       server: server,
    //     ));
    return MaterialApp(debugShowCheckedModeBanner: false, home: MainPage());
  }
}
