import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class SleepTarget extends StatefulWidget {
  final email;
  SleepTarget({this.email});

  @override
  _SleepTargetState createState() => _SleepTargetState();
}

class _SleepTargetState extends State<SleepTarget> {
  int _selectedHour = 0;
  int _selectedMinute = 0;
  List sleepHours = [];
  List sleepMinutes = [];

  @override
  void initState() {
    for (int i = 1; i <= 10; i += 1) {
      sleepHours.add(i);
    }
    for (int i = 0; i <= 60; i += 1) {
      sleepMinutes.add(i);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    DocumentReference fitness = FirebaseFirestore.instance
        .collection('users')
        .doc(widget.email)
        .collection("fitness")
        .doc("sleepData");

    addSleep() {
      // Call the user's CollectionReference to add a new user
      fitness.get().then((DocumentSnapshot documentSnapshot) {
        if (documentSnapshot.exists) {
          print('Document exists on the database');
          return fitness
              .update({
                // Stokes and Sons
                'sleep_hours': sleepHours[_selectedHour],
                "sleep_minutes": sleepMinutes[_selectedMinute], // 42
              })
              .then((value) => print("Sleep Time Target Added"))
              .catchError(
                  (error) => print("Failed to add sleep Time Target: $error"));
        }
      });
      fitness
          .set({
            // Stokes and Sons
            'sleep_hours': sleepHours[_selectedHour],
            "sleep_minutes": sleepMinutes[_selectedMinute], // 42
          })
          .then((value) => print("Sleep Time Added"))
          .catchError((error) => print("Failed to add sleep: $error"));
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text("Sleep Target"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "${sleepHours[_selectedHour]}",
                  style: TextStyle(fontSize: 40),
                ),
                Text(" ${sleepHours[_selectedHour] == 1 ? 'Hour' : 'Hours'} "),
                Text(
                  "${sleepMinutes[_selectedMinute]}",
                  style: TextStyle(fontSize: 40),
                ),
                Text(
                    " ${sleepMinutes[_selectedMinute] == 1 ? 'Minute' : 'Minutes'} ")
              ],
            ),
            Container(
              decoration: BoxDecoration(
                  border: Border.all(
                    width: 1,
                    color: Colors.grey,
                  ),
                  borderRadius: BorderRadius.circular(20)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width / 4,
                    height: MediaQuery.of(context).size.height / 3,
                    child: ListWheelScrollView(
                      itemExtent: 50,
                      useMagnifier: true,
                      magnification: 1.5,
                      perspective: 0.01,
                      squeeze: 0.6,
                      physics: FixedExtentScrollPhysics(),
                      children: sleepHours
                          .map(
                            (item) => Container(
                              decoration: BoxDecoration(
                                  border: Border.all(
                                    width: 0.5,
                                  ),
                                  borderRadius: BorderRadius.circular(20)),
                              child: ListTile(
                                  title: Center(child: Text(item.toString()))),
                            ),
                          )
                          .toList(),
                      onSelectedItemChanged: (index) => {
                        setState(() {
                          _selectedHour = index;
                        })
                      },
                    ),
                  ),
                  Text("H"),
                  Container(
                    width: MediaQuery.of(context).size.width / 4,
                    height: MediaQuery.of(context).size.height / 3,
                    child: ListWheelScrollView(
                      itemExtent: 50,
                      useMagnifier: true,
                      magnification: 1.5,
                      perspective: 0.01,
                      squeeze: 0.6,
                      physics: FixedExtentScrollPhysics(),
                      children: sleepMinutes
                          .map(
                            (item) => Container(
                              decoration: BoxDecoration(
                                  border: Border.all(
                                    width: 0.5,
                                  ),
                                  borderRadius: BorderRadius.circular(20)),
                              child: ListTile(
                                  title: Center(child: Text(item.toString()))),
                            ),
                          )
                          .toList(),
                      onSelectedItemChanged: (index) => {
                        setState(() {
                          _selectedMinute = index;
                        })
                      },
                    ),
                  ),
                  Text("M"),
                ],
              ),
            ),
            Text("Suggest 7~9 hours of sleep each day"),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: ButtonTheme(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30)),
                child: RaisedButton(
                  padding: const EdgeInsets.fromLTRB(70, 15, 70, 15),
                  color: Colors.black,
                  textColor: Colors.white,
                  onPressed: () {
                    addSleep();
                    Navigator.pop(context);
                  },
                  child: Text("Confirm"),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
