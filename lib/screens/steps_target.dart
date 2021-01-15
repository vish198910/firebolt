import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class StepsTarget extends StatefulWidget {
  final email;
  StepsTarget({this.email});

  @override
  _StepsTargetState createState() => _StepsTargetState();
}

class _StepsTargetState extends State<StepsTarget> {
  int _selectedItemIndex = 0;
  List stepsList = [];

  @override
  void initState() {
    for (int i = 1000; i <= 30000; i += 1000) {
      stepsList.add(i);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    DocumentReference fitness = FirebaseFirestore.instance
        .collection('users')
        .doc(widget.email)
        .collection("fitness")
        .doc("stepsData");

    Future<void> addUser() {
      // Call the user's CollectionReference to add a new user
      fitness.get().then((DocumentSnapshot documentSnapshot) {
        if (documentSnapshot.exists) {
          print('Document exists on the database');
          return fitness
              .update({
                // Stokes and Sons
                'steps_target': stepsList[_selectedItemIndex] // 42
              })
              .then((value) => print("User Added"))
              .catchError((error) => print("Failed to add user: $error"));
        }
      });
      return fitness
          .set({
            // Stokes and Sons
            'steps_target': stepsList[_selectedItemIndex] // 42
          })
          .then((value) => print("User Added"))
          .catchError((error) => print("Failed to add user: $error"));
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text("Steps Target"),
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
                  "${stepsList[_selectedItemIndex]}",
                  style: TextStyle(fontSize: 40),
                ),
                Text(" steps ")
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
                    width: MediaQuery.of(context).size.width / 2,
                    height: MediaQuery.of(context).size.height / 3,
                    child: ListWheelScrollView(
                      itemExtent: 50,
                      useMagnifier: true,
                      magnification: 1.5,
                      perspective: 0.01,
                      squeeze: 0.6,
                      physics: FixedExtentScrollPhysics(),
                      children: stepsList
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
                          _selectedItemIndex = index;
                        })
                      },
                    ),
                  ),
                  Text(" steps")
                ],
              ),
            ),
            Text("Suggest 8000~10000 steps each day"),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: ButtonTheme(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30)),
                child: RaisedButton(
                  padding: const EdgeInsets.fromLTRB(70, 15, 70, 15),
                  color: Colors.black,
                  textColor: Colors.white,
                  onPressed: addUser,
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
