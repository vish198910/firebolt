import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebolt/screens/sleep_target.dart';
import 'package:firebolt/style/color.dart';
import 'package:firebolt/widgets/period_widget.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SleepData extends StatefulWidget {
  String email;
  SleepData({this.email});
  @override
  _SleepDataState createState() => _SleepDataState();
}

class _SleepDataState extends State<SleepData> {
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
    Stream sleepTime = FirebaseFirestore.instance
        .collection('users')
        .doc(widget.email)
        .collection("fitness")
        .doc("sleepData")
        .snapshots();

    return Scaffold(
      appBar: AppBar(
        title: Text("Sleep"),
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
            child: Column(
              children: [
                Text(
                  "-- h -- m",
                  style: TextStyle(
                    fontSize: 25,
                  ),
                ),
                Text("Total Sleep Time")
              ],
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
                              "- - h",
                              style: TextStyle(fontSize: 25),
                            )
                          ],
                        ),
                      ),
                      Container(
                          child: Text(
                        "Deep",
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
                              "- - h",
                              style: TextStyle(fontSize: 25),
                            )
                          ],
                        ),
                      ),
                      Container(
                          child: Text(
                        "Light",
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
                              "- - h",
                              style: TextStyle(fontSize: 25),
                            )
                          ],
                        ),
                      ),
                      Container(
                          child: Text(
                        "Stay Up",
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
            child: StreamBuilder<DocumentSnapshot>(
              builder: (BuildContext context,
                  AsyncSnapshot<DocumentSnapshot> snapshot) {
                if (snapshot.hasError) {
                  return Text('Something went wrong');
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Text("Loading");
                }

                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      "Sleep Target: ",
                      style: TextStyle(fontSize: 20),
                    ),
                    Text(
                      "${snapshot.data.data() != null ? snapshot.data.data()["sleep_hours"] : ''} Hours" +
                          " ${snapshot.data.data() != null ? snapshot.data.data()["sleep_minutes"] : ''} Minutes",
                      style: TextStyle(
                        color: boltPrimaryColor,
                      ),
                    ),
                  ],
                );
              },
              stream: sleepTime,
            ),
          ),
        ],
      ),
    );
  }
}
