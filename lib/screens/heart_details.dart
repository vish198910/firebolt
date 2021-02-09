import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HeartData extends StatefulWidget {
  @override
  _HeartDataState createState() => _HeartDataState();
}

class _HeartDataState extends State<HeartData> {
  DateTime todaysDate = DateTime.now();

  _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      builder: (BuildContext context, Widget child) {
        return Theme(
          data: Theme.of(context).copyWith(
            primaryColor: Colors.black,
            accentColor: Colors.black,
            colorScheme: ColorScheme.light(primary: Colors.black),
          ),
          child: child,
        );
      },
      initialDate: todaysDate, // Refer step 1
      firstDate: DateTime(2000),
      lastDate: DateTime(2025),
    );
    if (picked != null && picked != todaysDate)
      setState(() {
        todaysDate = picked;
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("HR"),
        centerTitle: true,
        backgroundColor: Colors.black,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                    child: Text(
                  "${todaysDate.year}-${todaysDate.month}-${todaysDate.day}",
                  style: TextStyle(
                    fontSize: 25,
                  ),
                )),
                Container(
                  child: GestureDetector(
                    onTap: () {
                      _selectDate(context);
                    },
                    child: FaIcon(
                      FontAwesomeIcons.calendar,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            child: Column(
              children: [
                FaIcon(
                  FontAwesomeIcons.satelliteDish,
                  size: 100,
                ),
                Text(
                  "No Data !",
                  style: TextStyle(
                    fontSize: 40,
                  ),
                )
              ],
            ),
          ),
          Column(
            children: [
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      child: Column(
                        children: [
                          Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "--",
                                  style: TextStyle(fontSize: 30),
                                )
                              ],
                            ),
                          ),
                          Container(
                              child: Text(
                            "Sleep Avg HR",
                            style: TextStyle(
                              fontSize: 15,
                            ),
                          )),
                        ],
                      ),
                    ),
                    Container(
                      child: Column(
                        children: [
                          Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "--",
                                  style: TextStyle(fontSize: 30),
                                )
                              ],
                            ),
                          ),
                          Container(
                              child: Text(
                            "Average HR",
                            style: TextStyle(
                              fontSize: 15,
                            ),
                          )),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    child: Column(
                      children: [
                        Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "--",
                                style: TextStyle(fontSize: 30),
                              )
                            ],
                          ),
                        ),
                        Container(
                            child: Text(
                          "Highest HR",
                          style: TextStyle(
                            fontSize: 15,
                          ),
                        )),
                      ],
                    ),
                  ),
                  Container(
                    child: Column(
                      children: [
                        Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "--",
                                style: TextStyle(fontSize: 30),
                              )
                            ],
                          ),
                        ),
                        Container(
                            child: Text(
                          "Lowest HR",
                          style: TextStyle(
                            fontSize: 15,
                          ),
                        )),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
