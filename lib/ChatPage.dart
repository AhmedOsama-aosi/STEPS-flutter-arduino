import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:typed_data';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';

import 'pages/AnalyticsPage.dart';
import 'pages/DashboardPage.dart';
import 'pages/SettingsPage.dart';
import 'StaticValues.dart';

class ChatPage extends StatefulWidget {
  final BluetoothDevice server;

  const ChatPage({required this.server});
  // const ChatPage();

  @override
  _ChatPage createState() => new _ChatPage();
}

class _Message {
  int whom;
  String text;

  _Message(this.whom, this.text);
}

class _ChatPage extends State<ChatPage> {
  static final clientID = 0;
  BluetoothConnection? connection;

  List<_Message> messages = List<_Message>.empty(growable: true);
  String _messageBuffer = '';

  final TextEditingController textEditingController =
      new TextEditingController();
  // final ScrollController listScrollController = new ScrollController();

  bool isConnecting = true;
  bool get isConnected => (connection?.isConnected ?? false);

  bool isDisconnecting = false;

  @override
  void initState() {
    super.initState();
    if (widget.server.address != "") {}
    BluetoothConnection.toAddress(widget.server.address).then((_connection) {
      print('Connected to the device');
      StaticValues.bluetooth = true;
      connection = _connection;
      setState(() {
        isConnecting = false;
        isDisconnecting = false;
      });

      connection!.input!.listen(_onDataReceived).onDone(() {
        // Example: Detect which side closed the connection
        // There should be `isDisconnecting` flag to show are we are (locally)
        // in middle of disconnecting process, should be set before calling
        // `dispose`, `finish` or `close`, which all causes to disconnect.
        // If we except the disconnection, `onDone` should be fired as result.
        // If we didn't except this (no flag set), it means closing by remote.
        if (isDisconnecting) {
          print('Disconnecting locally!');
          StaticValues.bluetooth = false;
        } else {
          print('Disconnected remotely!');
          StaticValues.bluetooth = false;
        }
        if (this.mounted) {
          setState(() {});
        }
      });
    }).catchError((error) {
      print('Cannot connect, exception occured');
      print(error);
    });
  }

  @override
  void dispose() {
    // Avoid memory leak (`setState` after dispose) and disconnect
    if (isConnected) {
      isDisconnecting = true;
      connection?.dispose();
      connection = null;
    }

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final List<Row> list = messages.map((_message) {
      return Row(
        children: <Widget>[
          Container(
            child: Text(
                (text) {
                  return text == '/shrug' ? '¯\\_(ツ)_/¯' : text;
                }(_message.text.trim()),
                style: TextStyle(color: Colors.white)),
            padding: EdgeInsets.all(12.0),
            margin: EdgeInsets.only(bottom: 8.0, left: 8.0, right: 8.0),
            width: 222.0,
            decoration: BoxDecoration(
                color:
                    _message.whom == clientID ? Colors.blueAccent : Colors.grey,
                borderRadius: BorderRadius.circular(7.0)),
          ),
        ],
        mainAxisAlignment: _message.whom == clientID
            ? MainAxisAlignment.end
            : MainAxisAlignment.start,
      );
    }).toList();

    // final serverName = widget.server.name ?? "Unknown";
    final serverName = "Unknown";
    // return Scaffold(
    //   appBar: AppBar(
    //       title: (isConnecting
    //           ? Text('Connecting chat to ' + serverName + '...')
    //           : isConnected
    //               ? Text('Live chat with ' + serverName)
    //               : Text('Chat log with ' + serverName))),
    //   body: SafeArea(
    //     child: Column(
    //       children: <Widget>[
    //         Flexible(
    //           child: ListView(
    //               padding: const EdgeInsets.all(12.0),
    //               controller: listScrollController,
    //               children: list),
    //         ),
    //         Row(
    //           children: <Widget>[
    //             Flexible(
    //               child: Container(
    //                 margin: const EdgeInsets.only(left: 16.0),
    //                 child: TextField(
    //                   style: const TextStyle(fontSize: 15.0),
    //                   controller: textEditingController,
    //                   decoration: InputDecoration.collapsed(
    //                     hintText: isConnecting
    //                         ? 'Wait until connected...'
    //                         : isConnected
    //                             ? 'Type your message...'
    //                             : 'Chat got disconnected',
    //                     hintStyle: const TextStyle(color: Colors.grey),
    //                   ),
    //                   enabled: isConnected,
    //                 ),
    //               ),
    //             ),
    //             Container(
    //               margin: const EdgeInsets.all(8.0),
    //               child: IconButton(
    //                   icon: const Icon(Icons.send),
    //                   onPressed: isConnected
    //                       ? () => _sendMessage(textEditingController.text)
    //                       : null),
    //             ),
    //           ],
    //         )
    //       ],
    //     ),
    //   ),
    // );
    double margin = 5;
    double padding = 8;
    double redius = 10;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        color: Colors.white,
        child: Column(
          children: [
            Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
              Container(
                height: 40,
                width: 90,
                child: Center(
                  child: Text(
                    "STEPS",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontWeight: FontWeight.w900,
                        fontSize: 22,
                        color: StaticValues.secandColor),
                  ),
                ),
              ),
              Spacer(),
              GestureDetector(
                onTap: (() {
                  StaticValues.test = !StaticValues.test;
                }),
                child: Container(
                  width: 30,
                  height: 30,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: StaticValues.secandColor,
                  ),
                  child: Icon(
                    Icons.account_circle_rounded,
                    color: Colors.white,
                    size: 30,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: Center(
                  child: Text(
                    "A.Osama",
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              SizedBox(
                width: 20,
              )
            ]),
            Expanded(
                child: Row(
              children: [
                Expanded(
                    flex: 1,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: (() {
                            StaticValues.page = 1;
                            setState(() {});
                          }),
                          child: Container(
                            height: 70,
                            child: Column(children: [
                              Icon(
                                StaticValues.page == 1
                                    ? Icons.dashboard
                                    : Icons.dashboard_outlined,
                                color: StaticValues.page == 1
                                    ? StaticValues.thirdColor
                                    : StaticValues.lightGrey,
                              ),
                              Text("Dashboard")
                            ]),
                          ),
                        ),
                        GestureDetector(
                          onTap: (() {
                            StaticValues.page = 2;
                            setState(() {});
                          }),
                          child: Container(
                            height: 70,
                            child: Column(children: [
                              Icon(
                                StaticValues.page == 2
                                    ? Icons.analytics
                                    : Icons.analytics_outlined,
                                color: StaticValues.page == 2
                                    ? StaticValues.thirdColor
                                    : StaticValues.lightGrey,
                              ),
                              Text("Analyitcs")
                            ]),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            StaticValues.page = 3;
                            setState(() {});
                          },
                          child: Container(
                            height: 70,
                            child: Column(children: [
                              Icon(
                                StaticValues.page == 3
                                    ? Icons.settings
                                    : Icons.settings_outlined,
                                color: StaticValues.page == 3
                                    ? StaticValues.thirdColor
                                    : StaticValues.lightGrey,
                              ),
                              Text("Settings")
                            ]),
                          ),
                        ),
                      ],
                    )),
                Expanded(
                    flex: 10,
                    child: Container(
                        margin: EdgeInsets.all(margin + 5),
                        clipBehavior: Clip.hardEdge,
                        decoration: BoxDecoration(
                          boxShadow: <BoxShadow>[
                            BoxShadow(
                                color: StaticValues.lightGrey,
                                blurRadius: 2.0,
                                offset: Offset(0.0, 0.75))
                          ],
                          borderRadius: BorderRadius.circular(15),
                          color: Colors.white,
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(padding),
                          //  child: Settings(),
                          child: StaticValues.page == 1
                              ? Dashboard(margin: margin, redius: redius)
                              : StaticValues.page == 2
                                  ? Analytics(margin: margin, redius: redius)
                                  : SingleChildScrollView(
                                      physics: BouncingScrollPhysics(),
                                      child: Settings(
                                        function: _startsending,
                                        sendmassage: _sendMessage,
                                        textEditingController:
                                            textEditingController,
                                      ),
                                    ),
                        ))),
              ],
            ))
          ],
        ),
      ),
    );
  }

  void _onDataReceived(Uint8List data) {
    // Allocate buffer for parsed data
    int backspacesCounter = 0;
    data.forEach((byte) {
      if (byte == 8 || byte == 127) {
        backspacesCounter++;
      }
    });
    Uint8List buffer = Uint8List(data.length - backspacesCounter);
    int bufferIndex = buffer.length;

    // Apply backspace control character
    backspacesCounter = 0;
    for (int i = data.length - 1; i >= 0; i--) {
      if (data[i] == 8 || data[i] == 127) {
        backspacesCounter++;
      } else {
        if (backspacesCounter > 0) {
          backspacesCounter--;
        } else {
          buffer[--bufferIndex] = data[i];
        }
      }
    }

    // Create message if there is new line character
    String dataString = String.fromCharCodes(buffer);
    int index = buffer.indexOf(13);
    if (~index != 0) {
      setState(() {
        messages.add(
          _Message(
            1,
            backspacesCounter > 0
                ? _messageBuffer.substring(
                    0, _messageBuffer.length - backspacesCounter)
                : _messageBuffer + dataString.substring(0, index),
          ),
        );
        _messageBuffer = dataString.substring(index);
      });
    } else {
      _messageBuffer = (backspacesCounter > 0
          ? _messageBuffer.substring(
              0, _messageBuffer.length - backspacesCounter)
          : _messageBuffer + dataString);
    }
  }

  void _sendMessage(String text) async {
    text = text.trim();
    textEditingController.clear();
    if (text.length > 0) {
      try {
        connection!.output.add(Uint8List.fromList(utf8.encode(text + "\r\n")));
        await connection!.output.allSent;

        // setState(() {
        //   messages.add(_Message(clientID, text));
        // });

        // Future.delayed(Duration(milliseconds: 333)).then((_) {
        //   listScrollController.animateTo(
        //       listScrollController.position.maxScrollExtent,
        //       duration: Duration(milliseconds: 333),
        //       curve: Curves.easeOut);
        // });
      } catch (e) {
        // Ignore error, but notify state
        // setState(() {});
      }
    }
  }

  void _startsending() async {
    List<double> s = [30, 60, 90, 120, 150, 120, 90, 60, 30];
    StaticValues.moving_mode = true;
    for (double e in s) {
      print("send Arduino: " + e.toString());
      StaticValues.solarPanels_angel = e;
      if (!StaticValues.bluetooth) {
        break;
      }
      _sendMessage("v" + e.toString());
      await Future.delayed(Duration(seconds: 8));
    }
    StaticValues.moving_mode = false;
    StaticValues.optimization = false;
    setState(() {});
  }
}
