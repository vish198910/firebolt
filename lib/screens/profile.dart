import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebolt/screens/operating_instructions.dart';
import 'package:firebolt/screens/sleep_target.dart';
import 'package:firebolt/screens/steps_target.dart';
import 'package:firebolt/services/usermngmt.dart';
import 'package:firebolt/style/color.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Profile extends StatefulWidget {
  final email;
  Profile({this.email});
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  UserManagement user = new UserManagement();

  int targetSteps = 0;

  fetchSteps(email) {}

  @override
  Widget build(BuildContext context) {
    Stream users = FirebaseFirestore.instance
        .collection('users')
        .doc(widget.email)
        .snapshots();

    Stream steps = FirebaseFirestore.instance
        .collection('users')
        .doc(widget.email)
        .collection("fitness")
        .doc("stepsData")
        .snapshots();

    Stream sleepTime = FirebaseFirestore.instance
        .collection('users')
        .doc(widget.email)
        .collection("fitness")
        .doc("sleepData")
        .snapshots();

    return Scaffold(
      appBar: AppBar(
        title: Text("Me"),
        centerTitle: true,
        backgroundColor: Colors.black,
        actions: [
          GestureDetector(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(Icons.logout),
              ),
              onTap: () {
                user.signOut();
              })
        ],
      ),
      body: Column(
        children: [
          StreamBuilder<DocumentSnapshot>(
            stream: users,
            builder: (BuildContext context,
                AsyncSnapshot<DocumentSnapshot> snapshot) {
              if (snapshot.hasError) {
                return Text('Something went wrong');
              }

              if (snapshot.connectionState == ConnectionState.waiting) {
                return Text("Loading");
              }

              return ListTile(
                leading: GestureDetector(
                    child: CircleAvatar(
                  child: Image.asset("images/logo.png"),
                )),
                title: Text(
                    "${snapshot.data.data()["name"].toString().toUpperCase()}"),
                subtitle: Text("${widget.email}"),
              );
            },
          ),
          GestureDetector(
            child: ListTile(
              leading: Icon(Icons.add),
              title: Text("Connect a device"),
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (BuildContext context) {
                return StepsTarget(
                  email: widget.email,
                );
              }));
            },
            child: ListTile(
              leading: FaIcon(FontAwesomeIcons.stepForward),
              title: Text("Target"),
              trailing: StreamBuilder<DocumentSnapshot>(
                builder: (BuildContext context,
                    AsyncSnapshot<DocumentSnapshot> snapshot) {
                  if (snapshot.hasError) {
                    return Text('Something went wrong');
                  }

                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Text("Loading");
                  }

                  return Text(
                      "${snapshot.data.data()["steps_target"].toString().toUpperCase()} steps",
                      style: TextStyle(color: boltPrimaryColor));
                },
                stream: steps,
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (BuildContext context) {
                return SleepTarget(
                  email: widget.email,
                );
              }));
            },
            child: ListTile(
              leading: FaIcon(FontAwesomeIcons.moon),
              title: Text("Sleep Target"),
              trailing: StreamBuilder<DocumentSnapshot>(
                builder: (BuildContext context,
                    AsyncSnapshot<DocumentSnapshot> snapshot) {
                  if (snapshot.hasError) {
                    return Text('Something went wrong');
                  }

                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Text("Loading");
                  }

                  return Text(
                    "${snapshot.data.data()["sleep_hours"]} Hours" +
                        " ${snapshot.data.data()["sleep_minutes"]} Minutes",
                    style: TextStyle(
                      color: boltPrimaryColor,
                    ),
                  );
                },
                stream: sleepTime,
              ),
            ),
          ),
          GestureDetector(
            child: ListTile(
              leading: Icon(Icons.settings),
              title: Text("Device Management"),
            ),
          ),
          GestureDetector(
            child: ListTile(
              leading: Icon(Icons.camera),
              title: Text("Shake Snapshot"),
            ),
          ),
          GestureDetector(
            child: ListTile(
              leading: Icon(Icons.search),
              title: Text("Find device"),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (BuildContext context) {
                  return OperatingInstructions(
                    email: widget.email,
                  );
                }),
              );
            },
            child: ListTile(
              leading: Icon(Icons.info),
              title: Text("Operating Instructions"),
            ),
          ),
        ],
      ),
    );
  }
}
