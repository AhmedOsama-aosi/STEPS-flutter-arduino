import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'DashboardPage.dart';
import '../StaticValues.dart';

class Analytics extends StatefulWidget {
  const Analytics({
    Key? key,
    required this.margin,
    required this.redius,
  }) : super(key: key);

  final double margin;
  final double redius;

  @override
  State<Analytics> createState() => _AnalyticsState();
}

class _AnalyticsState extends State<Analytics> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          flex: 1,
          child: Row(
            children: [
              Text(
                "Analytics",
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
                        flex: 2,
                        child: AnalyticsWidget(
                          widget: widget,
                          name: "Daily revenue",
                          measuring_unit: "kwh",
                          value: 65.24,
                          pValue: 12,
                          dValue: "yasterday",
                          inc: true,
                          good: true,
                          values: [
                            20,
                            30,
                            25,
                            40,
                            20,
                            28,
                            35,
                            50,
                            28,
                            35,
                            50,
                            40
                          ],
                        )),
                    Expanded(
                        flex: 3,
                        child: Container(
                            margin: EdgeInsets.all(widget.margin),
                            clipBehavior: Clip.hardEdge,
                            decoration: BoxDecoration(
                              boxShadow: <BoxShadow>[
                                BoxShadow(
                                    color: StaticValues.lightGrey,
                                    blurRadius: 2.0,
                                    offset: Offset(0.0, 0.75))
                              ],
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Container(
                              color: Colors.white,
                              child: Expanded(
                                  child: Column(
                                children: [
                                  Expanded(
                                      flex: 1,
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            right: 15.0, left: 15, top: 15),
                                        child: Row(
                                          children: [
                                            Expanded(
                                                child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text("Energy Production"),
                                                Text("Updated 40 mins ago"),
                                              ],
                                            )),
                                            Spacer(),
                                            Container(
                                              width: 50,
                                              height: 25,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                  border: Border.all(
                                                      width: 2,
                                                      color: StaticValues
                                                          .secandColor)),
                                              child:
                                                  Center(child: Text("Year")),
                                            )
                                          ],
                                        ),
                                      )),
                                  Expanded(
                                      flex: 2,
                                      child: Padding(
                                        padding: EdgeInsets.all(15.0),
                                        child: MainChartWidget(),
                                      )),
                                ],
                              )),
                            ))),
                  ],
                )),
                Expanded(
                    child: Column(
                  children: [
                    Expanded(
                        flex: 2,
                        child: AnalyticsWidget(
                          widget: widget,
                          name: "Consumption",
                          measuring_unit: "kwh",
                          value: 45.24,
                          pValue: 10,
                          dValue: "yasterday",
                          inc: true,
                          good: false,
                          values: [
                            20,
                            30,
                            25,
                            40,
                            20,
                            28,
                            35,
                            50,
                            28,
                            35,
                            50,
                            40
                          ],
                        )),
                    Expanded(
                        flex: 2,
                        child: AnalyticsWidget(
                          widget: widget,
                          name: "Estimated saving",
                          measuring_unit: "\$",
                          value: 10.24,
                          pValue: 0,
                          dValue: "yasterday",
                          inc: false,
                          good: false,
                          values: [
                            20,
                            30,
                            25,
                            40,
                            20,
                            28,
                            35,
                            50,
                            28,
                            35,
                            50,
                            40
                          ],
                        )),
                    Expanded(
                        flex: 1,
                        child: Card(
                            margin: EdgeInsets.all(widget.margin),
                            elevation: 0,
                            clipBehavior: Clip.hardEdge,
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.circular(widget.redius)),
                            child: Container(
                              color: StaticValues.secandColor,
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    WeatherElement(
                                      icon: CupertinoIcons.cloud_sun,
                                      name: "Temprature",
                                      value: "45c",
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 12.0, vertical: 5),
                                      child: SizedBox(
                                        width: 1,
                                        child: Container(
                                            color: Color.fromARGB(
                                                106, 255, 255, 255)),
                                      ),
                                    ),
                                    WeatherElement(
                                      icon: Icons.wb_sunny_outlined,
                                      name: "irradiation",
                                      value: "10 J/mm2",
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 12.0, vertical: 5),
                                      child: SizedBox(
                                        width: 1,
                                        child: Container(
                                            color: Color.fromARGB(
                                                106, 255, 255, 255)),
                                      ),
                                    ),
                                    WeatherElement(
                                      icon: Icons.air,
                                      name: "Wind",
                                      value: "15 m/s",
                                    ),
                                  ],
                                ),
                              ),
                            )))
                  ],
                )),
              ],
            ))
      ],
    );
  }
}

class MainChartWidget extends StatelessWidget {
  MainChartWidget({
    Key? key,
  }) : super(key: key);
  List<Widget> list = [];
  List<Widget> months = [];
  List<String> smonths = <String>[
    'Jan',
    'Feb',
    'Mar',
    'Apr',
    'May',
    'Jun',
    'Jul',
    'Aug',
    'Sep',
    'Oct',
    'Nov',
    'Dec'
  ];
  @override
  Widget build(BuildContext context) {
    var random = new Random();

    for (var i = 0; i < 12; i++) {
      months.add(Text(
        smonths[i],
        style: TextStyle(fontSize: 11),
      ));
    }
    for (var i = 0; i < 12; i++) {
      double max = 40.0 + random.nextInt(30);
      list.add(
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: StaticValues.secandColor,
              ),
              width: 6,
              height: max,
            ),
            SizedBox(
              width: 5,
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                //  color: Color.fromARGB(255, 204, 204, 204),
                color: StaticValues.lightGrey,
              ),
              width: 6,
              height: max - 15 - random.nextInt(10),
            ),
          ],
        ),
      );
    }
    return Column(
      children: [
        Expanded(
          flex: 5,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: list,
          ),
        ),
        Expanded(
          flex: 1,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: months,
          ),
        ),
      ],
    );
  }
}

class WeatherElement extends StatelessWidget {
  const WeatherElement({
    Key? key,
    required this.name,
    required this.value,
    required this.icon,
  }) : super(key: key);
  final String value;
  final String name;
  final IconData icon;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4.0),
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Color.fromARGB(90, 255, 255, 255)),
            height: 30,
            width: 30,
            child: Icon(
              icon,
              color: Colors.white,
              size: 20,
            ),
          ),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              value,
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            Text(
              name,
              style: TextStyle(
                  color: Color.fromARGB(179, 255, 255, 255), fontSize: 12),
            )
          ],
        ),
      ],
    );
  }
}

class AnalyticsWidget extends StatelessWidget {
  const AnalyticsWidget({
    Key? key,
    required this.widget,
    required this.name,
    required this.value,
    required this.pValue,
    required this.dValue,
    required this.measuring_unit,
    required this.inc,
    required this.good,
    required this.values,
  }) : super(key: key);

  final Analytics widget;
  final String name;
  final double value;
  final double pValue;
  final String dValue;
  final String measuring_unit;
  final bool inc;
  final bool good;
  final List<double> values;

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.all(widget.margin),
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
          boxShadow: <BoxShadow>[
            BoxShadow(
                color: StaticValues.lightGrey,
                blurRadius: 2.0,
                offset: Offset(0.0, 0.75))
          ],
          borderRadius: BorderRadius.circular(widget.redius),
        ),
        child: Container(
          color: Colors.white,
          child: Column(
            children: [
              Expanded(
                  flex: 1,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: Row(
                      children: [
                        Text(
                          name,
                          style: TextStyle(
                              color: Color.fromARGB(255, 116, 116, 116),
                              fontSize: 14,
                              fontWeight: FontWeight.bold),
                        ),
                        Spacer(),
                        Text(
                          "" +
                              DateTime.now().month.toString() +
                              "-" +
                              DateTime.now().day.toString() +
                              " , " +
                              DateTime.now().hour.toString() +
                              ":" +
                              DateTime.now().minute.toString() +
                              "",
                          style: TextStyle(
                              color: Color.fromARGB(255, 116, 116, 116)),
                        ),
                      ],
                    ),
                  )),
              Expanded(
                  flex: 2,
                  child: Row(
                    children: [
                      Expanded(
                          child: Padding(
                        padding: EdgeInsets.only(
                            left: 15.0, right: 15.0, bottom: 15),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "$value $measuring_unit",
                              style: TextStyle(
                                  fontSize: 21, fontWeight: FontWeight.bold),
                            ),
                            Spacer(),
                            RichText(
                              text: TextSpan(children: [
                                TextSpan(
                                  text: inc
                                      ? "+" + pValue.toString() + "% "
                                      : "-" + pValue.toString() + "% ",
                                  style: TextStyle(
                                      color: good
                                          ? StaticValues.thirdColor
                                          : Colors.red,
                                      fontWeight: FontWeight.bold),
                                ),
                                TextSpan(
                                  text: dValue,
                                  style: TextStyle(
                                    color: Colors.grey,
                                  ),
                                ),
                              ]),
                            ),
                            // Text("+15% For Last 7 days"),
                          ],
                        ),
                      )),
                      Expanded(
                          child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                              flex: 2,
                              child: Padding(
                                padding: EdgeInsets.all(15.0),
                                child: ChartWidget(
                                  values: values,
                                ),
                              )),
                        ],
                      ))
                    ],
                  ))
            ],
          ),
        ));
  }
}

class ChartWidget extends StatelessWidget {
  const ChartWidget({Key? key, required this.values}) : super(key: key);
  final List<double> values;
  @override
  Widget build(BuildContext context) {
    List<Widget> lits = [];
    for (var i = 0; i < 12; i++) {
      lits.add(Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          // color: Color.fromARGB(255, 204, 204, 204),
          color: StaticValues.lightGrey,
        ),
        width: 5,
        height: values[i],
      ));
      lits.add(SizedBox(
        width: 5,
      ));
    }
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: lits,
    );
  }
}
