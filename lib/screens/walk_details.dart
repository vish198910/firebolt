import 'package:firebolt/widgets/period_widget.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SportData extends StatefulWidget {
  @override
  _SportDataState createState() => _SportDataState();
}

class _SportDataState extends State<SportData> {
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
        title: Text("Sport"),
        centerTitle: true,
        backgroundColor: Colors.black,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Container(
            child: Padding(
              padding: const EdgeInsets.only(
                left: 15,
                right: 15,
                bottom: 20,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  PeriodWidget(
                    period: "Day",
                  ),
                  PeriodWidget(
                    period: "Week",
                  ),
                  PeriodWidget(
                    period: "Month",
                  ),
                ],
              ),
            ),
          ),
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
                  child: FaIcon(
                    FontAwesomeIcons.running,
                    size: 40,
                  ),
                ),
              ],
            ),
          ),
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
                        "Completion",
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
                        "kcal",
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
                        "Mileage",
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
          )
        ],
      ),
    );
  }
}

