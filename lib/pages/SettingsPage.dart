import 'package:flutter/material.dart';

import '../StaticValues.dart';

class Settings extends StatefulWidget {
  Settings(
      {Key? key,
      required this.function,
      required this.sendmassage,
      required this.textEditingController})
      : super(key: key);
  final void Function() function;
  final void Function(String) sendmassage;
  final TextEditingController textEditingController;
  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height + 50,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            flex: 1,
            child: Row(
              children: [
                Text(
                  "Settings",
                  style: TextStyle(fontWeight: FontWeight.bold),
                )
              ],
            ),
          ),
          Expanded(
            flex: 9,
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      Expanded(
                          flex: 4,
                          child: Row(
                            children: [
                              SettingsWidget(
                                icon: Icons.bluetooth,
                                name: "Bluetooth",
                                value: StaticValues.bluetooth,
                                function: (v) {
                                  StaticValues.bluetooth =
                                      !StaticValues.bluetooth;
                                  setState(() {});
                                },
                              ),
                              SettingsWidget(
                                icon: Icons.insights,
                                name: "Optimization",
                                value: StaticValues.optimization,
                                function: (v) {
                                  StaticValues.optimization =
                                      !StaticValues.optimization;
                                  if (StaticValues.bluetooth) {
                                    widget.function();
                                  }
                                  if (!StaticValues.optimization) {
                                    StaticValues.moving_mode = false;
                                  }
                                  setState(() {});
                                },
                              ),
                              SettingsWidget(
                                icon: Icons.share_location_outlined,
                                name: "Tracking",
                                value: StaticValues.tracking,
                                function: (v) {
                                  StaticValues.tracking =
                                      !StaticValues.tracking;
                                  setState(() {});
                                },
                              ),
                            ],
                          )),
                      Expanded(
                          flex: 2,
                          child: Card(
                            margin: EdgeInsets.all(5),
                            elevation: 2,
                            clipBehavior: Clip.hardEdge,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            child: Container(
                              color: Colors.white,
                              child: Row(
                                children: [
                                  Expanded(
                                    flex: 9,
                                    child: Container(
                                      margin: const EdgeInsets.only(left: 16.0),
                                      child: TextField(
                                        style: const TextStyle(fontSize: 15.0),
                                        controller:
                                            widget.textEditingController,
                                        decoration: InputDecoration.collapsed(
                                          hintText: StaticValues.bluetooth
                                              ? 'Type the angle...'
                                              : 'Chat got disconnected',
                                          hintStyle: const TextStyle(
                                              color: Colors.grey),
                                        ),
                                        enabled: StaticValues.bluetooth,
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: IconButton(
                                        icon: const Icon(Icons.send),
                                        onPressed: StaticValues.bluetooth
                                            ? () => widget.sendmassage(widget
                                                .textEditingController.text)
                                            : null),
                                  )
                                ],
                              ),
                            ),
                          )),
                      Spacer(
                        flex: 6,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class SettingsWidget extends StatefulWidget {
  const SettingsWidget({
    Key? key,
    required this.function,
    required this.icon,
    required this.name,
    required this.value,
  }) : super(key: key);
  final void Function(bool v) function;
  final IconData icon;
  final String name;
  final bool value;
  @override
  State<SettingsWidget> createState() => _SettingsWidgetState();
}

class _SettingsWidgetState extends State<SettingsWidget> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 2,
      child: Card(
        margin: EdgeInsets.all(5),
        clipBehavior: Clip.hardEdge,
        elevation: 5,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Container(
          color: StaticValues.secandColor,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Expanded(
                  child: Row(
                    children: [
                      Expanded(
                          child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 8.0, left: 8),
                            child: Icon(
                              widget.icon,
                              size: 28,
                              color: Colors.white,
                            ),
                          )
                        ],
                      )),
                      Expanded(
                          child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Switch(
                            value: widget.value,
                            onChanged: widget.function,
                            activeColor: Colors.white,
                          )
                        ],
                      )),
                    ],
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Row(
                      children: [
                        Text(
                          widget.name,
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 18),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
