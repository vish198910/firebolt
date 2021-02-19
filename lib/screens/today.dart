import 'package:firebolt/screens/heart_details.dart';
import 'package:firebolt/screens/measurements.dart';
import 'package:firebolt/screens/sleep_details.dart';
import 'package:firebolt/screens/walk_details.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Today extends StatefulWidget {
  String email;
  Today({this.email});
  @override
  _TodayState createState() => _TodayState();
}

class _TodayState extends State<Today> {
  double _currentSliderValue = 20;

  
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              color: Colors.black,
              child: Center(
                child: Stack(
                  children: [
                    Center(
                      child: Container(
                        width: MediaQuery.of(context).size.height / 4,
                        height: MediaQuery.of(context).size.height / 4,
                        decoration: new BoxDecoration(
                          gradient: RadialGradient(colors: [
                            Colors.black,
                            Colors.black,
                            Colors.black,
                            Colors.black,
                            Colors.black,
                            Colors.black,
                            Colors.black,
                            Colors.white.withOpacity(0.1),
                            Colors.white.withOpacity(0.4),
                            Colors.white.withOpacity(0.3),
                            Colors.white.withOpacity(0.2),
                            Colors.black,
                            Colors.white,
                          ]),
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                    Center(
                      child: Text(
                        "Measurement",
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                    ),
                  ],
                ),
              ),
              height: 250,
            ),
            Container(
              color: Colors.black,
              child: Padding(
                padding: const EdgeInsets.only(
                  left: 15,
                  right: 15,
                  bottom: 20,
                ),
                child: Column(
                  children: [
                    Slider(
                      value: _currentSliderValue,
                      min: 0,
                      max: 100,
                      divisions: 3,
                      activeColor: Colors.white,
                      onChanged: (double value) {
                        setState(() {
                          _currentSliderValue = value;
                        });
                      },
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Column(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(10),
                                  bottomLeft: Radius.circular(10),
                                ),
                                color: Colors.orangeAccent,
                              ),
                              height: 10,
                              width: 100,
                            ),
                            Center(
                              child: Text(
                                "General      70",
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            )
                          ],
                        ),
                        Column(
                          children: [
                            Container(
                              height: 10,
                              width: 100,
                              decoration: BoxDecoration(
                                color: Colors.yellow,
                              ),
                            ),
                            Center(
                              child: Text(
                                "    Good        90",
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            )
                          ],
                        ),
                        Column(
                          children: [
                            Container(
                              height: 10,
                              width: 100,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                  bottomRight: Radius.circular(10),
                                  topRight: Radius.circular(10),
                                ),
                                color: Colors.lightGreenAccent,
                              ),
                            ),
                            Center(
                              child: Text(
                                "Optimal",
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                color: Colors.grey.shade100,
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (BuildContext context) {
                              return MeasurementData();
                            },
                          ),
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.white,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Column(
                                  children: [
                                    Icon(
                                      Icons.timer,
                                      color: Colors.redAccent,
                                    ),
                                    Text("Measurement"),
                                  ],
                                ),
                                Text("BP 0 mmHg 0 mmHg"),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (BuildContext context) {
                                  return SportData();
                                },
                              ),
                            );
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: Container(
                              width: 100,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.white,
                              ),
                              height: 200,
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  FaIcon(
                                    FontAwesomeIcons.walking,
                                    color: Colors.orange,
                                  ),
                                  Text("Sport"),
                                  Text("0"),
                                  Text("0"),
                                  Text("0")
                                ],
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (BuildContext context) {
                                  return SleepData(
                                    email: widget.email,
                                  );
                                },
                              ),
                            );
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: Container(
                              width: 100,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.white,
                              ),
                              height: 200,
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  FaIcon(
                                    FontAwesomeIcons.moon,
                                    color: Colors.purple,
                                  ),
                                  Text("Sleep"),
                                  Text("0"),
                                  Text("0"),
                                  Text("0")
                                ],
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (BuildContext context) {
                                  return HeartData();
                                },
                              ),
                            );
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.white,
                              ),
                              width: 100,
                              height: 200,
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  FaIcon(
                                    FontAwesomeIcons.heartbeat,
                                    color: Colors.pinkAccent,
                                  ),
                                  Text("HR"),
                                  Text("0"),
                                  Text("0"),
                                  Text("0")
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
                height: 300,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
