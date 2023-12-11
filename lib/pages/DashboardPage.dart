import 'dart:math';

import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/material.dart';

import '../StaticValues.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({
    Key? key,
    required this.margin,
    required this.redius,
  }) : super(key: key);

  final double margin;
  final double redius;

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  void initState() {
    _claculateSunAngles();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          flex: 1,
          child: Row(
            children: [
              Text(
                "Dashboard",
                style: TextStyle(fontWeight: FontWeight.bold),
              )
            ],
          ),
        ),
        Expanded(
          flex: 6,
          child: Row(
            children: [
              Expanded(
                child: Column(
                  children: [
                    Expanded(
                        child: Card(
                            margin: EdgeInsets.all(widget.margin),
                            elevation: 0,
                            clipBehavior: Clip.hardEdge,
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.circular(widget.redius)),
                            child: Container(
                              color: Color.fromARGB(97, 210, 252, 255),
                              child: Column(children: [
                                Expanded(flex: 1, child: Row()),
                                Expanded(
                                    flex: 9,
                                    child: Row(
                                      children: [
                                        //solar + sun
                                        Expanded(
                                            flex: 7,
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Expanded(
                                                  child: Stack(
                                                    children: [
                                                      Center(
                                                          child: SunWidget(
                                                              thewidget: this)),
                                                      Align(
                                                        alignment: Alignment
                                                            .bottomCenter,
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  right: 10.0),
                                                          child:
                                                              SvgPicture.asset(
                                                            "assets/images/holder.svg",
                                                            width: 50,
                                                            height: 50,
                                                          ),
                                                        ),
                                                      ),
                                                      Center(
                                                        child: SolarPanel(),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            )),
                                        //info cards
                                        Expanded(
                                            flex: 2,
                                            child: Column(
                                              children: [
                                                InfoCard(
                                                  margin: widget.margin,
                                                  redius: widget.redius,
                                                  icon: Icons.wb_sunny,
                                                  color: Colors.orange,
                                                  text: StaticValues.elevation
                                                      .toString(),
                                                ),
                                                InfoCard(
                                                  margin: widget.margin,
                                                  redius: widget.redius,
                                                  icon: Icons.wb_sunny_outlined,
                                                  color: Colors.orange,
                                                  text: StaticValues.azimuth
                                                      .toString(),
                                                ),
                                                InfoCard(
                                                  margin: widget.margin,
                                                  redius: widget.redius,
                                                  icon: Icons.thermostat,
                                                  color: Colors.red,
                                                  text: "45",
                                                ),
                                                InfoCard(
                                                  margin: widget.margin,
                                                  redius: widget.redius,
                                                  icon: Icons
                                                      .battery_3_bar_outlined,
                                                  color: Colors.yellow,
                                                  text: "6H",
                                                ),
                                              ],
                                            ))
                                      ],
                                    )),
                              ]),
                            ))),
                  ],
                ),
              ),
              Expanded(
                  child: Column(
                children: [
                  Expanded(
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
                            borderRadius: BorderRadius.circular(widget.redius),
                          ),
                          child: Container(
                            color: Colors.white,
                            child: Expanded(
                              child: Row(
                                children: [
                                  BarChart(),
                                  Expanded(
                                      child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text("Daily revenue"),
                                      Text(
                                        "45.24 kWh",
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text("+12% from yesterday"),
                                    ],
                                  )),
                                ],
                              ),
                            ),
                          ))),
                ],
              )),
            ],
          ),
        ),
        Expanded(
          flex: 3,
          child: Row(
            children: [
              SecondaryCardWidget(
                margin: widget.margin,
                redius: widget.redius,
                icon: Icons.cloud_outlined,
                title: "Co2 Reduction",
                text: "13 ton",
              ),
              SecondaryCardWidget(
                margin: widget.margin,
                redius: widget.redius,
                icon: Icons.battery_4_bar_rounded,
                title: "Capcity",
                text: "30 kWh",
              ),
              SecondaryCardWidget(
                margin: widget.margin,
                redius: widget.redius,
                icon: Icons.electric_bolt_outlined,
                title: "Total yield",
                text: "45 kWh",
              ),
              SecondaryCardWidget(
                margin: widget.margin,
                redius: widget.redius,
                icon: Icons.electric_meter_outlined,
                title: "Consumption",
                text: "15 kWh",
              ),
            ],
          ),
        ),
      ],
    );
  }

  double radians(double number) {
    return (number * pi) / 180;
  }

  double degrees(double number) {
    return number * (180 / pi);
  }

  void _claculateSunAngles() {
    double long = 31.23;
    double lat = 30;
    int hour = DateTime.now().hour;
    int minutes = DateTime.now().minute;
    // int hour = 9;
    // int minutes = 00;
    int time_zone = 3;
    int current_year = DateTime.now().year;
    int current_month = DateTime.now().month;
    int current_day = DateTime.now().day;
    //--------------------
    var difference = DateTime.utc(current_year, current_month, current_day)
        .difference(DateTime.utc(current_year));
    int days = difference.inDays + 1;
    double day = (360 / 365) * (days - 81);
    double dayR = radians(day);
    double equation_of_time = double.parse(
        (9.87 * sin(2 * dayR) - 7.53 * cos(dayR) - 1.5 * sin(dayR))
            .toStringAsFixed(2));
    double time_correction = 4 * (long - 15 * time_zone) + equation_of_time;
    double local_solar_time =
        ((hour * 60 + minutes) / 60) + (time_correction / 60);
    double hour_angle =
        double.parse((15 * (local_solar_time - 12)).toStringAsFixed(2));
    double declination = double.parse((23.45 * sin(dayR)).toStringAsFixed(2));
    double declination_R = radians(declination);
    double lat_R = radians(lat);
    double hour_angle_R = radians(hour_angle);
    double elevation = asin(sin(declination_R) * sin(lat_R) +
        cos(declination_R) * cos(lat_R) * cos(hour_angle_R));
    double elevation_degrees = degrees(elevation);
    double azimuth = acos((sin(declination_R) * cos(lat_R) -
            cos(declination_R) * sin(lat_R) * cos(hour_angle_R)) /
        cos(elevation));
    double azimuth_degrees = degrees(azimuth);
    StaticValues.azimuth = double.parse(azimuth_degrees.toStringAsFixed(1));
    StaticValues.elevation = double.parse(elevation_degrees.toStringAsFixed(1));
    setState(() {});
  }
}

class SolarPanel extends StatefulWidget {
  const SolarPanel({
    Key? key,
  }) : super(key: key);

  @override
  State<SolarPanel> createState() => _SolarPanelState();
}

class _SolarPanelState extends State<SolarPanel> {
  double value_1 = 0;
  double value_2 = 1;
  List<double> values_1 = [-0.2, -0.5, -0.7, -0.9, -0.7, -0.5, -0.2];

  @override
  void initState() {
    super.initState();
    chan();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 25.0, left: 0),
      child: Transform.scale(
        scaleX: value_2,
        child: Transform.rotate(
          angle: value_1,
          child: SvgPicture.asset(
            "assets/images/solar_panel.svg",
            width: 120,
            height: 120,
          ),
        ),
      ),
    );
  }

  void chan() async {
    for (int i = 0; i < values_1.length; i++) {
      if (StaticValues.moving_mode) {
        double a = StaticValues.solarPanels_angel;
        if (a >= 30 && a < 60) {
          value_1 = values_1[0];
        } else if (a >= 60 && a < 90) {
          value_1 = values_1[1];
        } else if (a >= 90 && a < 120) {
          value_1 = values_1[2];
        } else if (a >= 120 && a < 150) {
          value_1 = values_1[3];
        } else if (a >= 150) {
          value_1 = values_1[5];
        }
        if (a > 90) {
          value_2 = -1;
        } else {
          value_2 = 1;
        }
        if (mounted) await Future.delayed(Duration(seconds: 1));
      } else {
        if (StaticValues.test) {
          value_1 = values_1[i];
          if (i == 6) {
            value_2 = 1;
          }
          if (i >= 3) {
            value_2 = -1;
          } else {
            value_2 = 1;
          }
          if (mounted) await Future.delayed(Duration(seconds: 3));
        } else {
          break;
        }
      }

      if (mounted) {
        setState(() {});
        if (i == 6) {
          i = -1;
        }
      } else {
        break;
      }

      print("solar angel :" + value_1.toString());
    }
  }
}

class BarChart extends StatelessWidget {
  const BarChart({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var customBorder = Border(
      top: BorderSide(
        width: 5,
        color: Color.fromARGB(255, 91, 157, 184),
      ),
      left: BorderSide(
        width: 5,
        color: Color.fromARGB(255, 91, 157, 184),
      ),
      right: BorderSide(
        width: 5,
        color: Color.fromARGB(255, 91, 157, 184),
      ),
    );
    return Expanded(
        child: Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        children: [
          Expanded(
              flex: 9,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(5),
                          topRight: Radius.circular(5)),
                      color: Color.fromARGB(255, 91, 157, 184),
                    ),
                    width: 5,
                    height: double.infinity,
                  ),
                  Spacer(),
                  Container(
                    decoration: BoxDecoration(
                      border: customBorder,
                    ),
                    width: 35,
                    height: 105,
                  ),
                  Spacer(),
                  Container(
                    decoration: BoxDecoration(border: customBorder),
                    width: 35,
                    height: 100,
                  ),
                  Spacer(),
                  Container(
                    decoration: BoxDecoration(border: customBorder),
                    width: 35,
                    height: 110,
                  ),
                  Spacer(),
                ],
              )),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(5),
                  topRight: Radius.circular(5)),
              color: Color.fromARGB(255, 91, 157, 184),
            ),
            width: double.infinity,
            height: 5,
          )
        ],
      ),
    ));
  }
}

class SecondaryCardWidget extends StatelessWidget {
  const SecondaryCardWidget({
    Key? key,
    required this.margin,
    required this.redius,
    required this.icon,
    required this.title,
    required this.text,
  }) : super(key: key);

  final double margin;
  final double redius;
  final IconData icon;
  final String title;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Card(
            margin: EdgeInsets.all(margin),
            elevation: 0,
            clipBehavior: Clip.hardEdge,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(redius)),
            child: Container(
              color: Color.fromARGB(21, 58, 187, 247),
              child: Row(
                children: [
                  Expanded(
                      flex: 4,
                      child: Column(
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Container(
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.white),
                                child: Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: Icon(
                                    icon,
                                    color: Color.fromARGB(255, 24, 206, 238),
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      )),
                  Expanded(
                      flex: 6,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(title),
                          Text(text,
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.bold)),
                        ],
                      )),
                ],
              ),
            )));
  }
}

class SunWidget extends StatefulWidget {
  SunWidget({
    Key? key,
    required this.thewidget,
  }) : super(key: key);
  final _DashboardState thewidget;
  @override
  State<SunWidget> createState() => _SunWidgetState();
}

class _SunWidgetState extends State<SunWidget> {
  double value_x = 100;
  double value_y = 0;
  List<double> values_1 = [120, 60, 30, 0, -40, -60, -90];
  List<double> values_2 = [-20, -50, -65, -60, -55, -30, -20];
  List<double> values_x = [100, 70, 40, 0, -40, -70, -100];
  List<double> values_y = [0, -30, -45, -65, -45, -30, 0];

  @override
  void initState() {
    super.initState();
    _claculateSunAngles();
  }

  @override
  void dispose() {
    // Avoid memory leak (`setState` after dispose) and disconnect

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Transform.translate(
      offset: Offset(value_x, value_y),
      // offset: Offset(-40, -40),
      child: SvgPicture.asset(
        "assets/images/sun.svg",
        width: 50,
        height: 50,
      ),
    );
  }

  double radians(double number) {
    return (number * pi) / 180;
  }

  double degrees(double number) {
    return number * (180 / pi);
  }

  void _claculateSunAngles() async {
    if (StaticValues.test) {
      for (int i = 0; i < values_1.length; i++) {
        value_x = values_x[i];
        value_y = values_y[i];

        if (StaticValues.page == 1) {}
        await Future.delayed(Duration(seconds: 3));
        if (mounted) {
          setState(() {});

          if (i == 6) {
            i = -1;
          }
        } else {
          break;
        }
        if (!StaticValues.test) {
          break;
        }
      }
    } else {
      int hour = DateTime.now().hour;
      int minutes = DateTime.now().minute;

      if (StaticValues.elevation >= 15 && StaticValues.elevation < 40) {
        if (hour > 12) {
          value_x = -100;
        } else {
          value_x = 100;
        }
        value_y = 0;
      } else if (StaticValues.elevation >= 40 && StaticValues.elevation < 60) {
        if (hour > 12) {
          value_x = -70;
        } else {
          value_x = 70;
        }
        value_y = -30;
      } else if (StaticValues.elevation >= 60 && StaticValues.elevation < 80) {
        if (hour > 12) {
          value_x = -40;
        } else {
          value_x = 40;
        }
        value_y = -45;
      } else if (StaticValues.elevation >= 80 && StaticValues.elevation <= 90) {
        value_x = 0;
        value_y = -65;
      } else {
        value_y = -140;
      }

      setState(() {});
    }
    // for (int i = 0; i < values_1.length; i++) {
    //   value_1 = values_x[i];
    //   value_2 = values_y[i];
    //   print(value_1);
    //   print(value_2);
    //   if (StaticValues.page == 1) {}
    //   await Future.delayed(Duration(seconds: 3));
    //   if (mounted) {
    //     setState(() {});
    //     if (i == 6) {
    //       i = -1;
    //     }
    //   }
    // }
  }
}

class InfoCard extends StatelessWidget {
  const InfoCard({
    Key? key,
    required this.margin,
    required this.redius,
    required this.icon,
    required this.text,
    required this.color,
  }) : super(key: key);

  final double margin;
  final double redius;
  final IconData icon;
  final String text;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Card(
          margin: EdgeInsets.all(margin),
          elevation: 0,
          clipBehavior: Clip.hardEdge,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(redius + 5)),
          child: Container(
            width: double.infinity,
            color: Colors.white,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  icon,
                  color: color,
                ),
                Text(
                  text,
                )
              ],
            ),
          )),
    );
  }
}
